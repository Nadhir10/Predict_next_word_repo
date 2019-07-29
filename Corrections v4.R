

library(stringr)
library(qdap)
library(quanteda)
library(data.table)


########################################################
##############          BLOG                       #####
########################################################

con1 <- file("C:/Users/ndd/Desktop/10-capstone/W1/final/en_US/en_US.blogs.txt", "r")
blogsamp<-readLines(con1) #899288 - 208361438
close(con1)

start.time<-Sys.time()
tokens <- corpus(blogsamp)   %>% 
  str_replace_all(pattern="???", replacement="'") %>%
  str_replace_all(pattern="????????", replacement="'") %>% 
  str_replace_all(pattern="???????", replacement="'") %>%
  str_replace_all(pattern="\u2019", replacement="'") %>%
  replace_contraction() %>%
  str_replace_all("[^a-zA-Z'\\. ]", "") %>%
  tokens(what = "word", remove_numbers = TRUE, remove_punct = TRUE,
         remove_hyphens = TRUE, remove_url = TRUE)%>%
  tokens_tolower() 
  
saveRDS(tokens,"blog")
Sys.time()-start.time # (14 min)


rm(list = ls(all.names = TRUE)) # remove all objects icluding hidden
gc() # garbage collector
.rs.restartR() ## restart session

#======================================BIGRAMS
start.time<-Sys.time()
bigrams<-tokens_ngrams(readRDS("blog"),n=2, concatenator=" ")
saveRDS(bigrams, file ="blog_raw_bigrams")
Sys.time()-start.time # 1 min

rm(list = ls(all.names = TRUE)) # remove all objects icluding hidden
gc() # garbage collector
.rs.restartR() ## restart session

start.time<-Sys.time()
tmpDT <- data.table(ngram=(unname(unlist(readRDS("blog_raw_bigrams")))),count=1)
blog_bigram_table <- tmpDT[,.(count = sum(count)),keyby=ngram]
saveRDS(blog_bigram_table, "blog_bigram_table")
Sys.time()-start.time # 2 min

# profanity words


#======================================TRIGRAMS
start.time<-Sys.time()
n_gram<-tokens_ngrams(readRDS("blog"),n=3, concatenator=" ")
saveRDS(n_gram, file ="blog_raw_trigrams")
Sys.time()-start.time # 18 min

rm(list = ls(all.names = TRUE)) # remove all objects icluding hidden
gc() # garbage collector
.rs.restartR() ## restart session

# Count Trigrams
start.time<-Sys.time()
tmpDT <- data.table(ngram=(unname(unlist(readRDS("blog_raw_trigrams")))),count=1)
ngram_table <- tmpDT[,.(count = sum(count)),keyby=ngram]
saveRDS(ngram_table, "blog_trigram_table")
Sys.time()-start.time # 4 min

rm(list = ls(all.names = TRUE)) # remove all objects icluding hidden
gc() # garbage collector
.rs.restartR() ## restart session

#======================================FOURGRAMS
start.time<-Sys.time()
start.time
n_gram<-tokens_ngrams(readRDS("blog"),n=4, concatenator=" ")
saveRDS(n_gram, file ="blog_raw_fourgrams")
Sys.time()-start.time # 33 min

rm(list = ls(all.names = TRUE)) # remove all objects icluding hidden
gc() # garbage collector
.rs.restartR() ## restart session

# Count Trigrams
start.time<-Sys.time()
start.time
tmpDT <- data.table(ngram=(unname(unlist(readRDS("blog_raw_fourgrams")))),count=1)
ngram_table <- tmpDT[,.(count = sum(count)),keyby=ngram]
saveRDS(ngram_table, "blog_fourgrams_table")
Sys.time()-start.time # 7 min

rm(list = ls(all.names = TRUE)) # remove all objects icluding hidden
gc() # garbage collector
.rs.restartR() ## restart session

########################################################
##############          TWITTER                    #####
########################################################


con2 <- file("C:/Users/ndd/Desktop/10-capstone/W1/final/en_US/en_US.twitter.txt", "r") 
twittsamp<-readLines(con2, skipNul = TRUE) # 2360148  162385035
close(con2)

