
#####Describing the Code
___
The script in file `run_analysis.R` processes the data in way described in the task definition.

* First it clean up the environment `rm()` function, then checks if file exist, if not - downloads it and unzips `file.exists()` , `unzip()` functions.

* Then, it loads the labels with `read.table()` function, and extracts appropriate labels by mapping only the mean and std : `grep(".*mean.*|.*std.*",...)`. Stores into `activLabels`, and `features` variables.

* Loads the data from `train` and `test` files into `xtest`, `ytest`, `subjectTest`, `ytrain`, `subjectTrain`, with `read.table()`, combines features and labels with `cbind()` into `testset`, `trainset`, . Stores the result in new dataset `mainSet` with `rbind()`.

* Assigns the colum names with `colnames()`.

* Reshapes the data with `reshape2::melt()` and `reshape2::dcast()` writes the result with `write.table()` into file `"tidydataset.txt"`.
