# library(shinydashboard)

source('./modules/uploadModule.R')
source('./modules/previewModule.R')
source('./modules/descriptiveStatisticsModule.R')
source('./modules/clusteringModule.R')
source('./modules/aboutProgramModule.R')

server <- function(input, output, session) {
	
	sampleSurvey <- "E:\\survey-shiny-app\\www\\resources\\sample.csv"
	# sampleSurvey <- "https://raw.githubusercontent.com/Dyzio18/R-learning/master/sample.csv"
	
	df <- callModule(
			uploadModule,
			"upload",
			stringsAsFactors = FALSE
		)


    observe({
		df()
		callModule(
			previewModule,
			"preview",
			df()
		)
		callModule(
			descriptiveStatisticsModule,
			"descriptiveStatistics",
			df()
		)
		callModule(
			clusteringModule,
			"clustering",
			df()
		)
    })

	# About
	about <- callModule(
		aboutProgramModule,
		"aboutProgram"
	)


}
