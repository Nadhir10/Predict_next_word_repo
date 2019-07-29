ptofanity_url<-"https://www.freewebheaders.com/wordpress/wp-content/uploads/full-list-of-bad-words-banned-by-google-txt-file.zip"
profanity<-read.table("C:/Users/ndd/Desktop/full-list-of-bad-words-banned-by-google.txt",header=F)                      


con<-file("C:/Users/ndd/Desktop/full-list-of-bad-words-banned-by-google.txt","rb")
profanity<-read_lines(con)

library(data.table)
profanity_url <- "https://raw.githubusercontent.com/shutterstock/List-of-Dirty-Naughty-Obscene-and-Otherwise-Bad-Words/master/en"
download.file(profanity_url, destfile = "profanity")
profanitywords<-read.csv("profanity", header=FALSE)
profanitywords<-data.table(profanity=(profanitywords$V1[1:(length(profanitywords$V1)-1)]))
saveRDS(profanitywords,"profanitywords")

prof_corp<-unname(unlist(read.csv("profanity", header=FALSE, stringsAsFactors=FALSE)))

length(strsplit(prof_corp[1], split=" "))

x<-readRDS("blog_bigram_table")

y<-x[profanitywords, ngram, by=.EACHI]

y<- x$ngram %in% profanitywords 

DT[X, sum(v), by=.EACHI, on="x"]      # join and eval j for each row in i



tokens <- corpus(prof_corp)   %>% 
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
y<-x[profanitywords, ngram ,by=.EACHI, on="ngram"]
x<-profanitywords[x,ngram, by=.EACHI, on=profanity]

n_gram<-tokens_ngrams(readRDS("blog"),n=3, concatenator=" ")

index<-grepl(profanitywords$profanity,pattern=" ")
useful.profanity<-profanitywords[!index]
useful.profanity
saveRDS(useful.profanity,"profanityw")
