#' Read country features data
#'
#' @return a object of class sf
#'
#' @importFrom dplyr mutate case_when if_else
#' @importFrom here here
#' @importFrom qs qread
#'
#' @export
#'
read_sf_data <- function() {

  here::here("inst", "extdata", "country-features-with-sf-geometry.qs") %>%
    qs::qread() %>%
    dplyr::mutate(
      hdi = dplyr::case_when(
        admin == "Antarctica" ~ NA_real_,
        admin == "Greenland" ~ NA_real_,
        TRUE ~ as.numeric(hdi)
      ),
      hdi = dplyr::if_else(hdi == 0, NA_real_, hdi)
    )

}
