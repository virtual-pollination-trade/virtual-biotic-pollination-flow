#' Create the final plot
#'
#' @param virtual_pollinators_flow_filtered the filtered data which already
#' passed by `distinct_countries()` and by `summarise_vp_flow_all_years()`,
#' if choosed in the input panel
#' @param base_world_map the sf object created by `plot_sf_map()`
#'
#' @importFrom dplyr mutate distinct
#' @importFrom ggplot2 geom_curve aes arrow unit geom_point scale_colour_gradientn guides guide_colourbar theme_void theme element_text margin labs annotate
#' @importFrom ggtext element_markdown
#' @importFrom grDevices hcl.colors
#' @importFrom scales comma_format breaks_extended
#'
#' @return a ggplot object: the final plot
#'
#' @export
#'
vp_flow_arrows_plot <- function(virtual_pollinators_flow_filtered, base_world_map) {

  virtual_pollinators_plot <-
    base_world_map +
    ggplot2::geom_curve(
      data = virtual_pollinators_flow_filtered %>%
        dplyr::mutate(vp_flow = log(vp_flow + 1)),
      ggplot2::aes(
        x = reporter_long,
        y = reporter_lat,
        xend = partner_long,
        yend = partner_lat,
        colour = vp_flow,
      ),
      angle = 90,
      size = 1,
      arrow = ggplot2::arrow(length = ggplot2::unit(0.2, "cm")),
      lineend = "butt",
      inherit.aes = TRUE
    ) +
    ggplot2::geom_point(
      data = virtual_pollinators_flow_filtered %>%
        dplyr::distinct(reporter_countries, reporter_long, reporter_lat),
      ggplot2::aes(x = reporter_long, y = reporter_lat),
      col = "black",
      alpha = 0.7
    ) +
    ggplot2::scale_colour_gradientn(
      colours = grDevices::hcl.colors(
        n = 10,
        palette = "RdYlBu",
        alpha = 0.5,
        rev = FALSE
      ),
      labels = scales::comma_format(),
      n.breaks = 10,
      breaks = scales::breaks_extended(n = 10),
      guide = "colourbar"
    ) +
    ggplot2::guides(
      colour = ggplot2::guide_colourbar(barheight = 10, order = 1),
      fill = ggplot2::guide_colourbar(barheight = 10, order = 2)
    ) +
    ggplot2::theme_void(
      base_size = 14,
      base_family = "Arial"
    ) +
    ggplot2::theme(
      legend.position = "right",
      legend.direction = "vertical",
      legend.justification = "center",
      legend.title = ggtext::element_markdown(),
      legend.text = ggplot2::element_text(size = 16),
      legend.spacing = ggplot2::unit(0.5, "cm"),
      legend.spacing.y = ggplot2::unit(0.5, "cm"),
      legend.margin = ggplot2::margin(1, 1, 1, 1)
    ) +
    ggplot2::labs(
      color = "<span style='font-size:20pt'>Virtual Biotic</span><br>
               <span style='font-size:20pt'>Pollination Flow</span><br>
               <span style='font-size:12pt'> (color scheme applied to</span><br>
               <span style='font-size:12pt'>logarithmized values*)</span>",
      caption = "Original data on international market was obtained from www.fao.org/faostat/en/#data/TM"
    ) +
    ggplot2::annotate(
      geom = "text",
      x = 140,
      y = -100,
      label = "* Check original values in the Data tab"
    )

  if (nrow(virtual_pollinators_flow_filtered) == 1) {

    virtual_pollinators_plot <-
      virtual_pollinators_plot +
      ggplot2::scale_colour_gradientn(
        colours = grDevices::hcl.colors(
          n = 2,
          palette = "RdYlBu",
          alpha = 0.5,
          rev = FALSE
        ),
        labels = scales::comma_format(),
        n.breaks = 1,
        breaks = scales::breaks_extended(n = 1),
        guide = "colourbar"
      )

  }

  print(virtual_pollinators_plot)

}
