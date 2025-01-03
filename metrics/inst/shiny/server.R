server <- function(input, output, session) {
  invacost_data <- read.csv("www/invacost_data.csv")

  # Dynamically load options for species and countries
  observe({
    updateSelectizeInput(session, "species", choices = species, server = TRUE)
  })

  observe({
    updateSelectizeInput(session, "country", choices = countries, server = TRUE)
  })

  # Reactive data table (data_table) creation
  table_data <- reactive({
    req(input$submit)  # Do not process until the submit button is clicked

    # Retrieve user inputs
    req(input$species, input$country, input$social_perception,
        input$health_impact, input$ecosystem_impact,
        input$ecology_impact, input$reversibility_impact)

    species_name <- input$species
    country_name <- input$country
    social_perception <- input$social_perception
    health_impact <- input$health_impact
    ecosystem_impact <- input$ecosystem_impact
    ecology_impact <- input$ecology_impact
    reversibility_impact <- input$reversibility_impact

    # Combine data using relevant functions
    total_cost <- get_total_cost_by_species(species_name, invacost_data)
    cost_by_country <- get_cost_by_species_country(species_name, country_name, invacost_data)
    total_obs <- get_observation_count_by_species(species_name)
    obs_by_country <- get_obs_count_by_species_country(species_name, convert_country_name_to_code(country_name))
    abundance_impact <- get_abundance_type(total_obs, "text")
    abundance_impact_country <- get_abundance_type(obs_by_country, "text")

    # Return data as a dataframe
    data.frame(
      Species = species_name,
      Country = country_name,
      Total_Cost_Billion_USD = total_cost,
      Country_Cost_Billion_USD = cost_by_country,
      Total_Observations = total_obs,
      Country_Observations = obs_by_country,
      Social_Perception = social_perception,
      Health_Impact = health_impact,
      Ecosystem_Impact = ecosystem_impact,
      Ecology_Impact = ecology_impact,
      Reversibility_Impact = reversibility_impact,
      Abundance_Impact = abundance_impact,
      Abundance_Impact_Country = abundance_impact_country
    )
  })

  # Display the data table
  output$data_table <- DT::renderDataTable({
    req(table_data())  # Load reactive data table
  })
  # Radar 1 Chart Logic
  observeEvent(input$radar1_button, {
    output$radar_chart_1 <- renderPlot({
      req(table_data())  # Tablo verileri mevcut olmalı
      radar_data_1 <- create_radar_chart(table_data())
      area_1 <- calculate_radar_area(radar_data_1)  # Alanı hesapla
      paste("Radar Chart 1 Area:", round(area_1, 2)) # Radar 1 grafiğini çizer (ve aynı anda vektör döndürür)
    })

    output$area_output_1 <- renderText({
      radar_data_1 <- create_radar_chart(table_data())  # Vektörü al
      req(radar_data_1)  # Vektör boş olmamalı
      area_1 <- calculate_radar_area(radar_data_1)  # Alanı hesapla
      paste("Radar Chart 1 Area:", round(area_1, 2))  # Alanı yazdır
    })
  })

  # Radar 2 Chart Logic
  observeEvent(input$radar2_button, {
    output$radar_chart_2 <- renderPlot({
      req(table_data())  # Tablo verileri mevcut olmalı
      create_country_radar_chart(table_data())  # Radar 2 grafiğini çizer (ve aynı anda vektör döndürür)
    })

    output$area_output_2 <- renderText({
      radar_data_2 <- create_country_radar_chart(table_data())  # Vektörü al
      req(radar_data_2)  # Vektör boş olmamalı
      area_2 <- calculate_radar_area(radar_data_2)  # Alanı hesapla
      paste("Radar Chart 2 Area:", round(area_2, 2))  # Alanı yazdır
    })
  })

  # Display error message if required inputs are missing
  observeEvent(input$submit, {
    if (is.null(input$species) || is.null(input$country)) {
      showModal(modalDialog(
        title = "Input Error",
        "Please make sure to select both a species and a country before submitting.",
        easyClose = TRUE,
        footer = NULL
      ))
    }
  })
}
