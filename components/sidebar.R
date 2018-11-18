###################
# sidebar.R
# 
# Create the sidebar menu options for the ui.
###################
library(shinydashboard)


sidebar <- dashboardSidebar(
	sidebarMenu(
		menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
		menuItem("Dataset", tabName = "dataset", icon = icon("cloud-upload")),
		menuItem("Visualisation", tabName = "visualisation", icon = icon("signal")),
		menuItem("Raport", tabName = "raport", icon = icon("book")),
		menuItem("Data view", tabName = "datatable", icon = icon("clipboard")),
		menuItem("Settings", tabName = "settings", icon = icon("cog"))

	)
)

