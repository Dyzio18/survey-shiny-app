# Dashboard Module
# User widgets, basic information

source('./modules/gapModule.R')


dashboardModuleUI <- tabItem(
    tabName = "dashboard",
    h2("Dashboard"),
    fluidRow(
         tabPanel("All", gapModuleUI("all"))
    )
)
