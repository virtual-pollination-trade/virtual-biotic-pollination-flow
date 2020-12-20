#' Read country features data
#'
#' @return a object of class sf
#'
#' @import here
#' @import qs
#'
#' @export
#'
read_sf_data <- function() {

  here::here("inst", "extdata", "country-features-with-sf-geometry.qs") %>%
    qread() %>%
    mutate(
      hdi = case_when(
        admin == "Antarctica" ~ NA_real_,
        admin == "Greenland" ~ NA_real_,
        TRUE ~ as.numeric(hdi)
      ),
      hdi = if_else(hdi == 0, NA_real_, hdi)
    )

}
