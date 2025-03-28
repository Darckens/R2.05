# Exécutez ceci la première fois que vous ouvrez le document pour installer tous les packages requis

#     list.of.packages <- c("ggplot2", "ggthemes", "extrafont", "gridExtra", "lmtest")
#     new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[, "Package"])]
#     if (length(new.packages)) install.packages(new.packages)


# Exécutez ces lignes au début

library(ggplot2)
library(ggthemes)
library(extrafont)
library(gridExtra)
library(lmtest)

# Exécutez ceci une seule fois

#     font_import()
#     loadfonts()


# Question 2 :


# Lecture des données
data <- read.csv("../donnees_r.csv", header = TRUE,  sep = ",", colClasses = c("numeric", "numeric"))

# Nuage de points
ggplot(data, aes(x = X, y = Y)) +
  geom_point(color = "red", size = 2) +
  labs(
    title = "Nuage de points : Dosage vs Bactéries",
    x = "Dosage de sérum (mL)",
    y = "Quantité de bactéries (UFC/mL)"
  ) +
  theme_fivethirtyeight() +
  theme(axis.title = element_text(), text = element_text(family = "Segoe UI", size = 14))


# Question 3 :

## a)

# Calcul de la moyenne et de la variance (de Pearson) de la quantité de bactéries
var_Y_pearson <- sum((data$Y - mean(data$Y))^2) / length(data$Y)

cat("Moyenne de la quantité de bactéries : ", mean(data$Y), "\n")
cat("Variance de la quantité de bactéries : ", var_Y_pearson)


## b)

# Boîte à moustache de la distribution de la quantité de bactéries
ggplot(data, aes(y = Y)) +
  geom_boxplot() +
  labs(title = "Boîte à moustache de la distribution\nde la quantité de bactéries") +
  theme_fivethirtyeight() +
  theme(text = element_text(family = "Segoe UI", size = 14))


# Question 4 :

# Calcul de la covariance entre X et Y 

covariance <- sum(data$X * data$Y) / length(data$X) - mean(data$X) * mean(data$Y)


cat("Covariance entre X et Y : ", covariance)


# Question 5 :

## a)

# Diagramme Quantile-Quantile (Q-Q plots) pour X
qqX <- ggplot(data) +
  geom_qq(aes(sample = X), geom = "point", position = "identity") +
  ggtitle("Q-Q Plot de X") +
  theme_fivethirtyeight() +
  theme(text = element_text(family = "Segoe UI", size = 14))

# Diagramme Quantile-Quantile (Q-Q plots) pour Y
qqY <- ggplot(data) +
  geom_qq(aes(sample = Y), geom = "point", position = "identity") +
  ggtitle("Q-Q Plot de Y") +
  theme_fivethirtyeight() +
  theme(text = element_text(family = "Segoe UI", size = 14))

# Affichage des Q-Q plots
grid.arrange(qqX, qqY, ncol = 2)


## b)

# Test de Shapiro-Wilk pour les variables X et Y
shapiro.test(data$X)
shapiro.test(data$Y)


# Question 6 :

# Calcul du coefficient de corrélation linéaire de Pearson
cor.test(data$X, data$Y, method = "pearson")


# Question 7 :

## Applications


# Calcul de la variance de X

var_X_pearson <- sum((data$X - mean(data$X))^2) / length(data$X)

# Calcul des coefficients a et b
a <- covariance / var_X_pearson
b <- mean(data$Y) - a * mean(data$X)

cat("a =", a, "b =", b)


# Nuage de points avec droite de régression
ggplot(data, aes(x = X, y = Y)) +
  geom_point(color = "red", size = 2) +
  geom_abline(slope = -0.083513, intercept = 0.856489, color = "blue", linewidth = 1) +
  labs(
    title = "Nuage de points : Dosage vs Bactéries",
    x = "Dosage de sérum (mL)",
    y = "Quantité de bactéries (UFC/mL)"
  ) +
  theme_fivethirtyeight() +
  theme(axis.title = element_text(), text = element_text(family = "Segoe UI", size = 14))



# Question 9 :

# Ajustement du modèle linéaire
LMS <- lm(data$Y ~ data$X)

# Résumé du modèle linéaire
summary(LMS)

#plot(summary(LMS)$residuals, main = "Distribution des résidus", ylab = "Résidus", xlab = "Observations")
#abline(h = 0, col = "red", lwd = 2)



# Question 10 :

# Calcul de la somme des carrés des résidus

# deviance(LMS) ou :

cat("SCR =", sum(residuals(LMS)^2))


# Question 11 :

## a)

### i)

# Autocorrélation des résidus
residuals <- residuals(LMS)
acf(residuals, main = "Autocorrélation des résidus")

### ii)

# Test de Durbin-Watson sur les résidus
dw_test <- dwtest(LMS)
print(dw_test)


## b)

### i)

# Test de Shapiro-Wilk sur les résidus
shapiro.test(residuals(LMS))


### ii)

# Diagramme Quantile-Quantile (Q-Q plot) des résidus :

qqnorm(residuals, main = "Q-Q Plot des résidus")
qqline(residuals, col = "red")


# Question 12 :

# Transformation logarithmique des données
z <- log(data$Y)

# Covariance du nouveau modèle
covariance_log <- sum(data$X * z) / length(data$X) - mean(data$X) * mean(z)

# Calcul des paramètres A et B
alpha <- covariance_log / var_X_pearson
beta <- exp(mean(z) - alpha * mean(data$X))


cat("Alpha =", alpha, "Beta =", beta)


# Fonction exponentielle ajustée
exponential_function <- function(x) {
  beta * exp(alpha*x)
}

# Nuage de points avec droite de régression exponentielle + linéaire
ggplot(data, aes(x = X, y = Y)) +
  geom_point(color = "red", size = 2) +
  geom_abline(slope = a, intercept = b, color = "blue", linewidth = 1) +
  stat_function(fun = exponential_function, color = "green", linewidth = 1) +
  labs(
    title = "Nuage de points : Dosage vs Bactéries",
    x = "Dosage de sérum (mL)",
    y = "Quantité de bactéries (UFC/mL)"
  ) +
  theme_fivethirtyeight() +
  theme(axis.title = element_text(), text = element_text(family = "Segoe UI", size = 14))


# Question 13 :

# Calcul de R² pour le modèle linéaire
summary(LMS)$r.squared


# Ajustement du modèle exponentiel
exponential_model <- lm(log(Y) ~ X, data = data)

# Calcul de R² pour le modèle exponentiel
summary(exponential_model)$r.squared



# Question 14 :


exp_modele_8_ML <- beta * exp(alpha * 8)

cat("Y exponentiel =", exp_modele_8_ML)

lin_modele_8_ML <- a * 8 + b

cat("Y linéaire =", lin_modele_8_ML)


cat("Moyenne des deux modèles =", (lin_modele_8_ML + exp_modele_8_ML) / 2)


# BONUS 

cat("X linéaire =", -b/a)


