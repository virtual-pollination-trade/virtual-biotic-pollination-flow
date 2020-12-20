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
