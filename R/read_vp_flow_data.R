#' Read vp_flow data
#'
#' @return a tibble
#'
#' @import here
#' @import qs
#' @import dplyr
#'
#' @export
#'
read_vp_flow_data <- function() {

  here::here("inst", "extdata", "virtual-pollinators-flow.qs") %>%
    qread()

}
