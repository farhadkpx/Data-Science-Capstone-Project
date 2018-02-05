# adding all the required libraries
suppressPackageStartupMessages(c(library(doParallel), library(tm), library(RWeka),
                                 require(reshape), library(data.table)))

# setup parallel backend processors
cluster <- makeCluster(detectCores() - 1)
registerDoParallel(cluster)

set.seed(752)
setwd("C:/Users/paralax11/Desktop/Data_Science_Capstone_Project/Project_Capstone/Word_Prediction_Project")

# reading all three text files separately with conditionals
blogs_data <- readLines("en_US.blogs.txt", encoding = 'utf-8', skipNul = T, warn = F)
news_data <-  readLines("en_US.news.txt", encoding = 'utf-8',  skipNul = T, warn = F)
twitter_data <- readLines("en_US.twitter.txt",  encoding = 'utf-8', skipNul = T, warn = F)

#Source http://www.freewebheaders.com/full-list-of-bad-words-banned-by-google/
bad_words_data <- readLines("full-list-of-bad-words-banned-by-google.txt", skipNul = T, warn = F)
head(bad_words_data)

# calculating line-length of each file
blogs_lines <- length(blogs_data)
news_lines <- length(news_data)
twitter_lines <- length(twitter_data)

#===========================================================
# Creating smaller samples for further processing and create a corpus
sample_percent <- .10
blogs_sample <- blogs_data[sample(1:blogs_lines, blogs_lines * sample_percent)]
news_sample <- news_data[sample(1:news_lines, news_lines * sample_percent)]
twitter_sample <- twitter_data[sample(1:twitter_lines, twitter_lines * sample_percent)]

# combining all the sample data in one file and then delete for  
sample_data <- list(blogs_sample, news_sample, twitter_sample)
rm(blogs_data, news_data, twitter_data )

# Creating vectorizing Corpus
SampleCorpus <- VCorpus(VectorSource(sample_data))

# Clean up corpus in detail as per project requirements
SampleCorpus <- tm_map(SampleCorpus, content_transformer(tolower))
SampleCorpus <- tm_map(SampleCorpus, removeWords, bad_words_data )
SampleCorpus <- tm_map(SampleCorpus, removeNumbers)
SampleCorpus <- tm_map(SampleCorpus, removePunctuation)
SampleCorpus <- tm_map(SampleCorpus, stripWhitespace)

# more pattern wise[unwarranted contents] cleaning
ChangetoSpace <- content_transformer(function(x, pattern) gsub(pattern, " ", x))
SampleCorpus <- tm_map(SampleCorpus, ChangetoSpace, "(f|ht)tp(s?)://(.*)[.][a-z]+")
SampleCorpus <- tm_map(SampleCorpus, ChangetoSpace, "@[^\\s]+")

# sample corpus analysis with most frequent words
dtm <- DocumentTermMatrix(SampleCorpus, control = list(stopwords = TRUE))
tdm_mtrx <- as.matrix(dtm)
sample_frequency <- colSums(tdm_mtrx)
sample_frequency <- sort(sample_frequency, decreasing = TRUE)

sample_frequency <- data.frame(sample = names(sample_frequency), frequency=sample_frequency)
saveRDS(sample_frequency, "data/sample_frequency.Rda")

# displaying most frequent sampled words
sampleList <- setDT(sample_frequency)
head(sampleList)

##############################################################################################
#=====================================NGRAMS==================================================
# tokenizing  unigrams

ngramTokenizer <- function(l) {
  function(x) unlist(lapply(ngrams(words(x), l), paste, collapse = " "), use.names = FALSE)
}

# generate unigram data set
generateNgramData <- function(n) {
  if(n == 1) 
  {
    Ngram_tdm <- TermDocumentMatrix(SampleCorpus)
  } 
  else {
    Ngram_tdm <- TermDocumentMatrix(SampleCorpus, control = list(tokenize = ngramTokenizer(n)))
  }
  
  Ngram_matrix <- as.matrix(Ngram_tdm)
  Ngram_matrix <- rowSums(Ngram_matrix)
  Ngram_matrix <- sort(Ngram_matrix, decreasing = TRUE)
  
  final_Ngram <- data.frame(string = names(Ngram_matrix), frequency = Ngram_matrix)
  
  if(n == 2) columns <- c('one', 'two')
  if(n == 3) columns <- c('one', 'two', 'three')
  if(n == 4) columns <- c('one', 'two', 'three', 'four')
  if(n == 5) columns <- c('one', 'two', 'three', 'four', 'five')
  
  if(n > 1) {
    final_Ngram <- transform(final_Ngram, string = colsplit(string, split = " ", names = columns
    ))
  }
  
  rownames(final_Ngram) <- NULL
  final_Ngram
}

# creating four N-Gram files
unigram_frame <- generateNgramData(1)

bigram_frame <- generateNgramData(2)

trigram_frame <- generateNgramData(3)

fourgram_frame <- generateNgramData(4)

fivegram_frame <- generateNgramData(5)


# saving all the separated N-gram files to a folder 'Data'
# creating N-grams test data set for algorithm validation
saveRDS(unigram_frame, file = "Data/unigram_test.Rda")

saveRDS(bigram_frame, file = "Data/bigram_test.Rda")

saveRDS(trigram_frame, file = "Data/trigram_test.Rda")

saveRDS(fourgram_frame, file = "Data/fourgram_test.Rda")

saveRDS(fivegram_frame, file = "Data/fivegram_test.Rda")

#------------------------------------------------
# finally folding the parallel-processing cluster 
stopCluster(cluster)
# forcing 'R' to return single threading process
registerDoSEQ()