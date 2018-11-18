###################
# ui.R
# 
# Initializes the ui. 
# Used to load in your header, sidebar, and body components.
###################
library(shinydashboard)

source('./components/header.R')
source('./components/sidebar.R')
source('./components/body.R')



ui <- dashboardPage(
	tags$head(
    	tags$link(rel = "stylesheet", type = "text/css", href = "css/style.css")
  	),

	header = header,
	sidebar =  sidebar,
	body = body,
	skin = "blue"

)
