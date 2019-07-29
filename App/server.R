library(stringr)
library(qdap)
library(quanteda)
library(data.table)
library(shiny)

dt4<-readRDS("dt4_ranked")
dt3<-readRDS("dt3_ranked")
dt2<-readRDS("dt2_ranked")
profw<-readRDS("profanityw")


# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  pred <- eventReactive(input$go, {
    x<-input$txt
    x_tokens <- corpus(x)   %>% 
      str_replace_all(pattern="’", replacement="'") %>% 
      str_replace_all(pattern="â€™", replacement="'") %>%
      str_replace_all(pattern="\u2019", replacement="'") %>%
      replace_contraction() %>%
      str_replace_all("[^a-zA-Z'\\. ]", "") %>%
      tokens(what = "word", remove_numbers = TRUE, remove_punct = TRUE,
             remove_hyphens = TRUE, remove_url = TRUE)%>%
      tokens_tolower() %>% 
      #tokens_select(stopwords(), selection = "remove") %>%
      tokens_wordstem(language = "english")
    
    x_unig<-tail(unname(unlist(tokens_ngrams(x_tokens,n=1, concatenator=" "))),1)
    x_big<-tail(unname(unlist(tokens_ngrams(x_tokens,n=2, concatenator=" "))),1)
    x_trig<-tail(unname(unlist(tokens_ngrams(x_tokens,n=3, concatenator=" "))),1)
   
     if (nrow(dt4[base == x_trig])) {
      head(dt4[base==x_trig]$word,5)
    } else if (nrow(dt3[base==x_big])) {
      head(dt3[base==x_big]$word,5)
    } else {
      head(dt2[base == x_unig]$word,5)
    }
  })
   
  output$txt1 <- renderText({
    if (length(pred())) {
      setdiff(pred(),profw$profanity)
      }
    else {
      c("is", "are", "the", "a", "of")
      }
    
    })
  
})
