message("\t\tLoadind modules ...\n")

#' Filter countries by input selection
#'
#' @param data_raw Data raw
#' @param input_origin Input reporter_countries
#' @param input_destination Input partner_countries
#'
#' @return a filtered tibble
#' @export
#'
filter_countries_by_input_select_countries <- function(data_raw, input_origin, input_destination) {
  
  origin <- input_origin
  destination <- input_destination
  
  countries_field_empty <-
    !(length(origin) == 1L &&
        nzchar(origin)) &&
    !(length(destination) == 1L &&
        nzchar(destination))
  
  all_countries <-
    origin == "All countries" &&
    destination == "All countries"
  
  all_countries_reporter <-
    origin == "All countries" &&
    destination != "All countries"
  
  all_countries_partner <-
    origin != "All countries" &&
    destination == "All countries"
  
  countries_field_filled <-
    origin != "All countries" &&
    destination != "All countries"
  
  if (countries_field_empty) {
    
    data_filtered <-
      data_raw %>%
      distinct_countries()
    
  }
  
  if (all_countries) {
    
    data_filtered <-
      data_raw %>%
      distinct_countries()
    
  }
  
  if (all_countries_reporter) {
    
    data_filtered <-
      data_raw %>%
      filter(
        partner_countries %in% destination
      ) %>%
      distinct_countries()
    
  }
  
  if (all_countries_partner) {
    
    data_filtered <-
      data_raw %>%
      filter(
        reporter_countries %in% origin
      ) %>%
      distinct_countries()
    
  }
  
  if (countries_field_filled) {
    
    data_filtered <-
      data_raw %>%
      filter(
        reporter_countries %in% origin,
        partner_countries %in% destination
      ) %>%
      distinct_countries()
    
  }
  
  return(data_filtered)
  
}


#' Filter values based on year
#'
#' @param data_filtered_by_countries a pre filtered tibble resulting from \code{filter_countries_by_input_select_countries()}
#' @param input_year Input year
#'
#' @return a refiltered tibble
#' @export
#'
filter_countries_by_input_select_year <- function(data_filtered_by_countries, input_year) {
  
  if (input_year == "All years") {
    
    data_filtered_by_year <-
      data_filtered_by_countries %>%
      summarise_vp_flow_all_years()
    
  } else {
    
    data_filtered_by_year <-
      data_filtered_by_countries %>%
      filter(year == input_year)
    
  }
  
  return(data_filtered_by_year)
  
}


#' Filter and create a tibble with the minimum and maximum values of vp_flow 
#' to used at plot colors scale
#'
#' @param data_raw data rae
#' @param input_year input year
#'
#' @return a filtered tibble
#' @export
#'
filter_year_by_input_select_year <- function(data_raw, input_year) {
  
  if (input_year == "All years") {
    
    vp_flow_year <-
      data_raw %>%
      summarise_vp_flow_all_years() %>%
      min_max_vp_flow_by_input_year(year = input_year)
    
  } else {
    
    vp_flow_year <-
      data_raw %>%
      min_max_vp_flow_by_input_year(year = input_year)
    
  }
  
  return(vp_flow_year)
  
}


#' High-order function the plot the final maps
#'
#' @param data_filtered prefiltered tibble
#' @param data_sf sf data
#' @param data_year prefiltered tibble with min and max vp_flow values 
#' @param input_colormap input colormap
#' @param input_origin input reporter_countries
#' @param input_destination input partner_countries
#'
#' @return a map
#' @export
#'
make_plot_by_input_colormap <- 
  function(
    data_filtered, 
    data_sf, 
    data_year, 
    input_colormap, 
    input_origin, 
    input_destination
  ) {
  
  if (input_colormap == "None") {
    
    base_world_map <-
      plot_sf_map(data_sf, filled_by = "None")
    
  }
  
  if (input_colormap == "HDI") {
    
    base_world_map <-
      plot_sf_map(data_sf, filled_by = "HDI")
    
  }
  
  if (nrow(data_filtered) != 0) {
    
    vp_flow_arrows_plot(
      data_filtered, 
      base_world_map, 
      data_year
    )
    
  } else {
    # TODO: Better error message when there is not shared vp_flow
    # BODY: see https://shiny.rstudio.com/articles/validation.html
    no_vp_flow()
    
  }
  
}
