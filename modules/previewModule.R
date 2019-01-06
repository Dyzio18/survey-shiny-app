library(DT)

###################
# UI
###################

previewModuleUI <- function(id) {
    ns <- NS(id)
    fluidRow(
        h2(class="panel__title", i18n$t("Data preview")),
        br(),
        column(12,
            DT::dataTableOutput(ns("table"))
        )
    )
}

###################
# Server
###################

previewModule <- function(input, output, session, data) {

	output$table <- DT::renderDataTable(
		DT::datatable(
			data,
			filter = 'top',
			extensions = 'Buttons',
			options = list(pageLength = 10, buttons = I('colvis'))
		)
	)
    # selectedColumn <- reactive({
    #     validate(need(input$col, FALSE))
    #     data[, input$col]
    # })
    # output$table <- renderTable(head(selectedColumn()))
    # output$controls <- renderUI({
    #     ns <- session$ns
    #     selectInput(ns("col"), "Columns", names(data), multiple = TRUE)
    # })

    # output$barPlot <- renderPlot({
    #     PlotBars(data, Zajecie) + labs(x = "", y = "% odpowiedzi")
    # })
}