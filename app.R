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


source(here("R", "local_functions.R"))

virtual_pollinators_flow <-
  here::here("data", "virtual-pollinators-flow.qs") %>%
  qread() %>%
  filter(item_code != 0) %>%
  .[.$reporter_countries != .$partner_countries, ]

country_features_with_sf_geometry <-
  here::here("data", "country-features-with-sf-geometry.qs") %>%
  qread()

ui <- fluidPage(

  # Application title
  titlePanel("Virtual Biotic Pollination Flow"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(

    sidebarPanel(
      width = 3,

      selectInput(
        inputId = "origin",
        label = "Exporting country",
        choices = virtual_pollinators_flow %>%
                  select(reporter_countries) %>%
                  distinct() %>%
                  pull() %>%
                  c("All countries", .) %>% 
                  sort(),
        multiple = TRUE,
        selected = "United States of America",
        selectize = TRUE
      ),

      selectInput(
        inputId = "destination",
        label = "Import country",
        choices = virtual_pollinators_flow %>%
                  select(partner_countries) %>%
                  distinct() %>%
                  pull() %>%
                  c("All countries", .) %>% 
                  sort(),
        multiple = TRUE,
        selected = "All countries",
        selectize = TRUE
      ),

      selectInput(
        inputId = "year",
        label = "Year",
        choices = virtual_pollinators_flow %>%
                  select(year) %>%
                  arrange(year) %>%
                  distinct() %>%
                  pull() %>%
                  c("All years", .),
        selected = "All years",
        selectize = TRUE
      ),

      selectInput(
        inputId = "colormap",
        label = "Socioeconomic aspect",
        choices = c("None", "HDI"),
        selected = "None",
        selectize = TRUE
      ),

      actionButton("make_plot", "Create map")

    ),

    # Show a plot of the generated distribution
    mainPanel(

      plotOutput(outputId = "map", height = "700px"),

      verbatimTextOutput(outputId = "report")

    )
  )
)

server <- function(input, output) {

  output$map <- renderPlot({

    input$make_plot

    req(input$origin)
    req(input$destination)

    withProgress(

      message = "Creating map...", {

      countries_field_empty <-
        !(length(input$origin) == 1L &&
          nzchar(input$origin)) &&
        !(length(input$destination) == 1L &&
          nzchar(input$destination))

      all_countries <-
        input$origin == "All countries" &&
          input$destination == "All countries"

      all_countries_reporter <-
        input$origin == "All countries" &&
          input$destination != "All countries"

      all_countries_partner <-
        input$origin != "All countries" &&
          input$destination == "All countries"

      countries_field_filled <-
        input$origin != "All countries" &&
          input$destination != "All countries"

      if (countries_field_empty) {

        virtual_pollinators_flow_filtered <-
          virtual_pollinators_flow %>%
          distinct_countries()

      }

      if (all_countries) {

        virtual_pollinators_flow_filtered <-
          virtual_pollinators_flow %>%
          distinct_countries()

      }

      if (all_countries_reporter) {

        virtual_pollinators_flow_filtered <-
          virtual_pollinators_flow %>%
          filter(
            partner_countries %in% input$destination
          ) %>%
          distinct_countries()

      }

      if (all_countries_partner) {

        virtual_pollinators_flow_filtered <-
          virtual_pollinators_flow %>%
          filter(
            reporter_countries %in% input$origin
          ) %>%
          distinct_countries()

      }

      if (countries_field_filled) {

        virtual_pollinators_flow_filtered <-
          virtual_pollinators_flow %>%
          filter(
            reporter_countries %in% input$origin,
            partner_countries %in% input$destination
          ) %>%
          distinct_countries()

      }

      if (input$year == "All years") {

        virtual_pollinators_flow_filtered <-
          virtual_pollinators_flow_filtered %>%
          summarise_vp_flow_all_years()

        vp_flow_year <-
          virtual_pollinators_flow %>%
          summarise_vp_flow_all_years() %>%
          min_max_vp_flow_all_years()

      } else {

        virtual_pollinators_flow_filtered <-
          virtual_pollinators_flow_filtered %>%
          filter(year == input$year)

        vp_flow_year <-
          virtual_pollinators_flow %>%
          min_max_vp_flow_by_input_year(year = input$year)

      }

      usethis::ui_todo("Creating map...")

      if (input$colormap == "None") {

        base_world_map <-
          plot_sf_map(country_features_with_sf_geometry, filled_by = "None")

      }

      if (input$colormap == "HDI") {
        
        base_world_map <-
          plot_sf_map(country_features_with_sf_geometry, filled_by = "HDI")

      }

      if (nrow(virtual_pollinators_flow_filtered) != 0) {

        vp_flow_arrows_plot(
          virtual_pollinators_flow_filtered, 
          base_world_map, 
          vp_flow_year
        )
        
      } else {

        no_vp_flow(input$origin, input$destination)

      }

    })

    usethis::ui_done("Map done!")

  })

  # output$report <-
  #   renderText({
  #
  #   })

}

# Run the application
shinyApp(ui = ui, server = server)
