###################
# body.R
# 
# Create the body for the ui. 
# If you had multiple tabs, you could potentially segment those into their own
# components as well.
###################
library(shinydashboard)

source('./components/panels/visualisationPanel.R')
source('./components/panels/datasetPanel.R')
source('./components/panels/widgetPanel.R')
source('./components/panels/settingsPanel.R')

body <- dashboardBody(
	tabItems(
		datasetPanel,
		visualisationPanel,
		widgetPanel,
		settingsPanel
	)
)

