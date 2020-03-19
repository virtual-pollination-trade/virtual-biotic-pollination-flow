suppressWarnings({
  theme_set(
    theme_void(
      base_size = 14,
      base_family = "Arial"
    ) +
      theme(
        legend.position = "bottom",
        legend.direction = "vertical",
        legend.justification = "center",
        legend.title = element_text(size = 20),
        legend.text = element_text(size = 20)
      )
  )
})

read_vp_flow_data <- function() {
  
  here::here("data", "virtual-pollinators-flow.qs") %>%
    qread() %>%
    filter(item_code != 0) %>%
    .[.$reporter_countries != .$partner_countries, ]
  
}

read_sf_data <- function() {
  
  here::here("data", "country-features-with-sf-geometry.qs") %>%
    qread()
  
}

distinct_countries <- function(df) {

  df %>%
    group_by(
      reporter_countries,
      partner_countries,
      reporter_long,
      reporter_lat,
      reporter_hdi,
      partner_long,
      partner_lat,
      partner_hdi,
      year
    ) %>%
    summarise(
      vp_flow = sum(vp_flow),
    ) %>%
    filter(vp_flow > 0) %>%
    arrange(vp_flow)

}

summarise_vp_flow_all_years <- function(df) {

  df %>%
    group_by(
      reporter_countries,
      partner_countries,
      reporter_long,
      reporter_lat,
      reporter_hdi,
      partner_long,
      partner_lat,
      partner_hdi,
    ) %>%
    summarise(
      vp_flow = sum(vp_flow),
    ) %>%
    filter(vp_flow > 0) %>%
    arrange(vp_flow) %>%
    ungroup()

}

summarise_vpflow_and_join <- function(df) {

  vp_flow_total <-
    df %>%
    group_by(reporter_countries, partner_countries) %>%
    summarise(vp_flow_total = sum(vp_flow)) %>%
    ungroup()

  summarised_and_joined <-
    full_join(
      x = df,
      y = vp_flow_total,
      by = c("reporter_countries", "partner_countries")
    ) %>%
    arrange(vp_flow_total)

  return(summarised_and_joined)

}

min_max_vp_flow_by_input_year <- function(df, year) {

  df %>%
    distinct_countries() %>%
    group_by(year) %>%
    summarise(
      vp_flow_min = min(vp_flow),
      vp_flow_max = max(vp_flow)
    ) %>%
    filter(year %in% {{ year }})

}

min_max_vp_flow_all_years <- function(df) {

  df %>%
    filter(vp_flow > 0) %>%
    summarise(
      vp_flow_min = min(vp_flow),
      vp_flow_max = max(vp_flow)
    )

}


plot_sf_map <- function(country_features_with_sf_geometry, filled_by) {
  
  if (filled_by == "None") {
    
    map <- 
      country_features_with_sf_geometry %>%
      ggplot() +
      geom_sf() +
      ylim(c(-100, 100))
    
  }
  
  if (filled_by == "HDI") {
    
    hdi_fill_colors <- c("yellow", "orange")
    
    map <- 
      country_features_with_sf_geometry %>%
      ggplot() +
      geom_sf(aes(fill = hdi)) +
      scale_fill_gradientn(
        colours = hdi_fill_colors,
        # limits = c(0, 1)
      ) +
      labs(fill = "HDI\n") +
      ylim(c(-100, 100))
  }
  
  return(map)
  
}

vp_flow_arrows_plot <- function(virtual_pollinators_flow_filtered, base_world_map, vp_flow_year) {
  
  virtual_pollinators_plot <-
    base_world_map +
    geom_curve(
      data = virtual_pollinators_flow_filtered,
      aes(
        x = reporter_long,
        y = reporter_lat,
        xend = partner_long,
        yend = partner_lat,
        colour = vp_flow,
        alpha = vp_flow
      ),
      angle = 90,
      # alpha = 0.6,
      size = 1,
      arrow = arrow(length = unit(0.2, "cm")),
      lineend = "butt",
      # colour = "dark blue",
      inherit.aes = TRUE
    ) +
    geom_point(
      data = virtual_pollinators_flow_filtered,
      aes(x = reporter_long, y = reporter_lat),
      col = "black"
    ) +
    # scale_color_distiller(palette = "Spectral", label = comma_format()) +
    scale_color_gradient(
      n.breaks = 10,
      low = "light blue",
      high = "dark blue",
      label = comma_format(),
      limits = c(vp_flow_year$vp_flow_min, vp_flow_year$vp_flow_max)
    ) +
    scale_alpha(
      n.breaks = 10,
      range = c(0.1, 1),
      label = comma_format(accuracy = 10),
      limits = c(vp_flow_year$vp_flow_min, vp_flow_year$vp_flow_max)
    ) +
    guides(
      alpha = guide_legend(
        reverse = TRUE, 
        override.aes = list(
          size = 2, 
          shape = 22, 
          fill = "blue"
        )
      )
    ) +
    labs(colour = "Virtual Biotic\nPollination Flow (tons)")
  
  print(virtual_pollinators_plot)
  
}

no_vp_flow <- function(origin, destination) {
  
  plot(
    x = 1:10,
    type = "n",
    xaxt = "n",
    yaxt = "n",
    ann = FALSE,
    frame.plot = FALSE
  )
  
  text(
    x = 5.5,
    y = 5.5,
    labels = paste(
      origin, "don't share virtual flux with", destination
    ),
    cex = 2.5
  )
  
}
