###################
# @Author: Patryk Nizio "Dyzio" / 2019
# app.R
# Main controller. 
# Used to import server and UI.I
# Initialize the app.
###################

# install.packages("dplyr")
# install.packages("tidyr")
# install.packages("ggplot2")
# install.packages("DT")
# install.packages("shinydashboard")
# install.packages("cluster")
# install.packages("wordcloud")
# install.packages("memoise")
# install.packages("tidytext")
# install.packages("stringr")
# install.packages("shiny.i18n")

###################
library(shiny)
library(shinydashboard)

source('./ui.R')
source('./server.R')

shinyApp(ui, server)

