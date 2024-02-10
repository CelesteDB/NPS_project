# Carica il pacchetto ggplot2
library(ggplot2)
colore <- rgb(0, 83, 125, maxColorValue = 255)

# Istogramma per la colonna Eccentricity
ggplot(data, aes(x = Eccentricity)) +
  geom_histogram(fill = colore , color = "black", bins = 20) +
  labs(x = "Eccentricity",
       y = "Frequency") +
  theme_light()

# Istogramma per la colonna log.Eccentricity
ggplot(data, aes(x = log.Eccentricity)) +
  geom_histogram(fill = colore, color = "black", bins = 20) +
  labs(
       x = "log(Eccentricity)",
       y = "Frequency") +
  theme_light()

p = ggcoxdiagnostics(cox5bis, type = "deviance")
save(p)
