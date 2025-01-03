# library(shiny)
# library(shinydashboard)
#
# #source("../../R/choices.R")
#
# ui <- dashboardPage(
#   dashboardHeader(
#     title = tags$div(
#       style = "display: flex; align-items: left;",  # Flexbox ile hizalama
#       tags$img(src = "logo.jpg", height = "40px", style = "margin-right: 10px;"),  # Logo
#       "Invader Metrics"  # Başlık
#     )
#   ),
#
#   dashboardSidebar(
#     sidebarMenu(
#       menuItem("Inputs and Visualization", tabName = "inputs", icon = icon("sliders")),
#       menuItem("About", tabName = "about", icon = icon("info-circle")) # About sekmesi
#     )
#   ),
#
#   dashboardBody(
#     tabItems(
#       # Inputs and Visualization tab
#       tabItem(
#         tabName = "inputs",
#         fluidRow(
#           # Select species and country
#           box(
#             title = "Select Species and Country",
#             width = 6,
#             selectizeInput(
#               "species",
#               "Select Species",
#               choices = NULL,
#               selected = NULL,
#               multiple = FALSE,
#               options = list(placeholder = "Type to search species...")
#             ),
#             selectizeInput(
#               "country",
#               "Select Country",
#               choices = NULL,
#               selected = NULL,
#               multiple = FALSE,
#               options = list(placeholder = "Type to search country...")
#             )
#           ),
#           # Select impact levels
#           box(
#             title = "Select Impact Levels",
#             width = 6,
#             selectInput(
#               "social_perception",
#               "Social Perception",
#               choices = social_perception,
#               selected = NULL
#             ),
#             selectInput(
#               "health_impact",
#               "Health Impact",
#               choices = health_impact,
#               selected = NULL
#             ),
#             selectInput(
#               "ecosystem_impact",
#               "Ecosystem Impact",
#               choices = ecosystem_impact,
#               selected = NULL
#             ),
#             selectInput(
#               "ecology_impact",
#               "Ecology Impact",
#               choices = ecological_impact,
#               selected = NULL
#             ),
#             selectInput(
#               "reversibility_impact",
#               "Reversibility Impact",
#               choices = reversibility_impact,
#               selected = NULL
#             ),
#             actionButton("submit", "Submit", class = "btn-primary")
#           )
#         ),
#         fluidRow(
#           # Data Table
#           box(
#             title = "Data Table",
#             width = 12,
#             DT::dataTableOutput("data_table")
#           )
#         ),
#         fluidRow(
#           # Radar Chart Buttons
#           box(
#             title = "Radar Chart Options",
#             width = 12,
#             actionButton("radar1", "Radar 1"),
#             actionButton("radar2", "Radar 2"),
#             actionButton("radar3", "Radar 3"),
#             actionButton("radar4", "Radar 4")
#           )
#         ),
#         fluidRow(
#           # Radar Chart Output
#           box(
#             title = "Radar Chart",
#             width = 12,
#             plotOutput("radar_chart")
#           )
#         )
#       ),
#
#       # About tab
#       tabItem(
#         tabName = "about",
#         fluidRow(
#           box(
#             title = "About This Project",
#             width = 12,
#             status = "info",
#             solidHeader = TRUE,
#             tags$div(
#               style = "font-size: 16px;",
#               tags$p("This project provides a comprehensive analysis of invasive species' impact through radar charts and tables."),
#               tags$p("Developed by: Ismael Almena Soto, PhD | Emir Celik, Master's Student"),
#               tags$p("Institution: Faculty of Fisheries and Protection of Waters | University of South Bohemia"),
#               tags$p("Date: ", Sys.Date()),
#               tags$p("Data Sources:"),
#               tags$ul(
#                 tags$li("GBIF: Global Biodiversity Information Facility"),
#                 tags$li("Invacost: Cost of biological invasions database")
#               ),
#               tags$p("For inquiries, please contact us at:"),
#               tags$p(tags$a(href = "mailto:email@example.com", "isotoalmena@frov.jcu.cz"))
#             )
#           )
#         )
#       )
#     ),
#
#     # Manually adding footer using HTML
#     tags$footer(
#       style = "position: fixed; bottom: 0; width: 100%; background-color: #f1f1f1; text-align: center; padding: 10px; font-size: 14px;",
#       p("Developed by: Ismael Almena Soto, PhD | Emir Celik, MSc")
#     )
#   )
# )
################################################################## DENEME 2 ################################

