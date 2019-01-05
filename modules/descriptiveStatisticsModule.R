library(ggplot2)

###################
# UI
###################
descriptiveStatisticsModuleUI <- function(id) {
    ns <- NS(id)
    fluidRow(
        h2(class="panel__title", i18n$t("Descriptive statistics")),
        div( 
            id="descriptive_statistics_descElem",
            uiOutput(ns("descriptive_statistics_stat"))
        )
    )
}

###################
# Server
###################
descriptiveStatisticsModule <- function(input, output, session, data) {

    output$descriptive_statistics_stat <- renderUI({
        dataset <- data

        for(i in names(dataset)){
            # Numeric
            if (is.numeric(dataset[[i]])) {
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
                # currentIndex = i

                insertUI(
                    selector = "#descriptive_statistics_descElem",
                    where = "beforeEnd",
                    ui = box(
                        title = i, solidHeader = TRUE, width=6,
                        i18n$t("Summary statistic"), br(),
                        HTML(statsString)
                        # renderPlot(
                        #     plot(
                        #             dataset[[currentIndex]],
                        #             xlab="N", 
                        #             ylab="value"
                        #     )
                        # )
                    )
                )
            } 
            # // Numeric


        }
        
        return()
    })



}