library(tm)
library(wordcloud)
library(memoise)
#library(bibler) # NOTE bibler is not available to shinyapps.io i
# as it is in non standard location (https://github.com/JohnCoene/bibler)
# The data needed for this proj (text by chapter) was serialed to kj.data (king james)
# and shipped up to shinyapps.io - problem solved.
library(dplyr)

# here is the serialized data which provides text by chapter of kj version of bible
load("kj.rdata")

chapters <- unique(king_james_df$King.James.Bible) # chapter names
chapters<-setNames(chapters,chapters) # the selector control needs named list

# Using "memoise" to automatically cache the results
getTermMatrix <- memoise(function(chapter) {
 
  text <- king_james_df %>% filter(King.James.Bible == chapter) %>% select(Text)
  myCorpus = Corpus(VectorSource(text$Text))
  myCorpus = tm_map(myCorpus, content_transformer(tolower))
  myCorpus = tm_map(myCorpus, removePunctuation)
  myCorpus = tm_map(myCorpus, removeNumbers)
  myCorpus = tm_map(myCorpus, removeWords,
                    c(stopwords("SMART"), "thy", "hath", "shalt","thou", "hast","thee", "the", "and", "but"))
  
  myDTM = TermDocumentMatrix(myCorpus,
                             control = list(minWordLength = 1))
  
  m = as.matrix(myDTM)
  
  sort(rowSums(m), decreasing = TRUE)
})

