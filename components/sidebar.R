###################
# sidebar.R
# 
# Create the sidebar menu options for the ui.
###################
library(shinydashboard)


sidebar <- dashboardSidebar(
	sidebarMenu(

		menuItem("Dataset", tabName = "dataset", icon = icon("cloud-upload")),
		menuItem("Visualisation", tabName = "visualisation", icon = icon("signal")),
		menuItem("Data view", tabName = "widgets", icon = icon("folder-open")),
		menuItem("Settings", tabName = "settings", icon = icon("cog"))

	)
)

