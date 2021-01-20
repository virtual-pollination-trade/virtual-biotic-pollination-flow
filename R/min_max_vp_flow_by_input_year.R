#' Summarise minimum and maximum values of vp_flow for the choosed years
#' in the input panel
#'
#' @param data filtered data
#' @param year choosed year in the input panel
#'
#' @importFrom dplyr filter summarise group_by ungroup
#'
#' @return a tibble
#'
#' @export
#'
min_max_vp_flow_by_input_year <- function(data, year) {

  if (year == "All years") {

    min_max_vp_flow <-
      data %>%
      dplyr::filter(vp_flow > 0) %>%
      dplyr::summarise(
        vp_flow_min = min(vp_flow),
        vp_flow_max = max(vp_flow)
      )

  } else {

    min_max_vp_flow <-
      data %>%
      distinct_countries() %>%
      dplyr::group_by(year) %>%
      dplyr::summarise(
        vp_flow_min = min(vp_flow),
        vp_flow_max = max(vp_flow)
      ) %>%
      dplyr::filter(year %in% {{ year }}) %>%
      dplyr::ungroup()

  }

  return(min_max_vp_flow)

}
