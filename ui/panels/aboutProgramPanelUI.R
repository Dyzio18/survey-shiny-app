
source('./modules/aboutProgramModule.R')

aboutProgramPanelUI <- tabItem(
    tabName = "about_program",
    aboutProgramModuleUI("aboutProgram")
)