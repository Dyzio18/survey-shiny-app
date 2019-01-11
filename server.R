# @Author: Patryk Nizio "Dyzio" / 2019

source('./modules/uploadModule.R')
source('./modules/previewModule.R')
source('./modules/visualisationModule.R')
source('./modules/descriptiveStatisticsModule.R')
source('./modules/clusteringModule.R')
source('./modules/nlpModule.R')
source('./modules/aboutProgramModule.R')

server <- function(input, output, session) {
		
	df <- callModule(
			uploadModule,
			"upload",
			stringsAsFactors = TRUE
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
			visualisationModule,
			"visualisation",
			df()
		)
		callModule(
			clusteringModule,
			"clustering",
			df()
		)
		callModule(
			nlpModule,
			"nlp",
			df()
		)
    })

	# About
	about <- callModule(
		aboutProgramModule,
		"aboutProgram"
	)

}
