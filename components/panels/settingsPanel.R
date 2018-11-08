settingsPanel <- tabItem(
    tabName = "settings",
    h2("Settings"),
    fluidRow(
        column(width = 4,
            box(
                title = "Color theme", width = NULL, background = "light-blue",
                radioButtons("colorThemeRadio", p("Choose color theme"),
                choices = list(
                    "blue" = 1,
                    "black" = 2,
                    "yellow" = 3), selected = 1)
            )
        ),
        column(width = 4,
            valueBox(
                "#","Other", icon = icon("list"),
                color = "purple"
            )
        )
    )
)
