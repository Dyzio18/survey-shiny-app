widgetPanel <- tabItem(
    tabName = "widgets",
    h2("Data table"),
    box(width = 12,
        div(
          h3('Display length'), 
            style = 'overflow-x: scroll',
            DT::dataTableOutput('ex1')
        )
    )
)

