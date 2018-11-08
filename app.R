###################
# app.R
# 
# Main controller. 
# Used to import your serverui and server components, and initialize the app.
###################
library(shiny)
library(shinydashboard)
library(DT)


source('./ui.R')
source('./server.R')


shinyApp(ui, server)
