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
