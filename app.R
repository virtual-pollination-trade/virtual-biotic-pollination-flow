source("./global.R")

ui <- fluidPage(

  # path to google analytics
  tags$head(includeHTML(("www/google-analytics.html"))),

  # path css file
  theme = "style.css",

  # Application title
  titlePanel("Virtual Biotic Pollination Flow"),

  # Sidebar with a slider input for number of bins
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

      actionButton("make_plot", "Create map")

    ),

    # Show a plot of the generated distribution
    mainPanel(

      plotOutput(outputId = "map", height = "700px", width = "100%"),

      verbatimTextOutput(outputId = "report")

    )
  ),
  # tags$p("Silva *et al.*, 2019...")
)

server <- function(input, output) {
  
  message("\n\nLoading server ...\n\n")

  # TODO: Create reactive objects 
  # BODY: The filtered data need to be reactive objects to be used into differents
  #       parts of output.
  #       see: https://stackoverflow.com/a/19466838
  
  output$map <- renderPlot({

    input$make_plot

    req(input$origin)
    req(input$destination)
    
    message("Checking input variables ...\n\n")
    
    print(input$origin)
    print(input$destination)
    print(input$year)
    print(input$colormap)

    withProgress(

      message = "Creating map ...", {
      
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
      usethis::ui_todo("Creating map ...\n\n")

      make_plot_by_input_colormap(
        data_filtered = virtual_pollinators_flow_filtered,
        data_sf = country_features_with_sf_geometry,
        data_year = vp_flow_year,
        input_colormap = input$colormap,
        input_origin = input$origin,
        input_destination = input$destination 
      )

    })
    
    cat("\n")
    usethis::ui_done("Map done!\n\n")

  })

  # output$report <-
  #   renderText({
  #     
  #   })

}

# Run the application
shinyApp(ui = ui, server = server)
