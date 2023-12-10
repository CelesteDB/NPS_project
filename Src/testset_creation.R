
library(readxl)
data <- read_excel("../Dataset/JoinDatasets.xlsx", col_names = TRUE)

set.seed(123)
library(caret)

#prendo come training test le osservazioni senza expected life time
idna <- which(is.na(data$`Expected Lifetime`))
training_set0 <- data[idna,]
dim(training_set0) #217 obs

#ci aggiungo altre osservazioni per arrivare all'80% del dataset (ne mancano altre 357)
sub <- data[-idna,] # dataset con expected lifetime con 497 obs
index <- createDataPartition(sub$`Effective Lifetime`, p = 0.715, list = FALSE)

# Crea il training set utilizzando l'indice
training_set1 <- sub[index,]
#concateno 
training_set <- bind_rows(training_set0, training_set1)
dim(training_set)


test_set <- sub[-index, ]
dim(test_set)

