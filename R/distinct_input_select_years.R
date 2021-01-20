#' Reorder years and create a vector variable for the input panel
#'
#' @param data raw data
#'
#' @importFrom dplyr select arrange distinct pull
#'
#' @return an ordered vector
#'
#' @export
#'
distinct_input_select_years <- function(data) {

  data %>%
    dplyr::select(year) %>%
    dplyr::arrange(year) %>%
    dplyr::distinct() %>%
    dplyr::pull() %>%
    {
      c("All years", .)
    }

}
