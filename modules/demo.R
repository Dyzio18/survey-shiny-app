# Demo Module

###################
# UI
###################
demoModuleUI <- function(id) {
    ns <- NS(id)
    fluidRow(
        h2(class="panel__title", i18n$t("Demo Module")),
        column(12,
            uiOutput(ns("controls")),
            tableOutput(ns("table"))
        )
    )
}

###################
# Server
###################
demoModule <- function(input, output, session, data) {

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