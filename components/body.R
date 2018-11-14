###################
# body.R
# 
# Create the body for the ui. 
# If you had multiple tabs, you could potentially segment those into their own
# components as well.
###################
library(shinydashboard)

source('./components/modules/visualisationModule.R')
source('./components/modules/datasetModule.R')
source('./components/modules/widgetModule.R')
source('./components/modules/settingsModule.R')

body <- dashboardBody(
	tabItems(
		datasetModuleUI,
		visualisationModuleUI,
		widgetModuleUI,
		settingsModuleUI
	)
)

