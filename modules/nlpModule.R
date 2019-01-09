# nlp Module
library(dplyr)
library(tidyr)
library(ggplot2)
# library(tm)
library(wordcloud)
library(memoise)
library(tidytext)
library(stringr)

###################
# UI
###################
nlpModuleUI <- function(id) {
    ns <- NS(id)
    fluidRow(
        h2(class="panel__title", "Text minning"),
        uiOutput(ns("sidebar")),
        uiOutput(ns("resultBoxes"))
    )
}

###################
# Server
###################
nlpModule <- function(input, output, session, data) {
    ns <- session$ns

    stopWords <- c(" ", "a", "about", "above", "after", "again", "against", "all", "am", "an", "and", "any", "are", "as", "at", "be", "because", "been", "before", "being", "below", "between", "both", "but", "by", "could", "did", "do", "does", "doing", "down", "during", "each", "few", "for", "from", "further", "had", "has", "have", "having", "he", "he’d", "he’ll", "he’s", "her", "here", "here’s", "hers", "herself", "him", "himself", "his", "how", "how’s", "I", "I’d", "I’ll", "I’m", "I’ve", "if", "in", "into", "is", "it", "it’s", "its", "itself", "let’s", "me", "more", "most", "my", "myself", "nor", "of", "on", "once", "only", "or", "other", "ought", "our", "ours", "ourselves", "out", "over", "own", "same", "she", "she’d", "she’ll", "she’s", "should", "so", "some", "such", "than", "that", "that’s", "the", "their", "theirs", "them", "themselves", "then", "there", "there’s", "these", "they", "they’d", "they’ll", "they’re", "they’ve", "this", "those", "through", "to", "too", "under", "until", "up", "very", "was", "we", "we’d", "we’ll", "we’re", "we’ve", "were", "what", "what’s", "when", "when’s", "where", "where’s", "which", "while", "who", "who’s", "whom", "why", "why’s", "with", "would", "you", "you’d", "you’ll", "you’re", "you’ve", "your", "yours", "yourself", "yourselves")

    # Render sidebar 
    output$sidebar <- renderUI({
        sidebarPanel(
            selectInput(
                ns("selection"), 
                i18n$t("Choose column"),
                choices = names(data)
            ),
            sliderInput(
                ns("freq"),
                "Minimum frequency:",
                min = 1,
                max = 50,
                value = 15
            ),
            sliderInput(
                ns("max"),
                "Maximum number of words:",
                min = 1,
                max = 300,
                value = 100
            ),
            sliderInput(
                ns("minLengthWord"),
                "Maximum word length:",
                min = 1,
                max = 10,
                value = 1
            ),
            hr(),
            actionButton(ns("submit"), "Submit")
        )
    })

    output$resultBoxes <- renderUI({
        column(12,
            box(
                title = "Words cloud",
                status = "primary", solidHeader = TRUE,
                plotOutput(ns("wordCloud"))
            ),
            box(
                title = "Words popularity",
                status = "primary", solidHeader = TRUE,
                plotOutput(ns("wordCounter"))
            ),
            box(
                title = "Words sentiment",
                status = "info", solidHeader = TRUE,
                plotOutput(ns("wordSentiment"))
            )
        )
    })

    selectedColumn <- eventReactive(input$submit, {
        validate(need(is.factor(data[[input$selection]]), "Please select string data"))
        input$selection
    })

    text <- reactive({
        textRaw <- data[[selectedColumn()]] %>% toString()
        textRaw <- gsub("[^0-9A-Za-z///' ]","" , textRaw ,ignore.case = TRUE)
        textRaw <- strsplit(textRaw, ",| ")
        textRaw <- data.frame(lapply(textRaw, as.character), stringsAsFactors=FALSE)
        colnames(textRaw) <- c("word")
        result <- textRaw %>% filter(!word %in% stopWords) %>% filter(nchar(word) >= input$minLengthWord)
    })

    textCount <- reactive({
        result <- text() %>% count(word, sort = TRUE)
    })

    output$wordCounter <- renderPlot({
        plotCount <- textCount() %>%
            top_n(50, n) %>%
            mutate(word = reorder(word, n)) %>%
            ggplot() +
            geom_col(aes(word, n), fill = "lightgreen") +
            coord_flip() +
            labs(title = "Words popularity",
                y = "Counter", x = "")
        
        plot(plotCount)
    })

    output$wordCloud <- renderPlot({
        wordcloud(
            textCount()$word,
            textCount()$n,
            min.freq = input$freq, max.words=input$max,
            scale=c(5,1),
            colors = RColorBrewer::brewer.pal(9, "Reds")[5:9]
        )
    })

    output$wordSentiment <- renderPlot({
        textSentiments <- textCount() %>% 
            inner_join(get_sentiments("bing"))

        ggplot(textSentiments, aes(sentiment, n)) +
            geom_col(show.legend = FALSE) 
    })

    output$selectTest <- renderUI({
        h3(
            class(selectedColumn())
        )
    })

}