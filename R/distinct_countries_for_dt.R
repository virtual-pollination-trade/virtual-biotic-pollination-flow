#' Create output table filtering countries and year to be showed in DT
#'
#' @param data_raw raw data
#' @param input_origin input origin
#' @param input_destination input destination
#' @param input_year input year
#'
#' @import dplyr
#'
#' @return a filtered tibble
#' @export
#'
distinct_countries_for_dt <- function(data_raw, input_origin, input_destination, input_year) {

  df_temp <-
    data_raw %>%
    filter_countries_by_input_select_countries(input_origin, input_destination) %>%
    filter_countries_by_input_select_year(input_year)

  unique_origin <- unique(df_temp$reporter_countries)
  unique_destination <- unique(df_temp$partner_countries)

  if (input_year == "All years") {

    df_result <-
      data_raw %>%
      filter(
        reporter_countries %in% unique_origin,
        partner_countries %in% unique_destination
      ) %>%
      group_by(
        reporter_countries,
        partner_countries
      ) %>%
      summarise(
        vp_flow = sum(vp_flow),
      ) %>%
      arrange(desc(vp_flow)) %>%
      ungroup() %>%
      filter(vp_flow > 0) %>%
      mutate(vp_flow = round(vp_flow, 1)) %>%
      rename(
        "Exporting country" = reporter_countries,
        "Importing country" = partner_countries,
        "Virtual Biotic Pollination Flow (tons)" = vp_flow
      )

  } else {

    df_result <-
      data_raw %>%
      filter(
        reporter_countries %in% unique_origin,
        partner_countries %in% unique_destination,
        year %in% input_year
      ) %>%
      group_by(
        reporter_countries,
        partner_countries,
        year
      ) %>%
      summarise(
        vp_flow = sum(vp_flow),
      ) %>%
      arrange(desc(vp_flow)) %>%
      ungroup() %>%
      filter(vp_flow > 0) %>%
      mutate(vp_flow = round(vp_flow, 1)) %>%
      rename(
        "Exporting country" = reporter_countries,
        "Importing country" = partner_countries,
        Year = year,
        "Virtual Biotic Pollination Flow (tons)" = vp_flow
      )

  }

  return(df_result)

}
