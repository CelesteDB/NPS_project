library(readxl)
types = rep('guess',68)
types[20] = 'date'
datainiz <- read_excel("../Dataset/UCS-Satellite-Database-1-1-2023.xlsx", col_names = TRUE, col_types = types )
data1 <- read_excel("../Dataset/UCS-Satellite-Database-1-1-2023.xlsx", col_names = TRUE, col_types = types)
data2 <- read.csv("../Dataset/satcat.csv", header = TRUE)

# Trova gli indici in cui gli elementi nei due vettori sono uguali
id1 <- which(datainiz$`COSPAR Number` %in% data2$OBJECT_ID)
id2 <- which(data2$OBJECT_ID %in% data1$`COSPAR Number`)

data2 <- data2[id2,c(2,9)]

id <- which(data2$DECAY_DATE == "")

data2 <- data2[-id,]
id1 <- which(data1$`COSPAR Number` %in% data2$OBJECT_ID)


columns_to_remove <- c("Name of Satellite, Alternate Names", "Country/Org of UN Registry", "Operator/Owner", "Detailed Purpose", "Type of Orbit", "Contractor", "Launch Site", "Launch Vehicle", "COSPAR Number", "NORAD Number", "Comments", "...32", "Source Used for Orbital Data", "Source...34", "Source...35", "Source...36", "Source...37", "Source...38", "Source...39", "Source...40")

data1 <- data1[, -c(which(names(data1) %in% columns_to_remove), 41:68)]
data1 <- data1[, -c(17:24)]

data1$`Disposal Date` <- vector("character", length = nrow(data1))


data1$`Disposal Date`[id1] <- data2$DECAY_DATE

id <- which(data1$`Disposal Date` == "")

# dataset con disposal date 
data1 <- data1[-id,]

datanostro <- read_excel("../Dataset/Data_Satellites.xlsx", col_names = TRUE)

id <- which(data1$`Current Official Name of Satellite` %in% datanostro$`Satellite Name`)

data1$`Dry Mass (kg.)` <- as.numeric(data1$`Dry Mass (kg.)`)
data1$`Longitude of GEO (degrees)` <- as.numeric(data1$`Longitude of GEO (degrees)`)

columns_to_remove <- c("Power (watts)", "Dry Mass (kg.)")  # TOGLIAMO DRY MASS

data1 <- data1[, -which(names(data1) %in% columns_to_remove)]
data1$Status <- 'retired'
data1$`Effective Lifetime` <- vector("character", length = nrow(data1))

sat.da.agg.a.data1 <- datanostro[-id,] 
id1 <- which(sat.da.agg.a.data1$`Satellite Name` %in% datainiz$`Current Official Name of Satellite`)
sat.da.agg.a.data1$'Lunch Mass kg(.)' <- vector("character", length = nrow(sat.da.agg.a.data1))
sat.da.agg.a.data1$`Lunch Mass kg(.)` <- datainiz$`Launch Mass (kg.)`[id1]


names(data1) <- c("Satellite Name", "Country", "Users", "Purpose", "Orbit", "Longitude of GEO","Perigee", "Apogee", "Eccentricity", "Inclination", "Period", "Mass", "Launch Date","Expected Lifetime",  "Final Date", "Status", "Effective Lifetime")
names(sat.da.agg.a.data1) <- c("Satellite Name" ,    "Country"  ,          "Users"   ,           "Purpose"   ,         "Orbit"     ,        
 "Longitude of GEO"  , "Perigee"  ,          "Apogee"    ,         "Eccentricity"  ,     "Inclination"  ,     
"Period"      ,       "Mass"        ,       "Launch Date"   ,     "Status"        ,     "Final Date"      ,  
"Effective Lifetime" ,"Expected Lifetime" , "Continent"     ,     "Mass" ) 

sat.da.agg.a.data1<-sat.da.agg.a.data1[,-18]
sat.da.agg.a.data1<-sat.da.agg.a.data1[,-12]

data1<- data1[, names(sat.da.agg.a.data1)]
data1$Apogee <- as.numeric(data1$Apogee)
#data1$`Launch Date`<-as.Date(data1$`Launch Date`)
sat.da.agg.a.data1$`Final Date`<-as.character(sat.da.agg.a.data1$`Final Date`)
data1$`Effective Lifetime`<-as.numeric(data1$`Effective Lifetime`)
library(dplyr)

joinData <- bind_rows(sat.da.agg.a.data1,data1)
table(joinData$Status)

# Caricare la libreria
library(openxlsx)
path = "C:/Users/alessandro/Documents/GitHub/NPS_project/Src"

# Scrivere il dataframe nel file Excel
write.xlsx(joinData,path, rowNames = FALSE)



