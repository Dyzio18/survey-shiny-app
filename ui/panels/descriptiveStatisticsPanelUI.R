source('./modules/descriptiveStatisticsModule.R')

descriptiveStatisticsPanelUI <- tabItem(
    tabName = "descriptive_statistics",
    descriptiveStatisticsModuleUI("descriptiveStatistics")
)