###################
# global.R
# 
# Anything you want shared between your ui and server, define here.
###################

# install.packages("tm")  # for text mining
# install.packages("SnowballC") # for text stemming
# install.packages("wordcloud") # word-cloud generator 
# install.packages("RColorBrewer") # color palettes

# library("tm")
# library("SnowballC")
# library("wordcloud")
# library("RColorBrewer")

#  Translation
library(shiny.i18n)
i18n <- Translator$new(translation_json_path = "i18n/translation.json")
# language <- "en"
language <- "pl"
i18n$set_translation_language(language)


set.seed(122)
df <- data.frame(
  n = rnorm(500),
  m = rnorm(500)
)




