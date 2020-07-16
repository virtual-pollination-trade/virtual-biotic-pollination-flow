source("./global.R")

column_width <- 3

ui <-
  navbarPage(
    title = "Virtual Biotic Pollination Flow",

    collapsible = TRUE,

    inverse = TRUE,

    theme = shinytheme("paper"),

    tabPanel(
      title = "Map",

      fluidPage(
        tags$head(includeHTML(("www/google-analytics.html"))),

        fluidRow(
          column(
            width = column_width,

            wellPanel(
              selectInput(
                inputId = "origin",
                label = "Exporting country",
                choices = origin_select_input,
                multiple = TRUE,
                selected = "United States of America",
                selectize = TRUE
              )
            )
          ),

          column(
            width = column_width,

            wellPanel(
              selectInput(
                inputId = "destination",
                label = "Import country",
                choices = destination_select_input,
                multiple = TRUE,
                selected = "All countries",
                selectize = TRUE
              )
            )
          ),

          column(
            width = column_width,

            wellPanel(
              selectInput(
                inputId = "year",
                label = "Year",
                choices = year_select_input,
                selected = "All years",
                selectize = TRUE
              )
            )
          ),

          column(
            width = column_width,

            wellPanel(
              selectInput(
                inputId = "colormap",
                label = "Socioeconomic aspect",
                choices = colormap_select_input,
                selected = "None", selectize = TRUE
              )
            )
          )
        ),

        mainPanel(
          align = "center",

          plotOutput(
            outputId = "map",
            width = "1200px",
            height = "600px"
          ),

          verbatimTextOutput(
            outputId = "report"
          )
        )
      ),

      fixedRow(
        align = "right",

        column(
          width = 12,

          offset = 0,

          actionButton(
            inputId = "make_plot", label = "Reload map", icon("sync-alt")
          ),

          downloadButton(
            outputId = "download_map", label = "Download map"
          )
        )
      )
    ),

    tabPanel(
      title = "Data",

      fluidPage(
        mainPanel(
          width = 10,

          align = "center",

          tags$div(
            class = "header",
            # tags$h3("Items shared by countries"),
            tags$h3("Data will be available soon."),
            tags$br()
          ),

          # DT::dataTableOutput("dt_table")
        )
      )
    ),

    tabPanel(
      title = "About",

      align = "center",

      shinydashboard::box(
        align = "center",
        width = 4,
        shiny::includeMarkdown("ABOUT.md")
      )
    )
  )

server <- function(input, output) {
  message("\n\nLoading server ...\n\n")

  virtual_pollinators_flow_filtered <- reactive({
    virtual_pollinators_flow %>%
      filter_countries_by_input_select_countries(
        input_origin = input$origin,
        input_destination = input$destination
      ) %>%
      filter_countries_by_input_select_year(input_year = input$year)
  })

  vp_flow_year <- reactive({
    virtual_pollinators_flow %>%
      filter_year_by_input_select_year(input$year)
  })

  plotInput <- reactive({
    input$make_plot

    data_filtered <- virtual_pollinators_flow_filtered()
    data_sf <- country_features_with_sf_geometry
    data_year <- vp_flow_year()

    make_plot_by_input_colormap(
      data_filtered = data_filtered,
      data_sf = data_sf,
      data_year = data_year,
      input_colormap = input$colormap,
      input_origin = input$origin,
      input_destination = input$destination
    )
  })

  output$map <- renderPlot({
    req(input$origin)
    req(input$destination)

    withProgress(
      message = "Creating map ...",
      {
        message("Checking input variables ...\n\n")

        ui_info("origin: {ui_code(input$origin)}")
        ui_info("destination: {ui_code(input$destination)}")
        ui_info("year: {ui_code(input$year)}")
        ui_info("colormap: {ui_code(input$colormap)}")

        message("\n\nFiltering countries in virtual_pollinators_flow...\n\n")

        message("Checking lowest `vp_flow` values ...\n\n")

        virtual_pollinators_flow_filtered() %>%
          select(reporter_countries, partner_countries, vp_flow) %>%
          head() %>%
          print()

        message("\n\nChecking highest `vp_flow` values ...\n\n")

        virtual_pollinators_flow_filtered() %>%
          select(reporter_countries, partner_countries, vp_flow) %>%
          tail() %>%
          print()

        message("\n\nChecking filtered year(s) ...\n\n")

        vp_flow_year() %>%
          print()

        cat("\n\n")
        usethis::ui_todo("Creating map ...\n\n")

        plotInput()
      }
    )

    cat("\n")
    usethis::ui_done("Map done!\n\n")
  })

  # output$report <-
  #   renderText({
  #
  #   })

  output$download_map <- downloadHandler(
    filename = "flow_map.png",
    content = function(file) {
      usethis::ui_todo("Saving map ...\n\n")

      ggsave(
        filename = file,
        plot = plotInput(),
        width = 50,
        height = 40,
        units = "cm"
      )

      cat("\n")
      usethis::ui_done("Map saved!\n\n")
    }
  )

  output$dt_table <- DT::renderDataTable({
    virtual_pollinators_flow %>%
      distinct_countries_for_dt(
        input$origin,
        input$destination,
        input$year
      ) %>%
      DT::datatable(
        data = .,
        filter = "top",
        options = list(
          columnDefs = list(
            list(
              className = "dt-center"
            )
          ),
          scrollX = TRUE,
          autowidth = TRUE
        ),
        class = "cell-border stripe",
        width = 1000,
        height = 20000
      )
  })
}

# Run the application
shinyApp(ui = ui, server = server)
