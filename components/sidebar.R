###################
# sidebar.R
# 
# Create the sidebar menu options for the ui.
###################
library(shinydashboard)


sidebar <- dashboardSidebar(
	sidebarMenu(
		menuItem(i18n$t("Dashboard"), tabName = "dashboard", icon = icon("dashboard")),
		menuItem(i18n$t("Dataset"), tabName = "dataset", icon = icon("cloud-upload")),
		menuItem(i18n$t("Visualisation"), tabName = "visualisation", icon = icon("signal")),
		menuItem(i18n$t("Statistics"), tabName = "statistics", icon = icon("signal"),
			menuSubItem(i18n$t("Clustering"), tabName = "clustering"),
			menuSubItem(i18n$t("Descriptive statistics"), tabName = "descriptive_statistics")
		),
		menuItem("Raport", tabName = "raport", icon = icon("book")),
		menuItem(i18n$t("Data view"), tabName = "datatable", icon = icon("clipboard")),
		menuItem(i18n$t("Settings"), tabName = "settings", icon = icon("cog"))

	)
)

