# Analyse bivariée : dosage d’un sérum et efficacité contre une bactérie

## Présentation du projet

Ce projet s’inscrit dans le cadre du module **R2.05 - Statistique Descriptive 2** du BUT Science des Données. L’objectif est d’étudier la relation entre deux variables quantitatives : le **dosage d’un sérum** et la **quantité de bactéries Zomb-2025** encore présentes dans l’organisme après injection. L’analyse permet d’évaluer l’efficacité du sérum via des méthodes statistiques, visuelles et algorithmiques.

## Outils et notions mobilisées

- **Langage** : R
- **Packages** : `ggplot2`, `car`, `lmtest`, `ggpubr`
- **Notions statistiques** :
  - Régression linéaire simple (ajustement par moindres carrés)
  - Régression exponentielle
  - Coefficient de corrélation de Pearson
  - Coefficient de détermination $R^2$
  - Analyse des résidus (normalité, indépendance)
  - Tests statistiques : Shapiro-Wilk, Durbin-Watson
  - Visualisation des données (nuage de points, QQ-plot, Boxplot)

Ces apprentissages s’inscrivent dans le cadre du programme national de la ressource R2.05, visant à **ajuster statistiquement des courbes entre deux caractères quantitatifs**.

## Sujet du projet

Un épidémiologiste teste un sérum sur une bactérie fictive, **Zomb-2025**, qui transforme les humains en zombies. Chaque patient reçoit une dose $x_i$ de sérum. On mesure ensuite la quantité de bactéries restantes $y_i$ dans le corps.

L’objectif est de :
- Déterminer s’il existe une **corrélation** entre le dosage et l’efficacité du sérum
- Proposer des **modèles prédictifs** (linéaire et exponentiel)
- Comparer ces modèles pour prévoir l’effet d’un dosage futur

L’étude repose sur des données réelles issues du fichier `donnees_r.csv`.

## Membres du projet

Projet réalisé dans le cadre de la R2.05 - BUT Science des Données 2e semestre, par :

- [Ibrahim BENKHERFELLAH](https://github.com/Darckens)  
- [Axel COULET](https://github.com/axcou)

## Licence

Ce projet est proposé à des fins pédagogiques uniquement. Reproduction interdite sans autorisation.
