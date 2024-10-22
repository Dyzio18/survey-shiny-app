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
                    ns("file"), label = "Upload File"
                ),
                actionButton(
                    ns("demoSurvey"),
                    label = "Load demo survey",
                    class = "btn btn-link"
                ),
                hr(),
                selectInput(ns("separator"), "Separator", choices = c(Comma = ",", Semicolon = ";", Tab = "\t"), selected = ","),
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

    #sampleSurvey <- "E:\\new_survey-shiny-app\\www\\resources\\sample_opinion.csv"
    sampleSurvey <- "https://gist.githubusercontent.com/Dyzio18/c2bcae3e37619f77179754de2216fabb/raw/d1dea18089eae45e466afd80a6e4bab82adef782/sample_survey.csv"

    userFile <- reactive({
        validate(
            need(
                input$file,
                message = FALSE
            )
        )
        input$file
    })

    observe({
        print(mockupSurvey())
    })

    mockupSurvey <- eventReactive(input$demoSurvey, {
        sampleSurvey
    })

    observeEvent(input$demoSurvey, {
        msg <- "Demo survey is loaded with success"
        if(!is.null(input$file)) {
            msg <- "After loading the questionnaire, the demo file is inactive"
        }
        
        showModal(
            modalDialog(
                title = "Demo survey",
                h3(msg),
                easyClose = TRUE
            )
        )
    })

    dataframe <- reactive({
        # Load demo survey only on button action (reactive expression)
        # surveyPath <- mockupSurvey()

        # [DEV] init app with loaded file (for development)
        surveyPath <- sampleSurvey

        if(!is.null(input$file)){
            surveyPath <- userFile()$datapath
        }
        # TODO: file validatation 
        read.csv(
            surveyPath,
            header = TRUE,
            quote = input$quote,
            sep = input$separator,
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
        showModal(
            modalDialog(
                title = "Success",
                h3("Load data with succes"),
                easyClose = TRUE
            )
        )
    })

    return(dataframe)
}