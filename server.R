# library(shinydashboard)

source('./modules/uploadModule.R')
source('./modules/previewModule.R')
source('./modules/settingsModule.R')
source('./modules/dashboard/fileDetailsModule.R')



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
			fileDetailsModule,
			"fileDetails",
			df()
		)
    })

	# Settings
	settings <- callModule(
		settingsModule,
		"settings"
	)



}
