source('./modules/clusteringModule.R')

clusteringPanelUI <- tabItem(
    tabName = "clustering",
    clusteringModuleUI("clustering")
)