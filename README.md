

## **Summary overview of the Capstone Project**

### Project Instructions:
The goal of this project is to display that a student have gotten used to working with the real-life data and on track to create prediction algorithm, which will provide an interface that can be accessed and used by others. The generalized course project instructions are:
  - Demonstrating that student has downloaded the data and successfully loaded in their workspace.
  - Created a basic report of summary statistics about the data sets.
  - Reported any interesting findings that students has amassed so far.
  - Provided a plan in developing a prediction algorithm with Shiny app.
  - Finally, sharing a 5-slide presentation using R-based Shiny.

### On Project Submission
Provide a user-interface and 5-slides that will display a summary overview of the project

* A Shiny app that takes as input a phrase (multiple words) in a text box input and outputs a prediction of the next word.
* A slide deck consisting of no more than 5 slides created with R Studio Presenter.

### There are four main '.R' files that contributes to the project.
* `1. ui.R` : Primary app user interface file.
* `2. Server.R` : Server file listens user input and provide feedback.
* `3. model_algotihm.R` : Next word prediction model.
* `4. RdsFileCreation.R` : A copy of the milestone file.

## Data cleaning and 'Sample Corpus' creation
One of the critical aspect of this project is data cleaning. I have used 'tm' package for this purpose. The cleaning process
does
- converting all text to lowercase from both Corpus and input text.
- removing all numbers from Corpus and input text.
- removing all punctuations.
- removing bad words from Sample Corpus.
- stripping unnecessary white spaces.

## N-Gram design
After having a clean dataset(Sample Corpus), I've gone through these steps to create N-grams
* `1. Applying TermDocumentMatrix function on Sampled clean corpus to create text-terms.`
* `2. Converting the tokens in to a matrix.`
* `3. Reordering token-terms (higher > lower) of the matrix by frequency.`
* `4. Transforming the matrix into data frame with column names as strings and frequency.`
* `5. Save them as unigram_test, bigram_test, trigram_test`
* `6. fourgram_test and fivegram_test as N-garam data frame with 'Rda' file format.`

These Rda data frames will be called by the algorithm for next word prediction.

## Building the language model
In search of finding the right next-word-prediction model, I think Markov chain model in collaboration with Markov 
random field is the perfect choice. Markov chain model property suggests that the distribution of a variable depends only on the distribution of previous state with random variables those changes through time.

`We know that Markov random field is a generalization of Markov chain in multiple dimensions. In Markov random field future state of a variable depends on its neighboring variables (existing/previous) in multiple directions with which it is connected.
In my pursuit to ascertain the connected and possible next word choice, I used N-Gram models(bigram, trigram, fourgram and fivegram).These N-grams word combinations are based on existing logical neighboring relations ,which projects Markov Chain model properties`

**Sequential steps for finding the next-right predicted words**
* Receiving input through the input text box. 
* After initial processing for basic text cleaning with model algorithms,
* We will go by sequential implementation of bigram, trigram models, 
* If no matching found, we move to fourgram or fivegram model and display probable word choices.
* Every computational process we will display five most frequently possible word choices.

### Limitation and Scope
* The total combination file size is extremely big, needs lot of computational power.
* The reduced file(10%) size may not be truly representative of the three files in combination.
* Scientific terms, unusual combination of input will not generate any prediction.
* Prediction algorithm will not generate 5 output-choices for all input-text.
* The tm-package cleaning processes avoids unusual signs or marks.

## **`Links for shiny-app and github sources`**

Shiny app for next word perdiction is running at: (shiny)

Detail alogorithm resources is available at: https://github.com/farhadkpx/Data-Science-Capstone-Project

