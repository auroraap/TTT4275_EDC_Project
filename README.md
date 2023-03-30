# TTT4275 EDC Project code

This README gives a brief explanation of how to run the tasks of the EDC music classification project.

## Utilities
This folder contains all functions needed in all scripts, and all data files used. The path is added in all scripts. The functions are: dataExtraction, getErrorRate, kNN, normalizeSet, and scores. Type:

> help *functionName*

in the command line to get documentation.

## knn
This folder contains the code for the three first parts. They can all be run independently, and will output plots to the ./knn/figs folder.

## neuralNet
This folder contains the code for part four: a script for knn for all features, a training script for the neural network, and a test script for the neural network. The already trained network is in the folder as well and is loaded into the test script. Be sure to not overwrite the trained network when training a new network - watch the two final lines of the training script. All three scripts can be run independently (test can be run if there is a network available to load), and will output plots to the ./neuralNet/figs folder.