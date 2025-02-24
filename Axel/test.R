# Installation des packages nécessaires -----------------------------------

list.of.packages <- c("ggplot2", "ggthemes", "extrafont", "gridExtra", "lmtest")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[, "Package"])]
if (length(new.packages)) install.packages(new.packages)

# Initialisation des packages ---------------------------------------------

library(ggplot2)
library(ggthemes)
library(extrafont)
library(gridExtra)
library(lmtest)

# Chargement des polices --------------------------------------------------

font_import()
loadfonts()

# Chargement du fichier csv -----------------------------------------------

data <- read.csv("../donnees_r.csv", header = TRUE, sep = ",", colClasses = c("numeric", "numeric"))

# Création du nuage du points ---------------------------------------------

ggplot(data, aes(x = X, y = Y)) +
  geom_point(color = "red", size = 2) +
  labs(
    title = "Nuage de points : Dosage vs Bactéries",
    x = "Dosage de sérum (mL)",
    y = "Quantité de bactéries (UFC/mL)"
  ) +
  theme_fivethirtyeight() +
  theme(axis.title = element_text(), text = element_text(family = "Segoe UI", size = 14))

# Création du box-plot de la quantité de bactéries ------------------------

ggplot(data, aes(y = Y)) +
  geom_boxplot() +
  labs(title = "Boîte à moustache de la distribution\nde la quantité de bactéries") +
  theme_fivethirtyeight() +
  theme(text = element_text(family = "Segoe UI", size = 14))

# Création du Q-Q plot ----------------------------------------------------

qqX <- ggplot(data) +
  geom_qq(aes(sample = X), geom = "point", position = "identity") +
  ggtitle("Q-Q Plot de X") +
  theme_fivethirtyeight() +
  theme(text = element_text(family = "Segoe UI", size = 14))

qqY <- ggplot(data) +
  geom_qq(aes(sample = Y), geom = "point", position = "identity") +
  ggtitle("Q-Q Plot de Y") +
  theme_fivethirtyeight() +
  theme(text = element_text(family = "Segoe UI", size = 14))

grid.arrange(qqX, qqY, ncol = 2)

# Test de Shapiro ---------------------------------------------------------

shapiro.test(data$X)
shapiro.test(data$Y)

# Coefficient de corrélation ----------------------------------------------

cor.test(data$X, data$Y, method = "pearson")
