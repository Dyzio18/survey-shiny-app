###################
# global.R
# Shared element between ui and server
###################

#  Translation
library(shiny.i18n)
i18n <- Translator$new(translation_json_path = "i18n/translation.json")
# language <- "en"
language <- "pl"
i18n$set_translation_language(language)