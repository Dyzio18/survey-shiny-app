library(shinydashboard)

source('./server/histBox.R')
# source('./server/components/dynamicChart.R')

source("./components/modules/generateDynamicChartModal.R")



server <- function(input, output, session) {
	

#	sampleSurvey <- "E:\\survey-shiny-app\\www\\resources\\sample.csv"
	sampleSurvey <- "https://raw.githubusercontent.com/Dyzio18/R-learning/master/sample.csv"

df <<- dataFileReact <- reactive({
	result <- df
	result <- df <- read.csv(sampleSurvey,
						header = input$header,
						sep = input$sep,
						quote = input$quote)
						
	if (!is.null(input$dataFile$datapath)) {
		tryCatch({
			result <- read.csv(input$dataFile$datapath,
						header = input$header,
						sep = input$sep,
						quote = input$quote)
		}, error = function(e) {
			stop(safeError(e))
		})
	}
	return(result)
})
	
	
	output$headers <- renderTable({
		colnames(dataFileReact())
	})
	
	output$uiBoxDetail <- renderUI({
	if(is.null(dataFileReact())) return()
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

	# ------------------------

	
	histPlotDataFile <- eventReactive(
		input$datasetHistSubmit,
		{
			dataFileReact()[[ input$datasetSelectColumn ]]
		}
	)
	
	output$datasetHistPlot <- renderPlot({
		data <- histPlotDataFile()[]
		hist(data, breaks = input$datasetHistSlider)
	})
	
	
	# ------------------------------

	output$contents <- renderTable({
	# req(input$dataFile)

	if (input$disp == "head") {
		return(head(dataFileReact()))
	}
	else {
		return(dataFileReact())
	}
	})




	# -----------------------
	# -----------------------
	# mainPanel

	histPlot_df <- eventReactive(
	input$submit,
	{
		df[[ input$columnChoice ]]
	}
	)
	
	output$histPlot <- renderPlot({
	data <- histPlot_df()[ seq_len(input$slider) ]
	hist(data)
	})

	# -----------------------
	# -----------------------
	# widgetPanel
	 # display 10 rows initially
	output$ex1 <- DT::renderDataTable(
	DT::datatable(
		dataFileReact(),
		filter = 'top',
		extensions = 'Buttons',
		options = list(pageLength = 10, buttons = I('colvis'))
	)
	)

	# --- Vizualization ---

	# df <- callModule(generateDynamicChartModal, "visualisationGenerateChart1", dataFileReact() )

	

	# ==============================
	# ==============================
	# ==============================
	# Mockup
	# ==============================
	# ==============================
	# ==============================
	output$pieChartMockup1 <- renderPlot({
		data <- dataFileReact()[[ 1 ]]
		pie(table(data))
	})

	output$pieChartMockup2<- renderPlot({
		data <- dataFileReact()[[1]]
		hist(data)
	})

	output$pieChartMockup3 <- renderPlot({
		data <- dataFileReact()[[3]]
		pie(table(data))
	})




	# ==============================
	# ==============================
	# ==============================
	# ==============================
	# ==============================
	# ==============================
	# ==============================

# -------------------------
# --- Clustering Module ---

	# render UI Setup
	output$uiClusteringSetup <- renderUI({
		if(is.null(dataFileReact())) return()
		# return
		column(6,
			selectInput(
				"clusteringSelectColumnY",
				"Choose a column Y:",
				choices = colnames(dataFileReact())
			),
			selectInput(
				"clusteringSelectColumnX",
				"Choose a column X:",
				choices = colnames(dataFileReact())
			),
			numericInput('clusters', 'Cluster count', 3,
				min = 1, max = 9
			),
			actionButton(
				inputId = "clusteringSubmit",
				label = "Submit"
			)
		)
	})

	# submit listener 
	clusteringData <- reactive({
		dataFileReact()[, c(input$clusteringSelectColumnY, input$clusteringSelectColumnX )]
	})

	clusters <- reactive({
		kmeans(clusteringData(), input$clusters)
	})

	output$clusteringPlot <- renderPlot({
		palette(c("#E41A1C", "#377EB8", "#4DAF4A", "#984EA3",
		"#FF7F00", "#FFFF33", "#A65628", "#F781BF", "#999999"))

		par(mar = c(5.1, 4.1, 0, 1))
		plot(clusteringData(),
			col = clusters()$cluster,
			pch = 20, cex = 3)
		points(clusters()$centers, pch = 4, cex = 4, lwd = 4)
	})
# // Clustering Module 
# -------------------------

# -------------------------
# --- descriptive_statistics Module ---
# output[['descriptive_statistics_summary']] <- renderPrint({
# 	dataset <- dataFileReact()
# 	summary(dataset)
# })


# Descriptive stats UI loop 
output$descriptive_statistics_stat <- renderUI({
	dataset <- dataFileReact()

	for(i in names(dataset)){

		statsString = "<table style=\"width:100%\" class=\"table table-bordered\"><tr>"
		summStats <- summary(dataset[[i]])
		for(summElem in names(summStats)){
			statsString <- paste(statsString, '<th>', summElem, '</th>')
		}
		statsString <- paste(statsString,'</tr><tr>')
		for(summElem in names(summStats)){
			statsString <- paste(statsString, '<td>', summStats[[summElem]], '</td>')
		}
		statsString <- paste(statsString,'</tr></table>')

		insertUI(
			selector = "#descriptive_statistics_descElem",
			where = "beforeEnd",
			ui = box(
				title = i, solidHeader = TRUE, width=6,
				i18n$t("Summary statistic"), br(),
				HTML(statsString)
			)
		)
	}	
	
	return()
})

output$descriptive_statistics_uiBoxSelect <- renderUI({
	if(is.null(dataFileReact())) return()
	# return
	column(6,
		selectInput(
			"descriptive_statistics_column",
			i18n$t("Choose a column:"),
			choices = colnames(dataFileReact())
		)
	)
})
observeEvent(
	input$descriptive_statistics_column,
	{
		output$descriptive_statistics_box <- renderPlot({
			boxplot(dataFileReact()[, input$descriptive_statistics_column])
		})
	}
)


# // descriptive_statistics Module ---
# -------------------------


# -------------------------
# --- Settings Module ---

	skinTheme <- reactive({	
		theme <- "blue"						
		theme <- input$skinThemeRadio 
		return(theme)
	})
	output$theme <- renderText({
		skinTheme()
	}) 



	# i18nLanguage <- reactive({	
	# 	lang <- "en"						
	# 	#lang <- input$languageRadio 
	# 	return(lang)
	# })

	# language <- reactive({
	# 	selected <- input$selected_language
	# 	if (length(selected) > 0 && selected %in% translator$languages) {
	# 		translator$set_translation_language(selected)
	# 	}
	# 	translator
	# })

# // Settings Module
# -------------------------

	




}
