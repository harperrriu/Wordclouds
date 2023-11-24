library(tm)
library(SnowballC)
library(wordcloud)
library(RColorBrewer)

setwd("/Users/jodieoh/Desktop/Saiga/FGD/5_RawData/translated")
text <- readLines("Target1-Translated.txt")

document <- Corpus(VectorSource(text))
document <- tm_map(document, content_transformer(tolower))
document <- tm_map(document, removeNumbers)
document <- tm_map(document, removeWords, stopwords("english"))
document <- tm_map(document, removeWords, c("moderator","use","take","can","also","might","sometimes","just","ones","many","something","really","much","will","one","okay"))
document <- tm_map(document, removePunctuation)

dtm <- TermDocumentMatrix(document)
m <- as.matrix(dtm)
v <- sort(rowSums(m), decreasing = T)
d <- data.frame(word=names(v), frequency=v)

d$frequency[d$word=="panadol"]

set.seed(1234)
wordcloud( words = d$word, freq = d$frequency, min.freq = 1,
            max.words=100, random.order = F, rot.per = 0.35,
           colors = brewer.pal (8, "Dark2"))
