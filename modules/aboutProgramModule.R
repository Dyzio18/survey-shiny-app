# @Author: Patryk Nizio "Dyzio" / 2019
# Display information in "About program" tab.
# Contain app description and help pages

###################
# UI
###################
aboutProgramModuleUI <- function(id) {
    ns <- NS(id)
    fluidRow(
        h2(class="panel__title", i18n$t("About program")),
        column(12,
            uiOutput(ns("descAboutProgram"))
        )
    )
}

###################
# Server
###################
aboutProgramModule <- function(input, output, session) {
    
    output$descAboutProgram <- renderUI({
        box(
            h3("Kod programu"),
            a(
                href = "https://github.com/Dyzio18/survey-shiny-app",
                "github.com/Dyzio18/survey-shiny-app"
            )
        )
        
    })
}