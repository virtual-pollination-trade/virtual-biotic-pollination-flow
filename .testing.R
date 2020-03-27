source("./global.R", local = TRUE)

input <- list()
input$origin <- "United States of America"
input$destination <- "All countries"
input$year <- "All years"
input$colormap <- "HDI"

############################################################
#                                                          #
#                    same app structure                    #
#                                                          #
############################################################

message("Checking input variables ...\n\n")

print(input$origin)
print(input$destination)
print(input$year)
print(input$colormap)

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

