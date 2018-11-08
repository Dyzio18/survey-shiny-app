###################
# sidebar.R
# 
# Create the sidebar menu options for the ui.
###################
library(shinydashboard)


sidebar <- dashboardSidebar(
  sidebarMenu(

    menuItem("Dataset", tabName = "dataset", icon = icon("cloud-upload")),
    menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
    menuItem("Widgets", tabName = "widgets", icon = icon("th")),
    menuItem("Settings", tabName = "settings", icon = icon("cog"))

  )
)
