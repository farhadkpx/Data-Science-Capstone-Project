
library(tm)
# data source path
setwd("C:/Users/paralax11/Desktop/Data_Science_Capstone_Project/Project_Capstone/Word_Prediction_Project")

  # Reading 'Rda' data-frame files from sources
unigram <- readRDS(file = "Data/unigram_test.Rda")

bigram <- readRDS(file = "Data/bigram_test.Rda")
trigram <- readRDS(file = "Data/trigram_test.Rda")
fourgram <- readRDS(file = "Data/fourgram_test.Rda")
fivegram <- readRDS(file = "Data/fivegram_test.Rda")

  # Defining the Predict-Next-Word function
  #---------------------------------------------------------
Predict.Next.Word <- function(Text.Input) {
  
  if(nchar(Text.Input) > 0) {
    
    # cleaning user Text Input
    Text.Input <- tolower(Text.Input)
    Text.Input <- removePunctuation(Text.Input)
    Text.Input <- removeNumbers(Text.Input)
    Text.Input <- stripWhitespace(Text.Input)
    
    # splitting input strings and turned them into vectors
    InputObject <- unlist(strsplit(Text.Input, split =  " "))
    
   
    # getting the length of each input vector
    Word.Count <- length(InputObject)
    
    ###########################################################
    # defining some basic reader functions for text analysis
    # bigram separating files
    Use.Bigram <- function(words)
    {
      bigram[bigram$string$one == words,]$string$two
    }
    
    # defining Use.Trigram function
    Use.Trigram <- function(words)
    {
      trigram[trigram$string$one == words[1] &
                     trigram$string$two == words[2],]$string$three
    }
    
    # Use.Fourgram function
    Use.Fourgram <- function(words)
    {
      fourgram[ fourgram$string$one == words[1] &
                fourgram$string$two == words[2] &
                fourgram$string$three == words[3],]$string$four
    }
    
   #  Use.Fivegram function 
   Use.Fivegram <- function(words)
    {
       fivegram[ fivegram$string$one == words[1] & 
                 fivegram$string$two == words[2] &
                 fivegram$string$three == words[3] &
                 fivegram$string$four == words[4],]$string$five
    }
    
    
   ################################################################
    # Using defined 'Ngram-Usage-functions' to predict next word
   
    if(Word.Count == 1) 
    {
    # using bigram functions if only a single input
      predictd.Words <- Use.Bigram(InputObject[1])
    }    
    
    # using trigram functions while 2-input words
    else if (Word.Count == 2)
      {
      word1 <- InputObject[1]
      word2 <- InputObject[2]
      predictd.Words <- Use.Trigram(c(word1, word2))
      
      if(length(predictd.Words) == 0)
      {
         # if trigram fails, find bigram function
        predictd.Words <- Use.Bigram(word2)
      }
     }
    
   # using fourgram functions while 3-input words
    else if (Word.Count == 3)
      {
      word1 <- InputObject[Word.Count-2]
      word2 <- InputObject[Word.Count-1]
      word3 <- InputObject[Word.Count]
      predictd.Words <- Use.Fourgram(c(word1, word2, word3)) 
      
      if(length(predictd.Words) == 0)
      {
          # if fourgram fails find trigram function
        predictd.Words <- Use.Trigram(c(word2,word3))
      }
          # if trigram fails find bigram function
      if(length(predictd.Words) == 0)
      {
        predictd.Words <- Use.Bigram(word3)
      }
    } 
     #-------------------------------------------
     # using fivegram functions while 4-input words 
      else {   # grams descends[ 5 > 4 > 3 > 2 grams]
      word1 <- InputObject[Word.Count-3]
      word2 <- InputObject[Word.Count-2]
      word3 <- InputObject[Word.Count-1]
      word4 <- InputObject[Word.Count]
      predictd.Words <- Use.Fivegram(c(word1, word2, word3, word4))
        
         # if fivegram fails, find fourgram function
      if(length(predictd.Words) == 0)
      {
        predictd.Words <- Use.Fourgram(c(word2,word3,word4))
      }
         # if fourgram fails, run trigram function
      if(length(predictd.Words) == 0)
      {
          predictd.Words <- Use.Trigram(word3,word4)
      }  
      # if fourgram fails, run bigram function
       if(length(predictd.Words) == 0)
       {
         predictd.Words <- Use.Bigram(word4)
       }
    }
    
    #-------------------------------------------------------
    #Returning all top n predictors
    k <- 5
    pw <- length(predictd.Words)
      # setting the output frequency to five
    if( pw >= k)
    {
      predictd.Words <- predictd.Words[1:k]
    }
    as.character(predictd.Words)
    }else{ "" }
  
}

