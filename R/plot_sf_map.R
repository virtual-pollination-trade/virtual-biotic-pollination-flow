#' Create base map for the plot in the output panel
#'
#' @param data_sf the sf object read by `read_sf_data()`
#' @param filled_by the colormap choosed in the input panel
#'
#' @importFrom ggplot2 ggplot geom_sf ylim aes scale_fill_gradientn labs
#'
#' @return a sf object
#'
#' @export
#'
plot_sf_map <- function(data_sf, filled_by) {

  if (filled_by == "None") {

    map <-
      data_sf %>%
      ggplot2::ggplot() +
      ggplot2::geom_sf() +
      ggplot2::ylim(c(-100, 100))

  }

  if (filled_by == "HDI") {

    hdi_fill_colors <- c("yellow", "orange")

    map <-
      data_sf %>%
      ggplot2::ggplot() +
      ggplot2::geom_sf(ggplot2::aes(fill = hdi)) +
      ggplot2::scale_fill_gradientn(
        colours = hdi_fill_colors,
        na.value = "white",
        guide = "colourbar"
      ) +
      ggplot2::labs(fill = "HDI") +
      ggplot2::ylim(c(-100, 100))

  }

  return(map)

}
