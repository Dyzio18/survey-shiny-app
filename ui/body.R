###################
# body.R
# 
# Create the body for the ui.
###################
library(shinydashboard)

source('./ui/panels/dashboardPanelUI.R')
source('./ui/panels/datasetPanelUI.R')
source('./ui/panels/visualisationPanelUI.R')
source('./ui/panels/descriptiveStatisticsPanelUI.R')
source('./ui/panels/clusteringPanelUI.R')
source('./ui/panels/nlpPanelUI.R')
source('./ui/panels/aboutProgramPanelUI.R')


body <- dashboardBody(
	tabItems(
		dashboardPanelUI,
		datasetPanelUI,
		visualisationPanelUI,
		descriptiveStatisticsPanelUI,
		clusteringPanelUI,
		nlpPanelUI,
		aboutProgramPanelUI
	)
)

