message("\nLoading global.R file ...\n")

message("\tLoading packages ...\n")
suppressPackageStartupMessages({
  # Web Application Framework for R
  library(shiny) # CRAN v1.5.0
  # A Grammar of Data Manipulation
  library(dplyr) # CRAN v0.8.5
  # Create Elegant Data Visualisations Using the Grammar of Graphics
  library(ggplot2) # CRAN v3.3.2
  # A Simpler Way to Find Your Files
  library(here) # CRAN v0.1
  # Automate Package and Project Setup
  library(usethis) # CRAN v1.6.1
  # Quick Serialization of R Objects
  library(qs) # CRAN v0.22.1
  # Interpreted String Literals
  library(glue) # CRAN v1.4.0
  # Simple Features for R
  library(sf) # CRAN v0.9-4
  # Scale Functions for Visualization
  library(scales) # CRAN v1.1.1
  # Themes for Shiny
  library(shinythemes) # CRAN v1.1.2
  # A Wrapper of the JavaScript Library 'DataTables'
  library(DT) # CRAN v0.14
  # Create Dashboards with 'Shiny'
  library(shinydashboard) # CRAN v0.7.1
  # Automate Package and Project Setup
  library(usethis) # CRAN v1.6.1
  # Improved text rendering support for ggplot2
  library(ggtext) # CRAN v0.1.0
})

message("\tLoading functions...\n")

for (func in list.files(path = "R", full.names = TRUE)) {
  source(func)
}

message("\tLoading data ...\n")
virtual_pollinators_flow <-
  read_vp_flow_data()

country_features_with_sf_geometry <-
  read_sf_data()

message("\tLoading variables for input panel ...\n")
origin_select_input <-
  virtual_pollinators_flow %>%
  distinct_input_select_countries(countries_type = reporter_countries)

destination_select_input <-
  virtual_pollinators_flow %>%
  distinct_input_select_countries(countries_type = partner_countries)

year_select_input <-
  virtual_pollinators_flow %>%
  distinct_input_select_years()

colormap_select_input <-
  c("None", "HDI")
