message("\nLoading global.R file ...\n")

message("\tLoading packages ...\n")
suppressPackageStartupMessages({
  library(shiny)
  library(dplyr)
  library(ggplot2)
  library(here)
  library(usethis)
  library(qs)
  library(glue)
  library(sf)
  library(scales)
  library(shinythemes)
  library(DT)
})

message("\tLoading local_functions.R file ...\n")
source(here("R", "local_functions.R"))

message("\tLoading modules.R file ...\n")
source(here("R", "modules.R"))

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