start.time<-Sys.time()
tokens <- corpus(twittsamp)   %>% 
  str_replace_all(pattern="???", replacement="'") %>%
  str_replace_all(pattern="????????", replacement="'") %>% 
  str_replace_all(pattern="???????", replacement="'") %>%
  str_replace_all(pattern="\u2019", replacement="'") %>%
  replace_contraction() %>%
  str_replace_all("[^a-zA-Z'\\. ]", "") %>%
  tokens(what = "word", remove_numbers = TRUE, remove_punct = TRUE,
         remove_hyphens = TRUE, remove_url = TRUE)%>%
  tokens_tolower()
  
  saveRDS(tokens,"twitter")
Sys.time()-start.time # (14 min)


rm(list = ls(all.names = TRUE)) # remove all objects icluding hidden
gc() # garbage collector
.rs.restartR() ## restart session

#======================================BIGRAMS
start.time<-Sys.time()
bigrams<-tokens_ngrams(readRDS("twitter"),n=2, concatenator=" ")
saveRDS(bigrams, file ="twitter_raw_bigrams")
Sys.time()-start.time # 1 min

rm(list = ls(all.names = TRUE)) # remove all objects icluding hidden
gc() # garbage collector
.rs.restartR() ## restart session

start.time<-Sys.time()
tmpDT <- data.table(ngram=(unname(unlist(readRDS("twitter_raw_bigrams")))),count=1)
twitter_bigram_table <- tmpDT[,.(count = sum(count)),keyby=ngram]
saveRDS(twitter_bigram_table, "twitter_bigram_table")
Sys.time()-start.time # 2 min

# profanity words


#======================================TRIGRAMS
start.time<-Sys.time()
n_gram<-tokens_ngrams(readRDS("twitter"),n=3, concatenator=" ")
saveRDS(n_gram, file ="twitter_raw_trigrams")
Sys.time()-start.time # 5 min

rm(list = ls(all.names = TRUE)) # remove all objects icluding hidden
gc() # garbage collector
.rs.restartR() ## restart session

start.time<-Sys.time()
tmpDT <- data.table(ngram=(unname(unlist(readRDS("twitter_raw_trigrams")))),count=1)
ngram_table <- tmpDT[,.(count = sum(count)),keyby=ngram]
saveRDS(ngram_table, "twitter_trigram_table")
Sys.time()-start.time # 3 min


#======================================FOURGRAMS
start.time<-Sys.time()
start.time
n_gram<-tokens_ngrams(readRDS("twitter"),n=4, concatenator=" ")
saveRDS(n_gram, file ="twitter_raw_fourgrams")
Sys.time()-start.time # 14 min

rm(list = ls(all.names = TRUE)) # remove all objects icluding hidden
gc() # garbage collector
.rs.restartR() ## restart session

# Count Trigrams
start.time<-Sys.time()
start.time
tmpDT <- data.table(ngram=(unname(unlist(readRDS("twitter_raw_fourgrams")))),count=1)
ngram_table <- tmpDT[,.(count = sum(count)),keyby=ngram]
saveRDS(ngram_table, "twitter_fourgrams_table")
Sys.time()-start.time # 4 min

rm(list = ls(all.names = TRUE)) # remove all objects icluding hidden
gc() # garbage collector
.rs.restartR() ## restart session

########################################################
##############          NEWS                       #####
########################################################
library(readr)

con3<- file("C:/Users/ndd/Desktop/10-capstone/W1/final/en_US/en_US.news.txt", "rb")
newssamp<-read_lines(con3) # 1010242  203223153
close(con3)

start.time<-Sys.time()
tokens <- corpus(newssamp)   %>% 
  str_replace_all(pattern="???", replacement="'") %>%
  str_replace_all(pattern="????????", replacement="'") %>% 
  str_replace_all(pattern="???????", replacement="'") %>%
  str_replace_all(pattern="\u2019", replacement="'") %>%
  replace_contraction() %>%
  str_replace_all("[^a-zA-Z'\\. ]", "") %>%
  tokens(what = "word", remove_numbers = TRUE, remove_punct = TRUE,
         remove_hyphens = TRUE, remove_url = TRUE)%>%
  tokens_tolower() 
 
saveRDS(tokens,"news")
Sys.time()-start.time # (11 min)


rm(list = ls(all.names = TRUE)) # remove all objects icluding hidden
gc() # garbage collector
.rs.restartR() ## restart session

#======================================BIGRAMS
start.time<-Sys.time()
bigrams<-tokens_ngrams(readRDS("news"),n=2, concatenator=" ")
saveRDS(bigrams, file ="news_raw_bigrams")
Sys.time()-start.time # 1 min

