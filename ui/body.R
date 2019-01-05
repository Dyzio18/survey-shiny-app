###################
# body.R
# 
# Create the body for the ui. 
# If you had multiple tabs, you could potentially segment those into their own
# components as well.
###################
library(shinydashboard)

source('./ui/panels/dashboardPanelUI.R')
source('./ui/panels/datasetPanelUI.R')
source('./ui/panels/descriptiveStatisticsPanelUI.R')
source('./ui/panels/clusteringPanelUI.R')
source('./ui/panels/nlpPanelUI.R')
source('./ui/panels/aboutProgramPanelUI.R')


body <- dashboardBody(
	tabItems(
		dashboardPanelUI,
		datasetPanelUI,
		descriptiveStatisticsPanelUI,
		clusteringPanelUI,
		nlpPanelUI,
		aboutProgramPanelUI
	)
)

