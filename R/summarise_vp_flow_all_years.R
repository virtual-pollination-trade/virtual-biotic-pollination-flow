#' Summarise vp_flow data for all years
#'
#' @description Used when all years are choosed in the input panel
#'
#' @param data filtered data by `distinct_countries()`
#'
#' @return a tibble
#'
#' @import dplyr
#'
#' @export
#'
summarise_vp_flow_all_years <- function(data) {

  data %>%
    group_by(
      reporter_countries,
      partner_countries,
      reporter_long,
      reporter_lat,
      reporter_hdi,
      partner_long,
      partner_lat,
      partner_hdi,
    ) %>%
    summarise(
      vp_flow = sum(vp_flow),
    ) %>%
    filter(vp_flow > 0) %>%
    arrange(vp_flow) %>%
    ungroup()

}
