## **Summary overview of the Coursera 'Data science Capstone Project'**

### Instructions

The goal of this project is to display that a student have gotten used to working with the real-life data and on track to create prediction algorithm, which will provide an interface that can be accessed and used by others. Basic course instructions are:
  - Demonstrate that you(student) have downloaded the data and have successfully loaded it in.
  - Created a basic report of summary statistics about the data sets.
  - Report any interesting findings that you amassed so far.
  - Get feedback on your plans for creating a prediction algorithm and Shiny app.

### On Project Submission
Provide a user-interface and 5-slides that will display a summary overview of the project

* A Shiny app that takes as input a phrase (multiple words) in a text box input and outputs a prediction of the next word.
* A slide deck consisting of no more than 5 slides created with R Studio Presenter.

### There are four main '.R' files that contributes to the project.

* `1. ui.R` : Primary app user interface file.
* `2. Server.R` : Server file listens user input and provide feedback.
* `3. model_algotihm.R` : Next word prediction model.
* `4. RdsFileCreation.R` : A copy of the milestone file.

## N-Gram design
Tokenizing the 'Sample Corpus' with TermDocumentMatrix function. <
* Convert the tokens in to a matrix.
* Reordering token-terms (higher > lower) of the matrix by frequency.
* Transforming the matrix into data frame with column names as strings and frequency.
* Save them as final_Unigram, final_bigram, final_trigram,
* final_fourgram and final_fivegram as N-garam data frame with 'Rda' file format.
* These Rda data frames will be called by the algorithm for next word prediction.

## Building the language model
In search of finding the right next-word-prediction model, I think Markov chain model in collaboration with Markov 
random field is the perfect choice. Markov chain model property suggests that the distribution of a variable depends only on the distribution of previous state with random variables those changes through time.

We know that Markov random field is a generalization of Markov chain in multiple dimensions. In Markov random field future state of a variable depends on its neighboring variables (existing/previous) in multiple directions with which it is connected.
In my pursuit to ascertain the connected and possible next word choice, I used N-Gram models(bigram, trigram, fourgram and fivegram).These N-grams word combinations are based on existing logical neighboring relations ,which projects Markov Chain model properties

Receiving input through the input text box. 
* After initial processing for basic text cleaning with model algorithms,
* We will go by sequential implementation of bigram, trigram models, 
* If no matching found, we move to fourgram or fivegram model and display probable word choices.
* Every computational process we will display five most frequently possible word choices.

### Limitation and Scope
* The total combination file size is extremely big
* The reduced file size may not be truly representative of the three files
* The tm-package cleaning processes avoids unusual signs or marks



## **`Links for shiny-app and github sources`**

Shiny app for next word perdiction is running at: (shiny)
Detail alogorithm resources is available at: (github)

