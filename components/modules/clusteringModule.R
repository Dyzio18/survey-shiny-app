# Statistics > Clusterning Module
# Generate raport and export to PDF

clusteringModuleUI <- tabItem(
    tabName = "clustering",
    h2(i18n$t("Clustering")),
    box( width = 12, 
        column(12,uiOutput("uiClusteringSetup"))
		
    ),


    box(width = 12, class="blankPage",
        div(
          h3('Clustering', class="blankPage__message")
        ),
        plotOutput("clusteringPlot")

    )
)