rm(list = ls(all.names = TRUE)) # remove all objects icluding hidden
gc() # garbage collector
.rs.restartR() ## restart session

start.time<-Sys.time()
tmpDT <- data.table(ngram=(unname(unlist(readRDS("news_raw_bigrams")))),count=1)
news_bigram_table <- tmpDT[,.(count = sum(count)),keyby=ngram]
saveRDS(news_bigram_table, "news_bigram_table")
Sys.time()-start.time # 2 min

# profanity words


#======================================TRIGRAMS
start.time<-Sys.time()
n_gram<-tokens_ngrams(readRDS("news"),n=3, concatenator=" ")
saveRDS(n_gram, file ="news_raw_trigrams")
Sys.time()-start.time # 14 min

rm(list = ls(all.names = TRUE)) # remove all objects icluding hidden
gc() # garbage collector
.rs.restartR() ## restart session

start.time<-Sys.time()
tmpDT <- data.table(ngram=(unname(unlist(readRDS("news_raw_trigrams")))),count=1)
news_bigram_table <- tmpDT[,.(count = sum(count)),keyby=ngram]
saveRDS(news_bigram_table, "news_trigram_table")
Sys.time()-start.time # 4 min

#======================================FOURGRAMS
start.time<-Sys.time()
start.time
n_gram<-tokens_ngrams(readRDS("news"),n=4, concatenator=" ")
saveRDS(n_gram, file ="news_raw_fourgrams")
Sys.time()-start.time # 39 min

rm(list = ls(all.names = TRUE)) # remove all objects icluding hidden
gc() # garbage collector 
.rs.restartR() ## restart session

# Count Trigrams
start.time<-Sys.time()
start.time
tmpDT <- data.table(ngram=(unname(unlist(readRDS("news_raw_fourgrams")))),count=1)
ngram_table <- tmpDT[,.(count = sum(count)),keyby=ngram]
saveRDS(ngram_table, "news_fourgrams_table")
Sys.time()-start.time # 5 min

rm(list = ls(all.names = TRUE)) # remove all objects icluding hidden
gc() # garbage collector
.rs.restartR() ## restart session

###############################################################################
###################  AGGREGATION
############################################################################""

#=====================================FULL BIGRAMS
start.time<-Sys.time()
start.time
temp<-rbind(readRDS("blog_bigram_table"), 
            readRDS("twitter_bigram_table"), 
            readRDS("news_bigram_table"))

temp2<-temp[,.(count = sum(count)),keyby=ngram][order(-count)]
saveRDS(temp2,"aggregated_bigrams")
Sys.time()-start.time # 1 min

rm(list = ls(all.names = TRUE)) # remove all objects icluding hidden
gc() # garbage collector
.rs.restartR() ## restart session

#===================================== FULL TRIGRAMS

start.time<-Sys.time()
start.time
temp<-rbind(readRDS("blog_trigram_table"), 
            readRDS("twitter_trigram_table"), 
            readRDS("news_trigram_table"))

temp2<-temp[,.(count = sum(count)),keyby=ngram][order(-count)]
saveRDS(temp2,"aggregated_trigrams")
Sys.time()-start.time  # 4min

rm(list = ls(all.names = TRUE)) # remove all objects icluding hidden
gc() # garbage collector
.rs.restartR() ## restart session

#===================================== FULL FOURGRAMS

start.time<-Sys.time()
start.time
temp<-readRDS("blog_fourgrams_table") #27542639

temp2<-temp[count<2]
saveRDS(temp2,"aggregated_fourgrams_low1")
temp2<-temp[count>1]
saveRDS(temp2,"aggregated_fourgrams_high1")


temp<-readRDS("twitter_fourgrams_table") #17702718 ##45245357
temp2<-temp[count<2]
saveRDS(temp2,"aggregated_fourgrams_low2")
temp2<-temp[count>1]
saveRDS(temp2,"aggregated_fourgrams_high2")


temp<-readRDS("news_fourgrams_table") # 24853125 ##70098482

temp2<-temp[count<2]
saveRDS(temp2,"aggregated_fourgrams_low3")
temp2<-temp[count>1]
saveRDS(temp2,"aggregated_fourgrams_high3")


start.time<-Sys.time()
start.time

