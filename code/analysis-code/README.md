# analysis-code

This folder contains two Quarto files with statistical analysis. They must be run in the proper order as the latter file depends on the former for `.rds` files.

The first file contains the necessary data transformation and feature space generation needed to model complex, unstructured text files. It also contains the necessary function definitions and tuning grids needed for modeling the transformed data.

The second file contains the evaluation of the various permutations of each model tuned in the prior Quarto file. Within are predictions generated on the test data, confusion matrices, and code to generate figures that showcase model performance and variable importance. 