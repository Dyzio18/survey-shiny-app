source("./components/modules/generateDynamicChartModal.R")

visualisationModuleUI <- tabItem(
	tabName = "visualisation",
	h2("Visualisation"),
	tags$div(id = 'placeholder'),
	fluidRow(
		# Create chart modal
		tags$div(
		  generateDynamicChartModalUI("visualisationGenerateChart1")
		),
		box(
			title = "Pie chart - Music", status = "primary", solidHeader = TRUE,
			id = "chartGenerateBox",
			width = 6,
			plotOutput("pieChartMockup1")
		),
		box(
			title = "Histgram - Music", status = "primary", solidHeader = TRUE,
			id = "AAS1e13as",
			width = 6,
			plotOutput("pieChartMockup2")
		),
		box(
			title = "Pie chart - Dance", status = "primary", solidHeader = TRUE,
			id = "BDA3RASAAsf",
			width = 6,
			plotOutput("pieChartMockup3")
		)
	)
)



# # CONTROLS
		# box
		#   title = "Controls",
		#   # Choose a column
		#   selectInput(
		#     "columnChoice",
		#     "Choose a column:",
		#     choices = colnames(df),
		#     selected = "n"
		#   ),          
		#   sliderInput("slider", "Number of observations:", 1, 100, 50),          
		#   # Create an eventReactive element
		#   actionButton(
		#     inputId = "submit",
		#     label = "Submit column"
		#   )
		# ),
		# # PLOT
		# box(
		#   plotOutput("histPlot")
		# )