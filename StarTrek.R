library(wordcloud2)
library(tm)

setwd("~/RPlayground")
MyData <- read.csv(file="most_startrek_script_lines.csv", header=TRUE, sep=",")

max_words <- 50
groups <- floor(max_words/6)
star_colors <- c(rep("#df0000", 3), rep("#000000", groups+(groups-5)), rep("#f2c300", groups), rep("#0099f6", groups), rep("#00b844", groups+50))



# docs <- VCorpus(VectorSource(c(MyData['line'])))
docs <- VCorpus(VectorSource(c(MyData['char'])))

# cleanse text
words <- tm_map(docs, removeWords, stopwords("english"))
words <- tm_map(words, content_transformer(tolower))
words = tm_map(words,stripWhitespace)
words = tm_map(words,removeWords,stopwords("en"))
words = tm_map(words,removePunctuation)
words = tm_map(words,removeNumbers)


myTdm <- as.matrix(TermDocumentMatrix(words))
FreqMat <- data.frame(ST = rownames(myTdm), Freq = rowSums(myTdm), row.names = NULL)

sorted <- FreqMat[order(-FreqMat$Freq), ]
trimmed <- sorted[1:max_words ,]
wordcloud2(data = trimmed, color = star_colors, backgroundColor = "white")

# wordcloud2(trimmed,size=1, color=star_colors, backgroundColor ='white', figPath = "star2.jpg" )
           