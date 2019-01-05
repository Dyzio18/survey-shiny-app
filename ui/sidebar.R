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
			i18n$t("Data preview"),
			tabName = "dataset",
			icon = icon("cloud-upload")
		),
		menuItem(
			i18n$t("Statistics"),
			tabName = "statistics",
			icon = icon("signal"),
			menuSubItem(
				i18n$t("Descriptive statistics"),
				tabName = "descriptive_statistics"
			),
			menuSubItem(
				i18n$t("Clustering"),
				tabName = "clustering"
			)
		),
		menuItem(
			"Text minning",
			tabName = "nlp_module",
			icon = icon("dashboard")
		),
		menuItem(
			i18n$t("About program"),
			tabName = "about_program",
			icon = icon("dashboard")
		)

	)
)

