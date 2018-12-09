# Settings Module
library(shiny.i18n)

settingsModuleUI <- tabItem(
    tabName = "settings",
    h2(i18n$t("Settings")),
    fluidRow(
        column(width = 4,
            box(
                title = i18n$t("Color theme"), width = NULL, background = "light-blue",
                radioButtons("skinThemeRadio", p(i18n$t("Choose color theme:")),
                    choices = list(
                        "blue" = "blue",
                        "black" = "black",
                        "purple" = "purple",
                        "green" = "green",
                        "red" = "red",
                        "yellow" = "yellow"), selected = "blue"
                )
            )
        ),
        column(width = 4,
            valueBox(
                "#", h3(textOutput("theme")), icon = icon("list"),
                color = "navy"
            ),
            tags$script(src = "js/changeTheme.js")
        )
    )
)
