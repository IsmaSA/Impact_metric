library(shiny)
library(shinydashboard)
library(DT)

# Source the ui and server
source("ui.R")
source("server.R")

# Launch the app
shinyApp(ui, server)
