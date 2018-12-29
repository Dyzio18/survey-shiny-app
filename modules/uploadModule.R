###################
# UI
###################

uploadModuleUI <- function(id) {
    ns <- NS(id)  

    fluidRow(
        h2(class="panel__title", i18n$t("Dashboard")),
        column(12,
            box(

                fileInput(
                    ns("file"), label = "Upload File"),
                    # checkboxInput(ns("heading"), "Has heading"),
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
        ),
        column(12,
            infoBoxOutput(ns("questionsInfoBox")),
            infoBoxOutput(ns("responsesInfoBox")),
            infoBoxOutput(ns("fileSizeInfoBox"))

        )
    )
}

###################
# Server
###################

uploadModule <- function(input, output, session, stringsAsFactors) {

    sampleSurvey <- "E:\\survey-shiny-app\\www\\resources\\sample.csv"

    # The selected file, if any
    userFile <- reactive({
        # If no file is selected, don't do anything
        validate(
            need(
                input$file,
                message = FALSE
            )
        )
        input$file
    })

    observe({
        print(userFile())
    })

    dataframe <- reactive({
        read.csv(
            userFile()$datapath,
            header = TRUE,
            quote = input$quote,
            stringsAsFactors = stringsAsFactors
        )
    })

    observe({
        msg <- sprintf("File %s was uploaded", userFile()$name)
        cat(msg, "\n")

        output$questionsInfoBox <- renderInfoBox({
            infoBox(
                i18n$t("Questions"),
                ncol(dataframe()), 
                icon = icon("list"),
                color = "green"
            )
        })
        output$responsesInfoBox <- renderInfoBox({
            infoBox(
                i18n$t("Responses"),
                nrow(dataframe()), 
                icon = icon("list"),
                color = "purple"
            )
        })
        output$fileSizeInfoBox <- renderInfoBox({
            infoBox(
                i18n$t("File size"),
                paste0(userFile()$size, " KB"), 
                icon = icon("list"),
                color = "purple"
            )
        })
        
    })

    return(dataframe)
}