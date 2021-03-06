
function(input, output, session) {
  # Define a reactive expression for the document term matrix
  terms <- reactive({
    # Change when the "chapter" changes
    #input$update
    input$selection
    # ...but not for anything else
    isolate({
      withProgress({
        setProgress(message = "Chunking data ....")
        getTermMatrix(input$selection)
      })
    })
  })
  
  # Make the wordcloud drawing predictable during a session
  wordcloud_rep <- repeatable(wordcloud)
  output$plot <- renderPlot({
    v <- terms()
    wordcloud_rep(names(v),v , scale=c(4,0.5),
                  min.freq = input$freq, max.words=input$max,
                  colors=brewer.pal(8, "Paired"))
  })
  output$chapter <- renderText({
    paste("Calculation:  getTermMatrix('" , input$selection,"'), frequency=",input$freq,", max words=",input$max)
  })
}