rm(list = ls(all.names = TRUE)) # remove all objects icluding hidden
gc() # garbage collector
.rs.restartR() ## restart session

start.time<-Sys.time()
start.time
temp<-rbind(readRDS("aggregated_fourgrams_low1"), 
            readRDS("aggregated_fourgrams_low2"), 
            readRDS("aggregated_fourgrams_low3"))
Sys.time()
temp2<-temp[,.(count = sum(count)),keyby=ngram]#[order(-count)]
saveRDS(temp2,"aggregated_fourgrams_lower")
Sys.time()-start.time  # 11 min

start.time<-Sys.time()
start.time
temp<-rbind(readRDS("aggregated_fourgrams_high1"), 
            readRDS("aggregated_fourgrams_high2"), 
            readRDS("aggregated_fourgrams_high3"))
Sys.time()
temp2<-temp[,.(count = sum(count)),keyby=ngram]#[order(-count)]
saveRDS(temp2,"aggregated_fourgrams_higher")
Sys.time()-start.time  # 27 s


rm(list = ls(all.names = TRUE)) # remove all objects icluding hidden
gc() # garbage collector
.rs.restartR() ## restart session

######################################### DATABASE FOR Predicion

# final fourgrams
# split into base
start.time<-Sys.time()
start.time
x<-readRDS("aggregated_fourgrams_higher")
y<-x[count>4]
rm(list = ls()[ls()!="y"])
gc()
dt<-y[,.(base=word(ngram,1,3),word=word(ngram,-1),count=count)][order(base,-count)]
saveRDS(dt,"dt4")
Sys.time()-start.time  # 27 s

rm(list = ls(all.names = TRUE)) # remove all objects icluding hidden
gc() # garbage collector
.rs.restartR() ## restart session

## add ranking
dt<-readRDS("dt4")
dt<-dt[,rank:=frank(-count,ties.method ="first" ),by=base]
saveRDS(dt,"dt4_ranked")


# final trigrams
# split into base
x<-readRDS("aggregated_trigrams")
dt<-x[count>4]
saveRDS(dt,"aggregated_trigrams_light")

rm(list = ls(all.names = TRUE)) # remove all objects icluding hidden
gc() # garbage collector
.rs.restartR() ## restart session


dt<-readRDS("aggregated_trigrams_light")
dt<-dt[,.(base=word(ngram,1,2),word=word(ngram,-1),count=count)][order(base,-count)]
saveRDS(dt,"dt3")

rm(list = ls(all.names = TRUE)) # remove all objects icluding hidden
gc() # garbage collector
.rs.restartR() ## restart session

## add ranking
dt<-readRDS("dt3")
dt<-dt[,rank:=frank(-count,ties.method ="first" ),by=base]
saveRDS(dt,"dt3_ranked")


# final bigrams
# split into base
x<-readRDS("aggregated_bigrams")
dt<-x[count>4]
saveRDS(dt, "aggregated_bigrams_light")

rm(list = ls(all.names = TRUE)) # remove all objects icluding hidden
gc() # garbage collector
.rs.restartR() ## restart session

dt<-readRDS("aggregated_bigrams_light")
dt<-dt[,.(base=word(ngram,1),word=word(ngram,-1),count=count)][order(base,-count)]
saveRDS(dt,"dt2")

rm(list = ls(all.names = TRUE)) # remove all objects icluding hidden
gc() # garbage collector
.rs.restartR() ## restart session

## add ranking
dt<-readRDS("dt2")
dt<-dt[,rank:=frank(-count,ties.method ="first" ),by=base]
saveRDS(dt,"dt2_ranked")

########################################
#Predicting
dt4<-readRDS("dt4_ranked")
dt3<-readRDS("dt3_ranked")
dt2<-readRDS("dt2_ranked")

x<-"I like how the same people are in almost all of Adam Sandler's"

x_tokens <- corpus(x)   %>% 
  str_replace_all(pattern="???", replacement="'") %>%
  str_replace_all(pattern="????????", replacement="'") %>% 
  str_replace_all(pattern="???????", replacement="'") %>%
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
  pred<-dt4[base==x_trig]
  print("fourgram")
} else if (nrow(dt3[base==x_big])) {
  pred<-dt3[base==x_big]
  print("trigram")
} else {
  pred<-dt2[base == x_unig]
  print("bigram")}
pred
