source('./modules/nlpModule.R')

nlpPanelUI <- tabItem(
    tabName = "nlp_module",
    nlpModuleUI("nlp")
)