#
# library(shiny)
# library(shinydashboard)
#
# #source("../../R/choices.R")
#
# ui <- dashboardPage(
#   dashboardHeader(
#     title = tags$div(
#       style = "display: flex; align-items: left;",  # Flexbox ile hizalama
#       tags$img(src = "logo.jpg", height = "40px", style = "margin-right: 10px;"),  # Logo
#       "Invader Metrics"  # Başlık
#     )
#   ),
#
#   dashboardSidebar(
#     sidebarMenu(
#       menuItem("Inputs and Visualization", tabName = "inputs", icon = icon("sliders")),
#       menuItem("About", tabName = "about", icon = icon("info-circle")) # About sekmesi
#     )
#   ),
#
#   dashboardBody(
#     tabItems(
#       # Inputs and Visualization tab
#       tabItem(
#         tabName = "inputs",
#         fluidRow(
#           # Select species and country
#           box(
#             title = "Select Species and Country",
#             width = 6,
#             selectizeInput(
#               "species",
#               "Select Species",
#               choices = NULL,
#               selected = NULL,
#               multiple = FALSE,
#               options = list(placeholder = "Type to search species...")
#             ),
#             selectizeInput(
#               "country",
#               "Select Country",
#               choices = NULL,
#               selected = NULL,
#               multiple = FALSE,
#               options = list(placeholder = "Type to search country...")
#             )
#           ),
#           # Select impact levels
#           box(
#             title = "Select Impact Levels",
#             width = 6,
#             selectInput(
#               "social_perception",
#               "Social Perception",
#               choices = social_perception,
#               selected = NULL
#             ),
#             selectInput(
#               "health_impact",
#               "Health Impact",
#               choices = health_impact,
#               selected = NULL
#             ),
#             selectInput(
#               "ecosystem_impact",
#               "Ecosystem Impact",
#               choices = ecosystem_impact,
#               selected = NULL
#             ),
#             selectInput(
#               "ecology_impact",
#               "Ecology Impact",
#               choices = ecological_impact,
#               selected = NULL
#             ),
#             selectInput(
#               "reversibility_impact",
#               "Reversibility Impact",
#               choices = reversibility_impact,
#               selected = NULL
#             ),
#             actionButton("submit", "Submit", class = "btn-primary")
#           )
#         ),
#         fluidRow(
#           # Data Table
#           box(
#             title = "Data Table",
#             width = 12,
#             DT::dataTableOutput("data_table")
#           )
#         ),
#         fluidRow(
#           # Left column: Radar 1
#           column(
#             width = 6,
#             wellPanel(
#               h4("Radar Chart 1"),
#               actionButton("radar1_button", "Generate Radar 1"),  # Radar 1 Button
#               plotOutput("radar_chart_1"),  # Radar 1 Plot
#               textOutput("area_output_1")   # Radar 1 Area
#             )
#           ),
#
#           # Right column: Radar 2
#           column(
#             width = 6,
#             wellPanel(
#               h4("Radar Chart 2"),
#               actionButton("radar2_button", "Generate Radar 2"),  # Radar 2 Button
#               plotOutput("radar_chart_2"),  # Radar 2 Plot
#               textOutput("area_output_2")   # Radar 2 Area
#             )
#           )
#         )
#
#
#         ),
#
#
#       # About tab
#       tabItem(
#         tabName = "about",
#         fluidRow(
#           box(
#             title = "About This Project",
#             width = 12,
#             status = "info",
#             solidHeader = TRUE,
#             tags$div(
#               style = "font-size: 16px;",
#               tags$p("This project provides a comprehensive analysis of invasive species' impact through radar charts and tables."),
#               tags$p("Developed by: Ismael Almena Soto, PhD | Emir Celik, Master's Student"),
#               tags$p("Institution: Faculty of Fisheries and Protection of Waters | University of South Bohemia"),
#               tags$p("Date: ", Sys.Date()),
#               tags$p("Data Sources:"),
#               tags$ul(
#                 tags$li("GBIF: Global Biodiversity Information Facility"),
#                 tags$li("Invacost: Cost of biological invasions database")
#               ),
#               tags$p("For inquiries, please contact us at:"),
#               tags$p(tags$a(href = "mailto:email@example.com", "isotoalmena@frov.jcu.cz"))
#             )
#           )
#         )
#       )
#     ),
#
#     # Manually adding footer using HTML
#     tags$footer(
#       style = "position: fixed; bottom: 0; width: 100%; background-color: #f1f1f1; text-align: center; padding: 10px; font-size: 14px;",
#       p("Developed by: Ismael Almena Soto, PhD | Emir Celik, MSc")
#     )
#   )
# )


