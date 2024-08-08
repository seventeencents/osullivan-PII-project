# Overview

This repository houses a spam email classification data science project. Within the file structure of the project you'll find copies of the data sets used, which can be originally found [here on Kaggle](https://www.kaggle.com/datasets/naserabdullahalam/phishing-email-dataset/data?select=CEAS_08.csv), code files for loading/cleaning/exploring/visualizing the datasets, in addition to a machine learning classification model process.

# Pre-requisites

This particular data science project exclusively makes use of the R programming language and Quarto files for mixed code and results sharing. The following R packages are necessary for reproducing the various results found throughout the project:

-   pacman - for ensuring the subsequent packages are simultaneously installed and loaded

-   here - for data loading/saving

-   tidyverse - for data manipulation and plotting

-   skimr - for data exploration and summary

-   ggthemes - for plot theming

-   tidytext - for text analysis

-   quanteda - for text analysis

-   caret - for model training

-   e1071 - for model training

-   randomForest - for model training

-   gridExtra - for table printing

-   irlba - for SVD

-   doSNOW - for parallel processing

-   doParallel - for parallel processing

-   parallel - for parallel processing

# Getting started

In order to get started please see the project manuscript located within the `./products/manuscript` folder. This manuscript file will serve as the formal project report as well as an extensive resource in understanding the various code files and figure locations that are at play in ultimately producing and presenting the project findings.
