#' Reorder country names and create a vector variable for the input panel
#'
#' @param data raw data
#' @param countries_type reporter or partner countries
#'
#' @import dplyr
#'
#' @return an ordered vector
#'
#' @export
#'
distinct_input_select_countries <- function(data, countries_type) {

  data %>%
    select({{ countries_type }}) %>%
    distinct() %>%
    pull() %>%
    {
      c("All countries", sort(.))
    }

}
