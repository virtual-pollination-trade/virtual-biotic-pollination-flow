message("\nLoading global.R file ...\n")
message("\tLoading packages ...\n")
suppressPackageStartupMessages({
  library(shiny)
  library(tidyverse)
  library(fs)
  library(here)
  library(usethis)
  library(qs)
  library(glue)
  library(sf)
  library(scales)
})

message("\tLoading local_functions.R file ...\n")
source(here("R", "local_functions.R"), local = TRUE)

message("\tLoading modules.R file ...\n")
source(here("R", "modules.R"), local = TRUE)

message("\tLoading data ...\n")
virtual_pollinators_flow <-
  read_vp_flow_data()

country_features_with_sf_geometry <-
  read_sf_data()

message("\tLoading variables for input panel ...\n")
origin_select_input <- 
  virtual_pollinators_flow %>%
  select(reporter_countries) %>%
  distinct() %>%
  pull() %>%
  c("All countries", .) %>% 
  sort()

destination_select_input <- 
  virtual_pollinators_flow %>%
  select(partner_countries) %>%
  distinct() %>%
  pull() %>%
  c("All countries", .) %>% 
  sort()

year_select_input <- 
  virtual_pollinators_flow %>%
  select(year) %>%
  arrange(year) %>%
  distinct() %>%
  pull() %>%
  c("All years", .)

colormap_select_input <- 
  c("None", "HDI")
