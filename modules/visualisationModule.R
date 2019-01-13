# visualisation Module

source('./functions.R')
library(RColorBrewer)
library(ggplot2)

###################
# UI
###################
visualisationModuleUI <- function(id) {
    ns <- NS(id)
    fluidRow(
        h2(class="panel__title", i18n$t("Visualisation")),
        column(12,
            uiOutput(ns("initButtons"))
        ),
        hr(),
        column(12,
            id = "plotContainerId"
        )
    )
}

###################
# Server
###################
visualisationModule <- function(input, output, session, data) {
    ns <- session$ns
    orderId <- 1
    
    # Buttons panel - triggers for modals
    output$initButtons <- renderUI({
        column(12,
            actionButton(
                ns("scatterplotModalBtn"), "Scatterplot", class = "plot__btn", icon = icon("bar-chart-o")
            ), 
            # actionButton(
            #     ns("pieplotModalBtn"), "Pie plot", class = "plot__btn", icon = icon("bar-chart-o")
            # ), 
            actionButton(
                ns("boxplotModalBtn"), "Boxplot", class = "plot__btn", icon = icon("bar-chart-o"),
            ), 
            actionButton(
                ns("histogramModalBtn"), "Histogram", class = "plot__btn", icon = icon("bar-chart-o")
            ), 
            br(), hr(), br()
        )
    })

    # ===============
    # ===============
    # Scatterplot modal
    observeEvent(input$scatterplotModalBtn, {
        showModal(
            modalDialog(
                title = "Scatterplot",
                footer = modalButton("cancel"),
                easyClose = TRUE,
                fluidRow(
                    column(12,
                        selectInput(
                            inputId = ns('scatterplotXAxis'), label = 'X-axis', names(data)
                        ),
                        selectInput(
                            inputId = ns('scatterplotYAxis'), label = 'Y-axis', names(data)
                        ),
                        checkboxInput(
                            inputId = ns('scatterplotTrendLine'), label = "Trend line"
                        ),
                        actionButton(
                            ns("scatterplotCreateBtn"), "Create", class = "create__btn", icon = icon("bar-chart-o")
                        )
                    )
                )
            )
        )
    })

    # Scatterplot generate
    observeEvent(input$scatterplotCreateBtn, {
        orderId <<- orderId + 1
        bxPlotId <- paste0("bxplot__", orderId)

        xName <- input$scatterplotXAxis
        yName <- input$scatterplotYAxis
        trendLine <- input$scatterplotTrendLine
        plotTitle <-  paste0(colName(yName)," / ", colName(xName))
    
        output[[bxPlotId]] <- renderPlot({
            resPlot <- ggplot(data, aes(x = data[[xName]], y = data[[yName]])) + geom_point()
            if(trendLine == TRUE){
                resPlot <- resPlot + geom_smooth(method="lm")
            }
            resPlot <- resPlot + labs(title = plotTitle, x = colName(xName), y = colName(yName))
            validate(
                need(resPlot, "Cannot display plot from selected data"),
                errorClass = "errMsg"
            )
            resPlot
        })

        insertUI(
            selector = "#plotContainerId", 
            where = "afterBegin",
            ui = column(6,
                plotOutput(ns(bxPlotId))
            )
        )
    })

    # ===============
    # ===============
    # pieplot modal
    observeEvent(input$pieplotModalBtn, {
        showModal(
            modalDialog(
                title = "Pie plot",
                footer = modalButton("cancel"),
                easyClose = TRUE,
                fluidRow(
                    column(12,
                        selectInput(
                            inputId = ns('pieplotXAxis'), label = 'X-axis', names(data)
                        ),
                        selectInput(
                            inputId = ns('pieplotYAxis'), label = 'Y-axis', names(data)
                        ),
                        checkboxInput(
                            inputId = ns('pieplotTrendLine'), label = "Trend line"
                        ),
                        actionButton(
                            ns("pieplotCreateBtn"), "Create", class = "create__btn", icon = icon("bar-chart-o")
                        )
                    )
                )
            )
        )
    })

    # pieplot generate
    observeEvent(input$pieplotCreateBtn, {
        orderId <<- orderId + 1
        bxPlotId <- paste0("bxplot__", orderId)

        xName <- input$pieplotXAxis
        yName <- input$pieplotYAxis
        trendLine <- input$pieplotTrendLine
        plotTitle <-  paste0(colName(yName)," / ", colName(xName))
    
        output[[bxPlotId]] <- renderPlot({
            resPlot <- ggplot(data, aes(x = data[[xName]])) + coord_polar("y", start=0) + scale_colour_brewer(palette = "PRGn")
            resPlot <- resPlot + labs(title = plotTitle, x = colName(xName), y = colName(yName))
            validate(
                need(resPlot, "Cannot display plot from selected data"),
                errorClass = "errMsg"
            )
            resPlot
        })

        insertUI(
            selector = "#plotContainerId", 
            where = "afterBegin",
            ui = column(6,
                plotOutput(ns(bxPlotId))
            )
        )
    })
    # ===============
    # ===============
    # Histogram modal
    observeEvent(input$histogramModalBtn, {
        showModal(
            modalDialog(
                title = "Histogram",
                footer = modalButton("cancel"),
                easyClose = TRUE,
                fluidRow(
                    column(12,
                        selectInput(
                            inputId = ns('histogramXAxis'), label = 'Column', names(data)
                        ),
                        actionButton(
                            ns("histogramCreateBtn"), "Create", class = "create__btn", icon = icon("bar-chart-o")
                        )
                    )
                )
            )
        )
    })

    # histogram generate
    observeEvent(input$histogramCreateBtn, {
        orderId <<- orderId + 1
        bxPlotId <- paste0("bxplot__", orderId)

        xName <- input$histogramXAxis
        yName <- input$histogramYAxis
        trendLine <- input$histogramTrendLine
        plotTitle <-  paste0(colName(yName)," / ", colName(xName))
    
        output[[bxPlotId]] <- renderPlot({
            resPlot <- ggplot(data, aes(x = data[[xName]])) + geom_histogram(binwidth = 6) + scale_colour_brewer(palette = "PRGn")
            resPlot <- resPlot + labs(title = plotTitle, x = colName(xName), y = "Count")
            validate(
                need(resPlot, "Cannot display plot from selected data"),
                errorClass = "errMsg"
            )
            resPlot
        })

        insertUI(
            selector = "#plotContainerId", 
            where = "afterBegin",
            ui = column(6,
                plotOutput(ns(bxPlotId))
            )
        )
    })

    # ===============
    # ===============
    # Boxplot modal
    observeEvent(input$boxplotModalBtn, {
        showModal(
            modalDialog(
                title = "Boxplot plot",
                footer = modalButton("cancel"),
                easyClose = TRUE,
                fluidRow(
                    column(12,
                        h3("Create box plot"),
                        selectInput(
                            inputId = ns('boxplotXAxis'), label = 'X-axis', names(data)
                        ),
                        selectInput(
                            inputId = ns('boxplotYAxis'), label = 'Y-axis', names(data)
                        ),
                        actionButton(
                            ns("boxplotCreateBtn"), "Create", class = "create__btn", icon = icon("bar-chart-o")
                        )
                    )
                )
            )
        )
    })

    # Boxplot generate [or AUTO plot]
    observeEvent(input$boxplotCreateBtn, {
        orderId <<- orderId + 1
        bxPlotId <- paste0("bxplot__", orderId)

        xName <- input$boxplotXAxis
        yName <- input$boxplotYAxis
        trendLine <- input$boxplotTrendLine
        plotTitle <-  paste0(colName(yName)," / ", colName(xName))
    
        output[[bxPlotId]] <- renderPlot({
            resPlot <- ggplot(data, aes(x = data[[xName]], y = data[[yName]])) + geom_point()
            resPlot <- resPlot + geom_boxplot()
            resPlot <- resPlot + labs(title = plotTitle, x = colName(xName), y = colName(yName))
            validate(
                need(resPlot, "Cannot display plot from selected data"),
                errorClass = "errMsg"
            )
            resPlot
        })

        insertUI(
            selector = "#plotContainerId", 
            where = "afterBegin",
            ui = column(6,
                plotOutput(ns(bxPlotId))
            )
        )
    })


}