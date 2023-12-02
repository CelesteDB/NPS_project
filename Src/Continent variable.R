################### aggiungo colonna continente #############
library(readxl)
data <- read_excel("../Dataset/JoinDatasets.xlsx", col_names = TRUE)

paesi <- data$Country

# Carica il pacchetto
#install.packages("countrycode")

library(countrycode)
# Crea un dataframe di esempio con i paesi
dataframe_paesi <- data.frame(paese = paesi)
esa <- which(paesi == 'ESA')
multinat <- which(paesi == 'Multinational')

# Usa la funzione countrycode per ottenere il continente
continente <- countrycode(sourcevar = dataframe_paesi$paese, origin = "country.name", destination = "continent")
continente[esa] = 'Europe'
continente[multinat] = 'Multinational'

data <- cbind(data,Continent = continente)
save(data, file ="Data_new.Rdata")

install.packages("openxlsx")
library(openxlsx)


# Specifica il percorso del file Excel in cui desideri salvare il dataset
percorso_file <- "percorso/del/tuo/file/nomefile.xlsx"

# Salva il dataset in Excel
write.xlsx(data, file = 'JoinDatasets.xlsx', rowNames = FALSE)
