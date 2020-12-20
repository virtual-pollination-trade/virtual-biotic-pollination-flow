#' Reorder years and create a vector variable for the input panel
#'
#' @param data raw data
#'
#' @import dplyr
#'
#' @return an ordered vector
#'
#' @export
#'
distinct_input_select_years <- function(data) {

  data %>%
    select(year) %>%
    arrange(year) %>%
    distinct() %>%
    pull() %>%
    {
      c("All years", .)
    }

}
