#' Read vp_flow data
#'
#' @return a tibble
#'
#' @importFrom here here
#' @importFrom qs qread
#'
#' @export
#'
read_vp_flow_data <- function() {

  here::here("inst", "extdata", "virtual-pollinators-flow.qs") %>%
    qs::qread()

}
