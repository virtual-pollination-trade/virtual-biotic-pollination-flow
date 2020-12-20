#' Summarise minimum and maximum values of vp_flow for the choosed years
#' in the input panel
#'
#' @param data filtered data
#' @param year choosed year in the input panel
#'
#' @import dplyr
#'
#' @return a tibble
#'
#' @export
#'
min_max_vp_flow_by_input_year <- function(data, year) {

  if (year == "All years") {

    min_max_vp_flow <-
      data %>%
      filter(vp_flow > 0) %>%
      summarise(
        vp_flow_min = min(vp_flow),
        vp_flow_max = max(vp_flow)
      )

  } else {

    min_max_vp_flow <-
      data %>%
      distinct_countries() %>%
      group_by(year) %>%
      summarise(
        vp_flow_min = min(vp_flow),
        vp_flow_max = max(vp_flow)
      ) %>%
      filter(year %in% {{ year }}) %>%
      ungroup()

  }

  return(min_max_vp_flow)

}
