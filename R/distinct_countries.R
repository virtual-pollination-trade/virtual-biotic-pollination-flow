#' Filter distinct report and partner countries
#'
#' @param data raw data
#'
#' @return a filtered tibble
#'
#' @importFrom dplyr group_by summarise filter arrange ungroup
#'
#' @export
#'
distinct_countries <- function(data) {

  data %>%
    dplyr::group_by(
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
    dplyr::summarise(
      vp_flow = sum(vp_flow),
    ) %>%
    dplyr::filter(vp_flow > 0) %>%
    dplyr::arrange(vp_flow) %>%
    dplyr::ungroup()

}
