settingsModuleUI <- tabItem(
    tabName = "settings",
    h2("Settings"),
    fluidRow(
        column(width = 4,
            box(
                title = "Color theme", width = NULL, background = "light-blue",
                radioButtons("skinThemeRadio", p("Choose color theme"),
                choices = list(
                    "blue" = "blue",
                    "black" = "black",
                    "purple" = "purple",
                    "green" = "green",
                    "red" = "red",
                    "yellow" = "yellow"), selected = "blue")
            )
        ),
        column(width = 4,
            valueBox(
                "#", textOutput("theme"), icon = icon("list"),
                color = "navy"
               
            ),
            tags$script(src = "js/changeTheme.js")

        )
    )
)
