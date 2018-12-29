###################
# sidebar.R
# 
# Create the sidebar menu options for the ui.
###################
library(shinydashboard)


sidebar <- dashboardSidebar(
	sidebarMenu(
		menuItem(
			i18n$t("Dashboard"),
			tabName = "dashboard",
			icon = icon("dashboard")
		),
		menuItem(
			i18n$t("Dataset"),
			tabName = "dataset",
			icon = icon("cloud-upload")
		),
		menuItem(
			i18n$t("Settings"),
			tabName = "settingsPanel",
			icon = icon("dashboard")
		)
	)
)

