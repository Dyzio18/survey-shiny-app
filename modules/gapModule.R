gapModuleUI <- function(id) {
  ns <- NS(id)



  
  tagList(
        column(8,uiOutput(ns("uiBoxDemo"))),

    actionButton(
			inputId = ns("histDemoSubmit"),
			label = "Submit column"
    ),
    plotOutput(ns("plot"))

  )
}

gapModule <- function(input, output, session, data) {
  

#   TODO: moze reakcja na zmiane pliku?
#       albo dataFile jako wyrazenie reaktywne/obserwator?
# https://github.com/search?l=R&q=callModule&type=Code
# -------------


# CZYTAC UWAZNIE -> WSZYSTKO + NOTATKI (ZROBIC ARTYKUŁ WLASNY PO  [PL])
# http://shiny.rstudio.com/articles/modules.html


data <- eventReactive


    output$uiBoxDemo <- renderUI({
        ns <- session$ns

        selectInput(
            ns("datasetDemoSelectColumn"),
            "Choose a column:",
            choices = colnames(data)
            )
    })

    output$plot <- renderPlot({
        plot(data[[1]])
    })
}