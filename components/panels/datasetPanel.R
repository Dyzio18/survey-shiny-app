datasetPanel  <- tabItem(
    tabName = "dataset",
    h2("Dataset"),
    fluidRow(
        box(
            title = "Upload file",
            width = 4,
            # Input: Select a file ----
            fileInput("dataFile", "Choose CSV File", multiple = FALSE, accept = c("text/csv", "text/comma-separated-values,text/plain", ".csv")),
            tags$hr(),
            # Input: Checkbox if file has header ----
            checkboxInput("header", "Header", TRUE),
            # Input: Select separator ----
            radioButtons("sep", "Separator", choices = c(Comma = ",", Semicolon = ";", Tab = "\t"), selected = ","),
            # Input: Select quotes ----
            radioButtons("quote", "Quote", choices = c(None = "", "Double Quote" = '"', "Single Quote" = "'"), selected = '"'),
            # Horizontal line ----
            tags$hr(),
            # Input: Select number of rows to display ----
            radioButtons("disp", "Display", choices = c(Head = "head", All = "all"), selected = "head")
        ),
        column(8,uiOutput("uiBoxDetail")),
        
        # box(
        #     title = "More info",
        #     width = 8,
        #     h4(icon("glyphicon-list-alt"), "See details..."),
        #     div(style = 'overflow-x: scroll', tableOutput('headers'))
        #     
        # ),
        box(
            title = "Data", width = 12, 
            solidHeader = TRUE, 
            status = "primary",
            div(style = 'overflow-x: scroll', tableOutput('contents'))
        )   
        
    )
)