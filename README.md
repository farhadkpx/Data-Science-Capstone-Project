
## **Summary overview of the Capstone Project:**

### Project Instructions:
The goal of this project is to display that a student have gotten used to working with the real-life data and on track to create prediction algorithm, which will provide an interface that can be accessed and used by others. The generalized course project instructions are:
  - Demonstrating that student has downloaded the data and successfully loaded in their workspace.
  - Created a basic report of summary statistics about the data sets.
  - Reported any interesting findings that students has amassed so far.
  - Provided a plan in developing a prediction algorithm with Shiny app.
  - Finally, sharing a 5-slide presentation using R-based Shiny.

### Two-link Submission:
All the project relevant data, codes, .png  files should be hosted on 'github.com'. These files has to be an open source and they should offer these following functionalities.
1. The shiny user interface takes input with one or(multiple words) in a text box and outputs a set of prediction of the next word.
2. 5-slides will display a summary overview and progression of the project.

### There are four main '.R' files that contributes to the project.
* `1. ui.R` : Primary app user interface file.
* `2. Server.R` : Server file listens user input and provides calculated feedback.
* `3. model_algotihm.R` : Next word prediction model algorithm.
* `4. RdsFileCreation.R` : A copy of the revised milestone file.

## Data cleaning and 'Sample Corpus' creation

One of the critical aspect of this project is data cleaning. I have used 'tm' R-package for this purpose. The data-cleaning processes

,requires an extensive work with these data sets. I feel due to the variety of input included in three file sets, my cleaning processes need more work to do. Here is a breif overview of my data cleaning work.
- converting all text to lowercase from both Corpus and input text.
- removing all numbers from Corpus and input text- removing all punctuations from both sets.
- removing bad words from Sample Corpus.
- stripping unnecessary white spaces.
- removing some unrelevant signs, marks from the Corpus.

## N-Gram design
Since, the whole next-word-prediction processes are based on N-gram sequential word selection, N-gram creation holds the major connection point for finding next possible word choices. After having a clean dataset with(Sample Corpus), I've gone through these steps to create 5 N-grams.

* `1. Applying TermDocumentMatrix function on Sampled clean corpus to create text-terms.`
* `2. Converting the tokens in to a matrix.`
* `3. Reordering token-terms (higher > lower) of the matrix by frequency.`
* `4. Transforming the matrix into data frame with column names as strings and frequency.`
* `5. Save them as unigram_test, bigram_test, trigram_test,`
* `6. fourgram_test and fivegram_test as N-garam data frame with 'Rda' file format.`

These '.Rda' data frames will be called in by the algorithm for next word prediction progression.

## Building the language model:
**Markov chain model**

In search of finding the right next-word-prediction model, I think Markov chain model in collaboration with Markov 
random field is the perfect choice. Markov chain model property suggests that the distribution of a variable depends only on the distribution of previous state with random variables those changes through time.

`We know that Markov random field is a generalization of Markov chain in multiple dimensions. In Markov random field future state of a variable depends on its neighboring variables (existing/previous) in multiple directions with which it is connected.
In my pursuit to ascertain the connected and possible next word choice, I used N-Gram models(bigram, trigram, fourgram and fivegram).These N-grams word combinations are based on existing logical neighboring relations ,which projects Markov Chain model properties`

**Katz's Back-off model**

Following the Markov property, I think katz's Back-Off (KBO) Model is an apt choice algorithm for 'next-word-prediction' project. 
By Wiki: Katz back-off is a generative n-gram language model that estimates the conditional probability of a word given its history in the n-gram. It accomplishes this estimation by backing-off to models with smaller histories under certain conditions. By doing so, the model with the most reliable information about a given history is used to provide the better results.

In selecting next word prediction, katz's model offers most reliable fall-back plan. For instance, if Fivegram fails to find a next-word prediction then regresses back to fourgram, threegram or bigram model.

So we can see that Markov chain model defines how the logical affinity between words should be maintained and N-gram models create those connection points available, while katz's model falls back on Markov chain model as needed. I used both model as interdependent models in finding my natural language processing(NLP) prediction.
                                  
### Limitation and Scope
* The total combination file size is extremely big, needs lot of computational power.
* The reduced file(10%) size may not be truly representative of the three files in combination.
* Scientific terms, unusual combination of input will not generate any prediction.
* Prediction algorithm will not generate 5 output-choices for all input-text.
* The tm-package cleaning processes avoids unusual signs or marks.

## **`Shiny-app, Presentation and github code sources links`**

Shiny app for next word perdiction is running at: https://farhad31.shinyapps.io/next_word_prediction_model/

Shiny presentation slides: http://rpubs.com/Redeemk17/359445

Detail alogorithm resources is available at: https://github.com/farhadkpx/Data-Science-Capstone-Project

