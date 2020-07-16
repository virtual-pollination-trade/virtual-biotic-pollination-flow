source("./global.R", local = TRUE)

input <- list()
input$origin <- c("United States of America", "China", "Brazil")
input$destination <- "All countries"
input$year <- "All years"
input$colormap <- "HDI"

############################################################
#                                                          #
#                    same app structure                    #
#                                                          #
############################################################

message("Checking input variables ...\n\n")

ui_info("origin: {ui_code(input$origin)}")
ui_info("destination: {ui_code(input$destination)}")
ui_info("year: {ui_code(input$year)}")
ui_info("colormap: {ui_code(input$colormap)}")

message("\n\nFiltering countries in virtual_pollinators_flow...\n\n")

virtual_pollinators_flow_filtered <-
  virtual_pollinators_flow %>%
  filter_countries_by_input_select_countries(
    input_origin = input$origin,
    input_destination = input$destination
  ) %>%
  filter_countries_by_input_select_year(input_year = input$year)

message("Checking lowest `vp_flow` values ...\n\n")

virtual_pollinators_flow_filtered %>%
  select(reporter_countries, partner_countries, vp_flow) %>%
  head() %>%
  print()

message("\n\nChecking highest `vp_flow` values ...\n\n")

virtual_pollinators_flow_filtered %>%
  select(reporter_countries, partner_countries, vp_flow) %>%
  tail() %>%
  print()

message("\n\nFiltering years ...\n\n")

vp_flow_year <-
  virtual_pollinators_flow %>%
  filter_year_by_input_select_year(input$year)

message("Checking filtered year(s) ...\n\n")

vp_flow_year %>%
  print()

cat("\n\n")
ui_todo("Creating map ...\n\n")

make_plot_by_input_colormap(
  data_filtered = virtual_pollinators_flow_filtered,
  data_sf = country_features_with_sf_geometry,
  data_year = vp_flow_year,
  input_colormap = input$colormap,
  input_origin = input$origin,
  input_destination = input$destination
)

cat("\n")
ui_done("Map done!\n\n")

############################################################
#                                                          #
#              fixing test after update data               #
#                                                          #
############################################################
# devtools::load_all()

# test_file("tests/testthat/test-distinct_countries_for_dt.R")
# test_file("tests/testthat/test-distinct_countries.R")
# test_file("tests/testthat/test-distinct_input_select_countries.R")
# test_file("tests/testthat/test-distinct_input_select_years.R")
# test_file("tests/testthat/test-filter_countries_by_input_select_countries.R")
# test_file("tests/testthat/test-filter_countries_by_input_select_year.R")
# test_file("tests/testthat/test-filter_year_by_input_select_year.R")
# test_file("tests/testthat/test-min_max_vp_flow_by_input_year.R")
# test_file("tests/testthat/test-no_vp_flow.R")
# test_file("tests/testthat/test-sf_data_content.R")
# test_file("tests/testthat/test-summarise_vp_flow_all_years.R")
# test_file("tests/testthat/test-vp_flow_data_content.R")
