#' Filter distinct report and partner countries
#'
#' @param data raw data
#'
#' @return a filtered tibble
#'
#' @import dplyr
#'
#' @export
#'
distinct_countries <- function(data) {

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
      year
    ) %>%
    summarise(
      vp_flow = sum(vp_flow),
    ) %>%
    filter(vp_flow > 0) %>%
    arrange(vp_flow) %>%
    ungroup()

}
