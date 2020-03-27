source("./global.R")

ui <- fluidPage(

  # path google analytics
  tags$head(includeHTML(("www/google-analytics.html"))),

  # path css file
  # theme = shinytheme("united"),

  # Application title
  titlePanel("Virtual Biotic Pollination Flow"),

  # Sidebar application menu
  sidebarLayout(

    sidebarPanel(
      width = 3,

      selectInput(
        inputId = "origin",
        label = "Exporting country",
        choices = origin_select_input,
        multiple = TRUE,
        selected = "United States of America",
        selectize = TRUE
      ),

      selectInput(
        inputId = "destination",
        label = "Import country",
        choices = destination_select_input,
        multiple = TRUE,
        selected = "All countries",
        selectize = TRUE
      ),

      selectInput(
        inputId = "year",
        label = "Year",
        choices = year_select_input,
        selected = "All years",
        selectize = TRUE
      ),

      selectInput(
        inputId = "colormap",
        label = "Socioeconomic aspect",
        choices = colormap_select_input,
        selected = "None",
        selectize = TRUE
      ),

      actionButton(inputId = "make_plot", label = "Reload map", icon("sync-alt")),
      
      downloadButton(outputId = "download_map", label = "Download map")

    ),

    # Show map
    mainPanel(

      plotOutput(outputId = "map", height = "700px", width = "100%"),

      verbatimTextOutput(outputId = "report")

    )
  ),
  # tags$p("Silva *et al.*, 2019...")
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

      message = "Creating map ...", {
        
      message("Checking input variables ...\n\n")
      
      print(input$origin)
      print(input$destination)
      print(input$year)
      print(input$colormap)

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
      
    })
    
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
      
      ggsave(filename = file, plot = plotInput())
      
      cat("\n")
      usethis::ui_done("Map saved!\n\n")
      
    })

}

# Run the application
shinyApp(ui = ui, server = server)
