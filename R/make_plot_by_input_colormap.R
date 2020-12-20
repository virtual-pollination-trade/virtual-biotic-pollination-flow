#' High-order function to plot the final maps
#'
#' @param data_filtered prefiltered tibble
#' @param data_sf sf data
#' @param data_year prefiltered tibble with min and max vp_flow values
#' @param input_colormap input colormap
#' @param input_origin input reporter_countries
#' @param input_destination input partner_countries
#'
#' @return a map
#' @export
#'
make_plot_by_input_colormap <- function(data_filtered, data_sf, data_year, input_colormap, input_origin, input_destination) {

    if (input_colormap == "None") {

      base_world_map <-
        plot_sf_map(data_sf, filled_by = "None")

    }

    if (input_colormap == "HDI") {

      base_world_map <-
        plot_sf_map(data_sf, filled_by = "HDI")

    }

    if (nrow(data_filtered) != 0) {

      vp_flow_arrows_plot(
        data_filtered,
        base_world_map,
        data_year
      )

    } else {

      # TODO: Better error message when there is not shared vp_flow
      # BODY: see https://shiny.rstudio.com/articles/validation.html
      no_vp_flow()

    }

  }
