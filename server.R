
library(shiny)
library(shinythemes)
library(wordcloud)
setwd("C:/Users/paralax11/Desktop/Data_Science_Capstone_Project/Project_Capstone/Word_Prediction_Project")

source("model_algorithms.R", local = TRUE)

# Designing shiny-server functions
shinyServer(
  function(input, output, session){
    
    
    prediction <- reactive({
      PredictNextWord(input$inputTxt)
    })
    
    output$words <- renderUI({
      predictWords <- prediction()
      assign('WordsAssigned', predictWords, envir=.GlobalEnv)
      k <- length(predictWords)       #-------
      if( k > 0 && nchar(predictWords) > 0 && k !=0) {
        buttons <- list()
        for(i in 1:k) {
          buttons <- list(buttons, list(
            actionButton(inputId = paste("word",i, sep = ""), label =predictWords[i])))
            #--------------------------------------------------
            # possible word cloud presentation
             # wordcloud_rep = repeatable(wordcloud)
             #  output$wordcloud = renderPlot(
             #    wordcloud_rep(
             #    predictWords[i]$string,
             #    colors = brewer.pal(8, 'Dark2'),
             #    scale=c(3, 0.5),
             #     max.words = 5
             #  ) ) 
           }
        
        tagList( buttons )
      } else {
        tagList("") 
      }
    })
    
    observeEvent(input$word1, {
      updateTextInput(session, "inputTxt", value = paste(input$inputTxt, get('WordsAssigned', envir=.GlobalEnv)[1]))
    })
    
    observeEvent(input$word2, {
      updateTextInput(session, "inputTxt", value = paste(input$inputTxt, get('WordsAssigned', envir=.GlobalEnv)[2]))
    })
    
    observeEvent(input$word3, {
      updateTextInput(session, "inputTxt", value = paste(input$inputTxt, get('WordsAssigned', envir=.GlobalEnv)[3]))
    })
    
    observeEvent(input$word4, {
      updateTextInput(session, "inputTxt", value = paste(input$inputTxt, get('WordsAssigned', envir=.GlobalEnv)[4]))
    })
    
    observeEvent(input$word5, {
      updateTextInput(session, "inputTxt", value = paste(input$inputTxt, get('WordsAssigned', envir=.GlobalEnv)[5]))
    })
    
    
  })