
source('./modules/settingsModule.R')

settingsPanelUI <- tabItem(
    tabName = "settingsPanel",
    settingsModuleUI("settings")
)