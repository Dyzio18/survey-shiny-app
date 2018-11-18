# Vizualization Module - dynamic generate charts 

library(shiny)
library(ggplot2)

generateDynamicChartModalUI <- function(id) {
	ns <- NS(id)

	# TEST
	tags$head(tags$script(src = "js/msgHandler.js"))


	fluidRow(
    	actionButton("show", class="btn btn-success btn-circle btn-xl generateChart__button--add", "data-toggle"="modal", 
			"data-target"="#idGenerateChart__modal", 
			" ", icon = icon("plus", "fa-10x", lib = "font-awesome")
		),

		# Modal
		tags$div(id="idGenerateChart__modal", class="modal ", 'tabindex'="-1", 'role'="dialog",
			tags$div( class="modal-dialog", 'role'="document",
				tags$div( class="modal-content generateChart__modal",
					tags$div( class="modal-header",
						h3("Choose chart type:"),
						tags$div( class="generateChart__box",
							uiOutput(ns("chooseChartCard__pie")),
							uiOutput(ns("chooseChartCard__hist")),
							uiOutput(ns("chooseChartCard__box")),
							uiOutput(ns("chooseChartCard__chart_x1")),
							uiOutput(ns("chooseChartCard__chart_x2")),
							uiOutput(ns("chooseChartCard__chart_x3"))
						),
						uiOutput(ns("generateChart__options"))
					) 
				) 
			) 

		),
	
		tags$hr()
	)
}

generateDynamicChartModal <- function(input, output, session, data) {
	id = "visualisationGenerateChart1"
	ns <- NS(id)

	dataWithSelection <- reactive({
		brushedPoints(data(), input$brush, allRows = TRUE)
	})

	chartsTypes <- c("pie", "hist", "points", "chart_x1", "chart_x2", "chart_x3")

	# for (type in chartsTypes){
	# 	output[[paste("chooseChartCard__", type, sep="")]] <- renderUI({ui = chartCardHTML(type, "/img/charts/pie.png")})
	# }

	#  Generate Cards (choose chart type)
	output$chooseChartCard__pie <- renderUI({ui = chartCardHTML("pie", "/img/charts/pie.png", id)})
	output$chooseChartCard__hist <- renderUI({ui = chartCardHTML("hist", "/img/charts/hist.png", id)})
	output$chooseChartCard__box <- renderUI({ui = chartCardHTML("box", "/img/charts/boxplot.png", id)})
	output$chooseChartCard__chart_x1 <- renderUI({ui = chartCardHTML("sample-1", "/img/charts/chartdemo.png", id)})
	output$chooseChartCard__chart_x2 <- renderUI({ui = chartCardHTML("sample-2", "/img/charts/chartdemo.png", id)})
	output$chooseChartCard__chart_x3 <- renderUI({ui = chartCardHTML("sample-3", "/img/charts/chartdemo.png", id)})


	# GenerateButton Observes (generate charts options)
	# Pie
	observeEvent(input$generateButton__pie, {
		output$generateChart__options <- renderUI({
			ui = chartOptionHTML("pie", data, id )
		})
	})

	# observeEvent(input$createChartBtn__pie, {
	# 	insertUI(
	# 		selector = '#placeholder',
	# 		ui = chartHTML__pie(id,data)
	# 	)}
	# )

	# output$plot1 <- renderPlot({	
	# 	scatterPlot(dataWithSelection(), left())
	# })

 	return(dataWithSelection)
}

scatterPlot <- function(data, cols) {
	ggplot(data, aes_string(x = cols[1], y = cols[2])) +
		geom_point(aes(color = selected_)) +
		scale_color_manual(values = c("black", "#66D65C"), guide = FALSE)
}

# Chart CARD
chartCardHTML <- function(name, imgSrc, id) {
	ns <- NS(id)
	tags$div( class="card chartCard",
		tags$img( class="card-img-top chartCard__img", src=imgSrc, 
			tags$div( class="card-body",
				h5( paste(name, "chart" , sep = " "), class="card-title"),
				actionButton(ns(paste("generateButton__", name , sep = "")), class="btn btn-primary text--white", "Generate")
			)
		)
	)
}

# Chart OPTIONS
chartOptionHTML <- function(chartType, data, id) {
	ns <- NS(id)

	tags$div( class="generateChart__box",
		h3("Options:"),
		# p(chartType),

	#	if(chartType == "pie"){
			selectInput(
				ns(paste("createChartColumn__", chartType , sep = "")),
				"Choose a column:",
				choices = colnames(data)
			),
			actionButton(ns(paste("createChartBtn__", chartType , sep = "")), "Create chart")

	#	}
	)
}


# PIE CHART
chartHTML__pie <- function(id, data) {
	box(
		plotOutput("pieChartMockup23")
	)
}



