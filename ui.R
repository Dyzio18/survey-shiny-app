###################
# ui.R
# 
# Initializes the ui. 
# Used to load in your header, sidebar, and body components.
###################

source('./ui/header.R')
source('./ui/sidebar.R')
source('./ui/body.R')

ui <- dashboardPage(
	tags$head(
		tags$link(
			rel = "stylesheet",
			type = "text/css",
			href = "css/style.css"
		)
	),
	header = header,
	sidebar =  sidebar,
	body = body,
	skin = "blue"
)
