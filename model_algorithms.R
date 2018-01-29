
library(tm)
#library(wordcloud)

setwd("C:/Users/paralax11/Desktop/Data_Science_Capstone_Project/Project_Capstone/Word_Prediction_Project")

  # Reading 'Rda' data-frame files from sources
unigram <- readRDS(file = "Data/unigram_test.Rda")

bigram <- readRDS(file = "Data/bigram_test.Rda")
trigram <- readRDS(file = "Data/trigram_test.Rda")
fourgram <- readRDS(file = "Data/fourgram_test.Rda")
fivegram <- readRDS(file = "Data/fivegram_test.Rda")

  # Defining the main next word predict function
  #---------------------------------------------------
PredictNextWord <- function(TextInput) {
  
  if(nchar(TextInput) > 0) {
    
    # cleaning user Text Input
    TextInput <- tolower(TextInput)
    TextInput <- removeNumbers(TextInput)
    TextInput <- removePunctuation(TextInput)
    TextInput <- stripWhitespace(TextInput)
    
    # splitting input strings and turned them into vectors
    InputObject <- unlist(strsplit(TextInput, split = " "))
    
    # getting the length of each vector
    numWords <- length(InputObject)
    
    # defining some basic reader functions for text analysis
    # bigram separating files
    Use.Bigram <- function(words){
      bigram[bigram$string$one == words,]$string$two
    }
    
    # Use.Trigram function
    Use.Trigram <- function(words){
      trigram[trigram$string$one == words[1] &
                trigram$string$two == words[2],]$string$three
    }
    
    # Use.Fourgram function
    Use.Fourgram <- function(words) {
      fourgram[ fourgram$string$one == words[1] &
                  fourgram$string$two == words[2] &
                  fourgram$string$three == words[3],]$string$four
    }
    
    # Use.Fivegram function 
    Use.Fivegram <- function(words) {
       fivegram[ fivegram$string$one == words[1] & 
                    fivegram$string$two == words[2] &
                      fivegram$string$three == words[3] &
                         fivegram$string$four == words[4],]$string$five
    }
    
    # Using defined 'Ngram-Usage-functions' to predict next word
    #------------------------------------------------------
    if(numWords == 1) {
    # using bigram functions
      predictd.Words <- Use.Bigram(InputObject[1])
    }    
    # using trigram functions
    else if (numWords == 2) {
      word1 <- InputObject[1]
      word2 <- InputObject[2]
      predictd.Words <- Use.Trigram(c(word1, word2))
      
      if(length(predictd.Words) == 0){
         # if trigram fails find bigram function
        predictd.Words <- Use.Bigram(word2)
      }
    }# using fourgram functions
    else if(numWords == 3) {
      word1 <- InputObject[1]
      word2 <- InputObject[2]
      word3 <- InputObject[3]
      predictd.Words <- Use.Fourgram(c(word1, word2, word3)) 
      
      if(length(predictd.Words) == 0){
        # if fourgram fails find trigram function
        predictd.Words <- Use.Trigram(word3)
      }
    }   
    
    else {   # grams descends[ 5 > 4 > 3 > 2 grams]
      # now running fivegram function
      word1 <- InputObject[numWords-3]
      word2 <- InputObject[numWords-2]
      word3 <- InputObject[numWords-1]
      word4 <- InputObject[numWords]
      predictd.Words <- Use.Fivegram(c(word1, word2, word3, word4))
      
      if(length(predictd.Words) == 0){
        # if fivegram fails find fourgram function
        predictd.Words <- Use.Fourgram(c(word3,word4))
      }
      
      if(length(predictd.Words) == 0){
        # if fourgram fails run trigram
        predictd.Words <- Use.Trigram(word4)
      }
    }
    
    #Returning all top n predictors
    k <- 5
    pw <- length(predictd.Words)
    
    if( pw >= k){
      predictd.Words <- predictd.Words[1:k]
    }
    
    as.character(predictd.Words)
  }else{
    ""
  }
  
}

