###################
# UI
###################
descriptiveStatisticsModuleUI <- function(id) {
    ns <- NS(id)
    fluidRow(
        h2(class="panel__title", i18n$t("Descriptive statistics")),
        column(12,
            uiOutput(ns("controls")),
            tableOutput(ns("table"))
        )
    )
}

###################
# Server
###################
descriptiveStatisticsModule <- function(input, output, session, data) {

    output$table <- renderTable(data)
    
    output$controls <- renderUI({
        ns <- session$ns
        selectInput(ns("col"), "Columns", names(data), multiple = TRUE)
    })
    return(reactive({
        validate(need(input$col, FALSE))
        data[, input$col]
    }))
}