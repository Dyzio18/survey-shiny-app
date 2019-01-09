library(dplyr)
library(cluster)

###################
# UI
###################
clusteringModuleUI <- function(id) {
    ns <- NS(id)
    fluidRow(
        h2(class="panel__title", i18n$t("Clustering")),
        box( width = 12, 
            column(12,uiOutput(ns("setup")))
        ),
        plotOutput(ns("clusteringPlot"))
    )
}

###################
# Server
###################
clusteringModule <- function(input, output, session, data) {
    ns <- session$ns

	output$setup <- renderUI({
		column(6,
			selectInput(
				ns("columnY"),
				"Choose a column Y:",
				choices = colnames(data)
			),
			selectInput(
				ns("columnX"),
				"Choose a column X:",
				choices = colnames(data)
			),
			numericInput(ns("clustersNumber"), 'Cluster count', 3,
				min = 1, max = 9
			),
			actionButton(
				inputId = ns("submit"),
				label = "Submit"
			)
		)
	})

	clusteringData <- eventReactive( input$submit, {
        cleanData <- data[data==""]<-NA
		cleanData <- data[, c(input$columnY, input$columnX )] %>%
            filter(complete.cases(.)) %>% na.omit
	})

	clusters <- reactive({
		kmeans(clusteringData(), input$clustersNumber)
	})

	output$clusteringPlot <- renderPlot({
		palette <- c("#E41A1C", "#377EB8", "#4DAF4A", "#984EA3",
		"#FF7F00", "#FFFF33", "#A65628", "#F781BF", "#999999")

        dataClustered <- data.frame(clusteringData(), cluster=factor(clusters()$cluster))
        names(dataClustered) <- c("Y_col", "X_col", "cluster")

        # TODO: add centroid to plot 

        ggplot(dataClustered)+
        geom_point(
            aes(
                dataClustered[["X_col"]],dataClustered[["Y_col"]], 
                col=dataClustered[["cluster"]], shape = dataClustered[["cluster"]] 
            ), 
        size=6
        ) + xlab(input$columnX) + ylab(input$columnY)

        # # par(mar = c(5.1, 4.1, 0, 1))
        # plot(clusteringData(), col = clusters()$cluster,	pch = 20, cex = 3 )
        # points(clusters()$centers, pch = 4, cex = 4, lwd = 4)
	})
}