ui <- dashboardPage(
  dashboardHeader(
    title = tags$div(
      style = "display: flex; align-items: left;",  # Flexbox ile hizalama
      tags$img(src = "logo.jpg", height = "40px", style = "margin-right: 10px;"),  # Logo
      "Invader Metrics"  # Başlık
    )
  ),

  dashboardSidebar(
    sidebarMenu(
      menuItem("Inputs and Visualization", tabName = "inputs", icon = icon("sliders")),
      menuItem("About", tabName = "about", icon = icon("info-circle")) # About sekmesi
    )
  ),

  dashboardBody(
    tabItems(
      # Inputs and Visualization tab
      tabItem(
        tabName = "inputs",
        fluidRow(
          # Select species and country
          box(
            title = "Select Species and Country",
            width = 6,
            selectizeInput(
              "species",
              "Select Species",
              choices = NULL,
              selected = NULL,
              multiple = FALSE,
              options = list(placeholder = "Type to search species...")
            ),
            selectizeInput(
              "country",
              "Select Country",
              choices = NULL,
              selected = NULL,
              multiple = FALSE,
              options = list(placeholder = "Type to search country...")
            )
          ),
          # Select impact levels
          box(
            title = "Select Impact Levels",
            width = 6,
            selectInput(
              "social_perception",
              "Social Perception",
              choices = social_perception,
              selected = NULL
            ),
            selectInput(
              "health_impact",
              "Health Impact",
              choices = health_impact,
              selected = NULL
            ),
            selectInput(
              "ecosystem_impact",
              "Ecosystem Impact",
              choices = ecosystem_impact,
              selected = NULL
            ),
            selectInput(
              "ecology_impact",
              "Ecology Impact",
              choices = ecological_impact,
              selected = NULL
            ),
            selectInput(
              "reversibility_impact",
              "Reversibility Impact",
              choices = reversibility_impact,
              selected = NULL
            ),
            actionButton("submit", "Submit", class = "btn-primary")
          )
        ),
        fluidRow(
          # Data Table
          box(
            title = "Data Table",
            width = 12,
            DT::dataTableOutput("data_table")
          )
        ),
        fluidRow(
          # Left column: Radar 1
          column(
            width = 6,
            wellPanel(
              h4("Radar Chart 1"),
              actionButton("radar1_button", "Generate Radar 1"),  # Radar 1 Button
              plotOutput("radar_chart_1"),  # Radar 1 Plot
              textOutput("area_output_1")   # Radar 1 Area
            )
          ),

          # Right column: Radar 2
          column(
            width = 6,
            wellPanel(
              h4("Radar Chart 2"),
              actionButton("radar2_button", "Generate Radar 2"),  # Radar 2 Button
              plotOutput("radar_chart_2"),  # Radar 2 Plot
              textOutput("area_output_2")   # Radar 2 Area
            )
          )
        )
      ),

      # About tab
      tabItem(
        tabName = "about",
        fluidRow(
          box(
            title = "About This Project",
            width = 12,
            status = "info",
            solidHeader = TRUE,
            tags$div(
              style = "font-size: 16px;",
              tags$p("This project provides a comprehensive analysis of invasive species' impact through radar charts and tables."),
              tags$p("Developed by: Ismael Almena Soto, PhD | Emir Celik, Master's Student"),
              tags$p("Institution: Faculty of Fisheries and Protection of Waters | University of South Bohemia"),
              tags$p("Date: ", Sys.Date()),
              tags$p("Data Sources:"),
              tags$ul(
                tags$li("GBIF: Global Biodiversity Information Facility"),
                tags$li("Invacost: Cost of biological invasions database")
              ),
              tags$p("For inquiries, please contact us at:"),
              tags$p(tags$a(href = "mailto:email@example.com", "isotoalmena@frov.jcu.cz"))
            )
          )
        )
      )
    ),

    # Manually adding footer using HTML
    tags$footer(
      style = "position: fixed; bottom: 0; width: 100%; background-color: #f1f1f1; text-align: center; padding: 10px; font-size: 14px;",
      p("Developed by: Ismael Almena Soto, PhD | Emir Celik, MSc")
    )
  )
)
