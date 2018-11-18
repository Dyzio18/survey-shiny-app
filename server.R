library(shinydashboard)

source('./server/histBox.R')
# source('./server/components/dynamicChart.R')

source("./components/modules/generateDynamicChartModal.R")



server <- function(input, output, session) {
	

	sampleSurvey <- "E:\\survey-shiny-app\\www\\resources\\young-people-survey_kaggle.csv"
	#sampleSurvey <- "https://raw.githubusercontent.com/Dyzio18/R-learning/master/young-people-survey_kaggle.csv"

dataFileReact <- reactive({
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
			sliderInput("datasetHistSlider", "Number of obQservations:", 1, 36, 10),
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

	df <- callModule(generateDynamicChartModal, "visualisationGenerateChart1", dataFileReact() )

	

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




	# --- SETTINGS ---

	skinTheme <- reactive({	
		theme <- "blue"						
		theme <- input$skinThemeRadio 
		return(theme)
	})

	output$theme <- renderText({
		skinTheme()
	}) 
 
	

	
}
