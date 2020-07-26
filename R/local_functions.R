message("\t\tLoading functions ...\n")

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

#' Filter distinct report and partner countries
#'
#' @param data raw data
#'
#' @return a filtered tibble
#'
#' @import dplyr
#'
#' @export
#'
distinct_countries <- function(data) {
  data %>%
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
    arrange(vp_flow) %>%
    ungroup()
}

#' Summarise vp_flow data for all years
#'
#' @description Used when all years are choosed in the input panel
#'
#' @param data filtered data by `distinct_countries()`
#'
#' @return a tibble
#'
#' @import dplyr
#'
#' @export
#'
summarise_vp_flow_all_years <- function(data) {
  data %>%
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

#' Summarise minimum and maximum values of vp_flow for the choosed years
#' in the input panel
#'
#' @param data filtered data
#' @param year choosed year in the input panel
#'
#' @import dplyr
#'
#' @return a tibble
#'
#' @export
#'
min_max_vp_flow_by_input_year <- function(data, year) {
  if (year == "All years") {
    min_max_vp_flow <-
      data %>%
      filter(vp_flow > 0) %>%
      summarise(
        vp_flow_min = min(vp_flow),
        vp_flow_max = max(vp_flow)
      )
  } else {
    min_max_vp_flow <-
      data %>%
      distinct_countries() %>%
      group_by(year) %>%
      summarise(
        vp_flow_min = min(vp_flow),
        vp_flow_max = max(vp_flow)
      ) %>%
      filter(year %in% {{ year }}) %>%
      ungroup()
  }

  return(min_max_vp_flow)
}


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

#' Informs when countries doesn't have relationships
#'
#' @import graphics
#'
#' @return a plot
#'
#' @export
#'
no_vp_flow <- function() {
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
    y = 7.5,
    labels = paste(
      "These countries do not share virtual biotic pollination flow."
    ),
    cex = 2.5
  )
}

#' Reorder country names and create a vector variable for the input panel
#'
#' @param data raw data
#' @param countries_type reporter or partner countries
#'
#' @import dplyr
#'
#' @return an ordered vector
#'
#' @export
#'
distinct_input_select_countries <- function(data, countries_type) {
  data %>%
    select({{ countries_type }}) %>%
    distinct() %>%
    pull() %>%
    {
      c("All countries", sort(.))
    }
}

#' Reorder years and create a vector variable for the input panel
#'
#' @param data raw data
#'
#' @import dplyr
#'
#' @return an ordered vector
#'
#' @export
#'
distinct_input_select_years <- function(data) {
  data %>%
    select(year) %>%
    arrange(year) %>%
    distinct() %>%
    pull() %>%
    {
      c("All years", .)
    }
}


#' Create output table filtering countries and year to be showed in DT
#'
#' @param data_raw raw data
#' @param input_origin input origin
#' @param input_destination input destination
#' @param input_year input year
#'
#' @import dplyr
#'
#' @return a filtered tibble
#' @export
#'
distinct_countries_for_dt <- function(data_raw, input_origin, input_destination, input_year) {
  df_temp <-
    data_raw %>%
    filter_countries_by_input_select_countries(input_origin, input_destination) %>%
    filter_countries_by_input_select_year(input_year)

  unique_origin <- unique(df_temp$reporter_countries)
  unique_destination <- unique(df_temp$partner_countries)

  if (input_year == "All years") {
    df_result <-
      data_raw %>%
      filter(
        reporter_countries %in% unique_origin,
        partner_countries %in% unique_destination
      ) %>%
      group_by(
        reporter_countries,
        partner_countries
      ) %>%
      summarise(
        vp_flow = sum(vp_flow),
      ) %>%
      arrange(desc(vp_flow)) %>%
      ungroup() %>%
      filter(vp_flow > 0) %>%
      mutate(vp_flow = round(vp_flow, 1)) %>%
      rename(
        "Exporting country" = reporter_countries,
        "Importing country" = partner_countries,
        "Virtual Biotic Pollination Flow (tons)" = vp_flow
      )
  } else {
    df_result <-
      data_raw %>%
      filter(
        reporter_countries %in% unique_origin,
        partner_countries %in% unique_destination,
        year %in% input_year
      ) %>%
      group_by(
        reporter_countries,
        partner_countries,
        year
      ) %>%
      summarise(
        vp_flow = sum(vp_flow),
      ) %>%
      arrange(desc(vp_flow)) %>%
      ungroup() %>%
      filter(vp_flow > 0) %>%
      mutate(vp_flow = round(vp_flow, 1)) %>%
      rename(
        "Exporting country" = reporter_countries,
        "Importing country" = partner_countries,
        Year = year,
        "Virtual Biotic Pollination Flow (tons)" = vp_flow
      )
  }

  return(df_result)
}
