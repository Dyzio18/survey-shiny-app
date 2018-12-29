source('./modules/uploadModule.R')

dashboardPanelUI <- tabItem(
    tabName = "dashboard",
    uploadModuleUI("upload")
)