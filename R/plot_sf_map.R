#' Create base map for the plot in the output panel
#'
#' @param data_sf the sf object read by `read_sf_data()`
#' @param filled_by the colormap choosed in the input panel
#'
#' @import ggplot2
#' @import sf
#'
#' @return a sf object
#'
#' @export
#'
plot_sf_map <- function(data_sf, filled_by) {

  if (filled_by == "None") {

    map <-
      data_sf %>%
      ggplot() +
      geom_sf() +
      ylim(c(-100, 100))

  }

  if (filled_by == "HDI") {

    hdi_fill_colors <- c("yellow", "orange")

    map <-
      data_sf %>%
      ggplot() +
      geom_sf(aes(fill = hdi)) +
      scale_fill_gradientn(
        colours = hdi_fill_colors,
        na.value = "white",
        guide = "colourbar"
      ) +
      labs(fill = "HDI") +
      ylim(c(-100, 100))

  }

  return(map)

}
