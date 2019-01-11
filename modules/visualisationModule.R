# visualisation Module

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
        column(12,
            id = "plotContainerId",
        )
    )
}

###################
# Server
###################
visualisationModule <- function(input, output, session, data) {
    ns <- session$ns
    
    output$initButtons <- renderUI({
        
        column(12,
            actionButton(
                ns("boxplotBtn"),
                "Boxplot",
                icon = icon("bar-chart-o")
            )
        )
    })

    observeEvent(input$boxplotBtn, {

        # TODO: show MODAL for BOXPLOT
        # TODO: action button in modal trigger insert UI
        # TODO: Data picker in modal 
        # TODO: Generate simple plot from choose data 
        # TODO: data selector (WHERE example: choose column and only this data where column value == "X")
        # TODO: Data validation 
        # TODO: Implement other plots (min. 4)
            insertUI(
                selector = "#plotContainerId", 
                where = "beforeBegin",

                ui = h2("HEJ")
            )
        }
    )

}