#' Reorder country names and create a vector variable for the input panel
#'
#' @param data raw data
#' @param countries_type reporter or partner countries
#'
#' @importFrom dplyr select distinct pull
#'
#' @return an ordered vector
#'
#' @export
#'
distinct_input_select_countries <- function(data, countries_type) {

  data %>%
    dplyr::select({{ countries_type }}) %>%
    dplyr::distinct() %>%
    dplyr::pull() %>%
    {
      c("All countries", sort(.))
    }

}
