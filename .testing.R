library(shiny)
library(tidyverse)
library(fs)
library(here)
library(usethis)
library(qs)
library(glue)
library(sf)
library(scales)

source(here("R", "local_functions.R"))

virtual_pollinators_flow <-
  read_vp_flow_data() %>% 
  filter(reporter_countries == "Brazil", partner_countries == "China")

country_features_with_sf_geometry <-
  read_sf_data()

vp_flow_year <-
  virtual_pollinators_flow %>%
  summarise_vp_flow_all_years() %>%
  min_max_vp_flow_all_years()

base_world_map <-
  plot_sf_map(country_features_with_sf_geometry, filled_by = "HDI")

vp_flow_arrows_plot(virtual_pollinators_flow, base_world_map, vp_flow_year)
