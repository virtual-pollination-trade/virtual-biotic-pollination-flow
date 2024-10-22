% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/vp_flow_arrows_plot.R
\name{vp_flow_arrows_plot}
\alias{vp_flow_arrows_plot}
\title{Create the final plot}
\usage{
vp_flow_arrows_plot(virtual_pollinators_flow_filtered, base_world_map)
}
\arguments{
\item{virtual_pollinators_flow_filtered}{the filtered data which already
passed by `distinct_countries()` and by `summarise_vp_flow_all_years()`,
if choosed in the input panel}

\item{base_world_map}{the sf object created by `plot_sf_map()`}
}
\value{
a ggplot object: the final plot
}
\description{
Create the final plot
}
