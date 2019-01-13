###################
# functions.R
###################


colName <- function(word) {
    result <- gsub("\\.", " ", word)

    return(result)
}