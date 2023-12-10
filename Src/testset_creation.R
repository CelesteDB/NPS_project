
library(readxl)
data <- read_excel("../Dataset/JoinDatasets.xlsx", col_names = TRUE)

set.seed(123)
library(caret)
#USING training_set IN THE COX MODEL !!

# Crea un indice di divisione tra training set e test set
index <- createDataPartition(data$`Effective Lifetime`, p = 0.8, list = FALSE)

# Crea il training set utilizzando l'indice
training_set <- data[index, ]

# Crea il test set utilizzando l'indice
test_set <- data[-index, ]
head(test_set)





# OR TAKING NEW OBSERVATIONS FROM THE OLD DATASET AS TEST SET: 

dataUCS <- read_excel("../Dataset/UCS-Satellite-Database-1-1-2023.xlsx", col_names = TRUE)
names(dataUCS)

#PULIZIA
columns_to_remove <- c("Name of Satellite, Alternate Names", "Country/Org of UN Registry", "Operator/Owner", "Detailed Purpose", "Type of Orbit", "Contractor", "Launch Site", "Launch Vehicle", "COSPAR Number", "NORAD Number", "Comments", "...32", "Source Used for Orbital Data", "Source...34", "Source...35", "Source...36", "Source...37", "Source...38", "Source...39", "Source...40", "Country of Contractor", "Power (watts)", "Launch Mass (kg.)")
dataUCS <- dataUCS[, -c(which(names(dataUCS) %in% columns_to_remove), 38:68)]
dataUCS$`Dry Mass (kg.)` <- as.numeric(dataUCS$`Dry Mass (kg.)`)
dataUCS$`Longitude of GEO (degrees)` <- as.numeric(dataUCS$`Longitude of GEO (degrees)`)
dataUCS <- dataUCS[, -c( 15:18)]
names(dataUCS)
dim(dataUCS)

dataUCS$'Country of Operator/Owner'[which(data$'Country of Operator/Owner' == "ESA/Russia")] <- "ESA"
dataUCS$'Country of Operator/Owner'[which(data$'Country of Operator/Owner' == "Turkmenistan/Monaco")] <- "Turkmenistan"
dataUCS$'Country of Operator/Owner'[which(data$'Country of Operator/Owner' == "United Kingdom/ESA")] <- "United Kingdom"
dataUCS$'Country of Operator/Owner'[which(data$'Country of Operator/Owner' == "USA/Canada")] <- "USA"
dataUCS$'Country of Operator/Owner'[which(data$'Country of Operator/Owner' == "USA/France")] <- "USA"
dataUCS$'Country of Operator/Owner'[which(data$'Country of Operator/Owner' == "USA/Japan")] <- "USA"
dataUCS$'Country of Operator/Owner'[which(data$'Country of Operator/Owner' == "USA/Japan/Brazil")] <- "USA"

dataUCS$Users[which(data$Users == "Government/Civil")] <- "Government"
dataUCS$Users[which(data$Users == "Government/Commercial")] <- "Government"
dataUCS$Users[which(data$Users == "Government/Commercial/Military")] <- "Government"
dataUCS$Users[which(data$Users == "Military/Commercial")] <- "Military"
dataUCS$Users[which(data$Users == "Military/Government")] <- "Military"

dataUCS$Purpose[which(data$Purpose == "Communications/Navigation")] <- "Communications"
dataUCS$Purpose[which(data$Purpose == "Communications/Technology Development")] <- "Communications"
dataUCS$Purpose[which(data$Purpose == "Earth Observation/Technology Development")] <- "Earth Observation"
dataUCS$Purpose[which(data$Purpose == "Navigation/Global Positioning")] <- "Navigation"
dataUCS$Purpose[which(data$Purpose == "Navigation/Regional Positioning")] <- "Navigation"

names(dataUCS) <- c("Satellite Name", "Country", "Users", "Purpose", "Orbit", "Longitude of GEO", "Perigee", "Apogee", "Eccentricity", "Inclination", "Period", "Mass", "Launch Date", "Expected Lifetime")
names(dataUCS)

#togliamo obs senza expected lifetime
id <- which(is.na(dataUCS$`Expected Lifetime`))
dataUCS<-dataUCS[-id,]
dim(dataUCS)

#togliamo obs senza massa 
id <- which(is.na(dataUCS$Mass))
dataUCS<-dataUCS[-id,]
dim(dataUCS)

#togliamo obs che abbiamo usato per costruire il modello
id <- which(data$`Current Official Name of Satellite` %in% dataUCS$`Satellite Name`)
length(id) #386
dim(dataUCS)[1] #386 !!
