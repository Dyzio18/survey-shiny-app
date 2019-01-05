###################
# @Author: Patryk Nizio "Dyzio" / 2019
# app.R
# Main controller. 
# Used to import your serverui and server components, and initialize the app.
# install.packages("dplyr")
# install.packages("tidyr")
# install.packages("ggplot2")
# install.packages("DT")
# install.packages("shinydashboard")
###################
library(shiny)
library(shinydashboard)
library(dplyr)
library(tidyr)
library(ggplot2)
library(DT)

source('./ui.R')
source('./server.R')

shinyApp(ui, server)
