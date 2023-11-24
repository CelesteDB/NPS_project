library(readxl)
data <- read_excel("../Dataset/Data_Satellites.xlsx", col_names = TRUE)

# Per i grafici tolgo Multinational
Id <- data$Country!='Multinational'
data <- data[Id, ]

#install.packages("png")
library(png)

# Install required package for generating plot
install.packages("ggplot2")
library(ggplot2)

##### Grafico a torta per numero di satelliti in ogni paese 

Stati <- unique(data$Country)

Occorrenze <- table(data$Country)
df <- as.data.frame(Occorrenze)

ggplot(df, aes(x = "", y = Occorrenze, fill = Var1)) +
  geom_bar(stat = "identity", width = 1, color = "white") +
  coord_polar("y") +
  theme_minimal() +
  scale_fill_viridis_d()+
  labs(title = "How many satellites for each country?", fill = "Country", x = "", y = " ")


##### Grafico a torta per users
Occorrenze <- table(data$Users)
df <- as.data.frame(Occorrenze)

ggplot(df, aes(x = "", y = Occorrenze, fill = Var1)) +
  geom_bar(stat = "identity", width = 1, color = "white") +
  coord_polar("y") +
  theme_minimal() +
  scale_fill_viridis_d()+
  labs(title = "How many satellites for each use?", fill = 'Users', x = "", y = " ")

##### Grafico a torta per Purpose

Occorrenze <- table(data$Purpose)
df <- as.data.frame(Occorrenze)

ggplot(df, aes(x = "", y = Occorrenze, fill = Var1)) +
  geom_bar(stat = "identity", width = 1, color = "white") +
  coord_polar("y") +
  theme_minimal() +
  scale_fill_viridis_d()+
  labs(title = "How many satellites for each purpose?", fill = 'Purpose', x = "", y = " ")


x1 = sample(1:60, 359, replace = T)

############ Expected Life vs Effective life for country
#x1 <- data$`Effective Lifetime`
y1 <- data$`Expected Lifetime`
Paesi <- data$Country

df <- data.frame(x1,y1,Paesi)

# Crea lo scatterplot
ggplot(df, aes(x = x1, y = y1, color = Paesi)) +
  geom_point(size = 3) +
  geom_abline(intercept = 0, slope = 1, linetype = "dashed", color = "gray") +
  scale_colour_viridis_d()+
  theme_minimal()+
  labs(title = "Effective lifetime vs Expected lifetime for country",
       x = "Effective lifetime",
       y = "Expected lifetime",
       color = "Country") 


############ Expected Life vs Effective life for Users
#x1 <- data$`Effective Lifetime`
y1 <- data$`Expected Lifetime`
Users <- data$Users

df <- data.frame(x1,y1,Purpose)


# Crea lo scatterplot
ggplot(df, aes(x = x1, y = y1, shape = Users, color = Users)) +
  geom_point(size = 3) +
  geom_abline(intercept = 0, slope = 1, linetype = "dashed", color = "gray") +
  scale_colour_viridis_d()+
  theme_minimal()+
  labs(title = "Effective lifetime vs Expected lifetime for users",
       x = "Effective lifetime",
       y = "Expected lifetime") 


############ Expected Life vs Effective life for Purpose
#x1 <- data$`Effective Lifetime`
y1 <- data$`Expected Lifetime`
Purpose <- data$Purpose

df <- data.frame(x1,y1,Purpose)


# Crea lo scatterplot
ggplot(df, aes(x = x1, y = y1, shape = Purpose, color = Purpose)) +
  geom_point(size = 3) +
  geom_abline(intercept = 0, slope = 1, linetype = "dashed", color = "gray") +
  scale_colour_viridis_d()+
  theme_minimal()+
  labs(title = "Effective lifetime vs Expected lifetime for purpose",
       x = "Effective lifetime",
       y = "Expected lifetime") 


###### per salvare immagine

# Save plot as PNG image
png(filename = "GraficoEsempio.png",
    width = 800,
    height = 600,
    units = "px",
    pointsize = 12,
    bg = "white")
print(plot)
dev.off()