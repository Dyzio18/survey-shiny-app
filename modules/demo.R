# Tab module
# This module creates new tab which renders dataTable

dataTabUI <- function(id, input, output) {
# Create a namespace function using the provided id
    ns <- NS(id)
    tagList(
        sidebarLayout(
            sidebarPanel(input),
            mainPanel(
                dataTableOutput(output)
            )
        )
    )
}

# Tab module
# This module creates new tab which renders plot
plotTabUI <- function(id, input, output) {
    # Create a namespace function using the provided id
    ns <- NS(id)
    tagList(
        sidebarLayout(
            sidebarPanel(input),
            mainPanel(
                plotOutput(output)
            )
        )
    )
}

dataTab <- function(input, output, session) {
# do nothing...
# Should there be some logic?
}

# File input module
# This module takes as input csv file and outputs dataframe
# Module UI function
csvFileInput <- function(id, label = "CSV file") {
# Create a namespace function using the provided id
    ns <- NS(id)
    tagList(
        fileInput(
            ns("file"), label),
            checkboxInput(ns("heading"), "Has heading"),
            selectInput(
            ns("quote"),
            "Quote",
            c(
                "None" = "",
                "Double quote" = "\"",
                "Single quote" = "'"
            )
        )
    )
}

# Module server function
csvFile <- function(input, output, session, stringsAsFactors) {

	sampleSurvey <- "E:\\survey-shiny-app\\www\\resources\\sample.csv"


    userFile <- reactive({
        # If no file is selected, don't do anything
        validate(need(input$file, message = FALSE))
        input$file
    })

    # The user's data, parsed into a data frame
    dataframe <- reactive({
        read.csv(
            userFile()$datapath,
            header = input$heading,
            quote = input$quote,
            stringsAsFactors = stringsAsFactors
        )
    })

    # We can run observers in here if we want to
    observe({
        msg <- sprintf("File %s was uploaded", userFile()$name)
        cat(msg, "\n")
    })

    # Return the reactive that yields the data frame
    return(dataframe)
}

basicPlotUI <- function(id) {
    ns <- NS(id)
    uiOutput(ns("controls"))
}

# Functionality for dataselection for plot
# SelectInput is rendered dynamically based on data

basicPlot <- function(input, output, session, data) {
    output$controls <- renderUI({
        ns <- session$ns
        selectInput(ns("col"), "Columns", names(data), multiple = TRUE)
    })
    return(reactive({
        validate(need(input$col, FALSE))
        data[, input$col]
    }))
}

##################################################################################
# Here starts main program. Lines above can be sourced: source("path-to-module.R")
##################################################################################

library(shiny)


ui <- shinyUI(navbarPage(
    "My Application",
    tabPanel("File upload", 
        dataTabUI(
            "tab1",
            csvFileInput("datafile", "User data (.csv format)"),
            "table"
        )
    ),
    tabPanel("Plot", 
        plotTabUI(
            "tab2", basicPlotUI("plot1"), "plotOutput"
        )
    )

))


server <- function(input, output, session) {
    datafile <- callModule(
        csvFile, "datafile",
        stringsAsFactors = FALSE
    )

    output$table <- renderDataTable({
        datafile()
    })

    plotData <- callModule(basicPlot, "plot1", datafile())

    output$plotOutput <- renderPlot({
            plot(plotData())
    })
}


shinyApp(ui, server)
















# =====================
# ===================== 
# DEMO MODULE
# =====================
# ===================== 

previewModuleUI <- function(id) {
    ns <- NS(id)
    column(6, 
        uiOutput(ns("controls")),
        tableOutput(ns("table"))
    )
}

# Functionality for dataselection for plot
# SelectInput is rendered dynamically based on data

previewModule <- function(input, output, session, data) {

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