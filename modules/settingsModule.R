library(shiny.i18n)

settingsModuleUI <- function(id) {
    ns <- NS(id)
    fluidRow(
        h2(class="panel__title", i18n$t("Settings")),
        column(
            width = 12,
            box("Settings"),
            box("Anout")

        ) 
    )
}

# Functionality for dataselection for plot
# SelectInput is rendered dynamically based on data

settingsModule <- function(input, output, session) {
    ns <- session$ns


}