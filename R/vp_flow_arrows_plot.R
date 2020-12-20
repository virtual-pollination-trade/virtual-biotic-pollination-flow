#' Create the final plot
#'
#' @param virtual_pollinators_flow_filtered the filtered data which already
#' passed by `distinct_countries()` and by `summarise_vp_flow_all_years()`,
#' if choosed in the input panel
#' @param base_world_map the sf object created by `plot_sf_map()`
#' @param vp_flow_year  the filtered data created by `min_max_vp_flow_by_input_year()`
#'
#' @import ggplot2
#' @import scales
#' @importFrom grDevices hcl.colors
#' @importFrom ggtext element_markdown
#'
#' @return a ggplot object: the final plot
#'
#' @export
#'
vp_flow_arrows_plot <- function(virtual_pollinators_flow_filtered, base_world_map, vp_flow_year) {

  virtual_pollinators_plot <-
    base_world_map +
    geom_curve(
      data = virtual_pollinators_flow_filtered %>%
        mutate(vp_flow = log(vp_flow + 1)),
      aes(
        x = reporter_long,
        y = reporter_lat,
        xend = partner_long,
        yend = partner_lat,
        colour = vp_flow,
      ),
      angle = 90,
      size = 1,
      arrow = arrow(length = unit(0.2, "cm")),
      lineend = "butt",
      inherit.aes = TRUE
    ) +
    geom_point(
      data = virtual_pollinators_flow_filtered,
      aes(x = reporter_long, y = reporter_lat),
      col = "black"
    ) +
    scale_colour_gradientn(
      colours = hcl.colors(
        n = 10,
        palette = "RdYlBu",
        alpha = 0.5,
        rev = FALSE
      ),
      labels = comma_format(),
      n.breaks = 10,
      breaks = breaks_extended(n = 10),
      guide = "colourbar"
    ) +
    guides(
      colour = guide_colourbar(barheight = 10, order = 1),
      fill = guide_colourbar(barheight = 10, order = 2)
    ) +
    theme_void(
      base_size = 14,
      base_family = "Arial"
    ) +
    theme(
      legend.position = "right",
      legend.direction = "vertical",
      legend.justification = "center",
      legend.title = element_markdown(),
      legend.text = element_text(size = 16),
      legend.spacing = unit(0.5, "cm"),
      legend.spacing.y = unit(0.5, "cm"),
      legend.margin = margin(1, 1, 1, 1)
    ) +
    labs(
      color = "<span style='font-size:20pt'>Virtual Biotic</span><br>
               <span style='font-size:20pt'>Pollination Flow</span><br>
               <span style='font-size:12pt'> (color scheme applied to</span><br>
               <span style='font-size:12pt'>logarithmized values*)</span>",
      caption = "Original data on international market was obtained from www.fao.org/faostat/en/#data/TM"
    ) +
    annotate(
      geom = "text",
      x = 160,
      y = -100,
      label = "* Check original values in the Data tab"
    )

  if (nrow(virtual_pollinators_flow_filtered) == 1) {

    virtual_pollinators_plot <-
      virtual_pollinators_plot +
      scale_colour_gradientn(
        colours = hcl.colors(
          n = 2,
          palette = "RdYlBu",
          alpha = 0.5,
          rev = FALSE
        ),
        labels = comma_format(),
        n.breaks = 1,
        breaks = breaks_extended(n = 1),
        guide = "colourbar"
      )

  }

  print(virtual_pollinators_plot)

}
