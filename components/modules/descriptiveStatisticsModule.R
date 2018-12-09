# Statistics > Clusterning Module
# Generate raport and export to PDF

descriptiveStatisticsUI <- tabItem(
    tabName = "descriptive_statistics",
    h2(i18n$t("Descriptive statistics")),
    div( 
        id="descriptive_statistics_descElem",
        uiOutput("descriptive_statistics_stat")
    ),
    box(width = 6,
        column(12, uiOutput("descriptive_statistics_uiBoxSelect")),
        column(12, plotOutput("descriptive_statistics_box"))
    )
)
