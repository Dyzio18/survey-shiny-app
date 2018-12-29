###################
# UI
###################

previewModuleUI <- function(id) {
    ns <- NS(id)
    fluidRow(
        h2(class="panel__title", i18n$t("Dataset")),
        column(12,
            uiOutput(ns("controls")),
            tableOutput(ns("table"))
        )
    )
}

###################
# Server
###################

previewModule <- function(input, output, session, data) {

    selectedColumn <- reactive({
        validate(need(input$col, FALSE))
        data[, input$col]
    })
    output$table <- renderTable(head(selectedColumn()))
    output$controls <- renderUI({
        ns <- session$ns
        selectInput(ns("col"), "Columns", names(data), multiple = TRUE)
    })
}