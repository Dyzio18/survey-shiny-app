
source('./modules/visualisationModule.R')

visualisationPanelUI <- tabItem(
    tabName = "visualisation",
    visualisationModuleUI("visualisation")
)