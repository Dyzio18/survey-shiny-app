# Module server function
histBox <- function(input, output, session, stringsAsFactors) {

    output$uiBoxDetail <- renderUI({
        if(is.null(input$dataFile$datapath)) return()
        box(
            title = "More info",
            width = NULL,
            solidHeader = TRUE, 
            status = "primary",
            tabsetPanel(
                type = "tabs", 
                # Panel headers
                tabPanel("Headers",
                h4("Headers"),
                div(style = 'overflow-x: scroll', tableOutput('headers'))),
                # Panel histogram
                tabPanel("Histogram", 
                    selectInput(
                    "datasetSelectColumn",
                    "Choose a column:",
                    choices = colnames(dataFileReact())
                ),
                sliderInput("datasetHistSlider", "Number of observations:", 1, 36, 10),
                actionButton(
                    inputId = "datasetHistSubmit",
                    label = "Submit column"
                ),
                plotOutput("datasetHistPlot")
                
                ),
                # Panel other
                tabPanel("Table",   
                h4(icon("glyphicon-list-alt"), "Details:")
                )
            )
        )
    })
}


