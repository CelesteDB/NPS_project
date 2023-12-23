# Load Data
data <- read_excel("../Dataset/JoinDatasets.xlsx", col_names = TRUE)

# Merge classes
data$Continent[which(data$Continent == "Africa")] <- "Rest of the World"
data$Continent[which(data$Continent == "Oceania")] <- "Rest of the World"
data$Continent[which(data$Continent == "Multinational")] <- "Rest of the World"

data$Purpose[which(data$Purpose == "Navigation")] <- "Earth Observation"

#Factor Variables
data$Continent <- factor(data$Continent, ordered = F)
data$Purpose <- factor(data$Purpose, ordered = F)
data$Status <- factor(data$Status, ordered = F)

# KM Curve
x11()
time <- data$'Effective Lifetime'
fit <- survfit(Surv(time,Status == 'retired') ~ 1, data = data)
ggsurvplot(fit, data = data,
           risk.table = TRUE, # Add risk table
           risk.table.col = "strata", # Change risk table color by groups
           surv.median.line = "hv", # Specify median survival
           ggtheme = theme_bw(), # Change ggplot2 theme
           break.time.by=5,
           title="Kaplan-Meier Curve for Satellites Survival")

#Cumulative hazard
x11()
ggsurvplot(fit, data = data,
           risk.table = TRUE, # Add risk table
           ggtheme = theme_bw(), # Change ggplot2 theme
           cumhaz.median.line = "hv", # Specify median survival
           break.time.by=5,
           fun='cumhaz',
           title="Cumulative Hazard Curve for Satellites Survival")

#KM curves by continent
x11()
fit.Continent <- survfit(Surv(time,Status == 'retired') ~ Continent, data=data)
ggsurvplot(fit.Continent, data = data,
           risk.table = TRUE, # Add risk table
           risk.table.col = "strata",
           ggtheme = theme_bw(), # Change ggplot2 theme
           break.time.by=5,
           title="Kaplan-Meier Curve for Satellites Survival by Continent")

#KM curves by User
x11()
fit.Users <- survfit(Surv(time, Status == 'retired') ~ Users, data=data)
ggsurvplot(fit.Users, data = data,
           risk.table = TRUE, # Add risk table
           risk.table.col = "strata",
           ggtheme = theme_bw(), # Change ggplot2 theme
           break.time.by=5,
           title="Kaplan-Meier Curve for Satellites Survival by Users")

#KM curves by Purpose
x11()
fit.Purpose <- survfit(Surv(time, Status == 'retired') ~ Purpose, data=data)
ggsurvplot(fit.Purpose, data = data,
           risk.table = TRUE, # Add risk table
           risk.table.col = "strata",
           ggtheme = theme_bw(), # Change ggplot2 theme
           break.time.by=5,
           title="Kaplan-Meier Curve for Satellites Survival by Purpose")