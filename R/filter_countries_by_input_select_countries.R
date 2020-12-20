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
