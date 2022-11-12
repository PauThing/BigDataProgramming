#Individual Assignment
#Connect Github

install.packages("microbenchmark")

library(dplyr)
library(ggplot2)
library(tidyverse)
library(ggpubr)
library(microbenchmark)
library(parallel)

#Change directory
setwd("~/INTI College Penang - BCS/Semester 3_Aug 2022/5011CEM Big Data Programming Project/Assignment/BigDataProgramming/Dataset/area_level")

#Import the dataset
csv_files <- list.files(path = ".")
AL_Grocery = do.call(rbind, lapply(csv_files, function(x) read.csv(x, stringsAsFactors = FALSE)))
AL_Grocery

#Sequential
#Whole area level
Seq <- microbenchmark("Sequential " = {do.call(rbind, lapply(list_csv_files, function(x) read.csv(x, stringsAsFactors = FALSE)))})
Seq

autoplot(Seq)

#Parallel
#Whole area level
numCores <- detectCores()
numCores

cl <- makeCluster(numCores)

clusterEvalQ(cl, 2 + 2)

Par <- function(i)
{
  do.call(rbind, parLapply(list_csv_files, function(x) read.csv(x, stringsAsFactors = FALSE))
}
Par

Par <- microbenchmark("Parallel " = {do.call(rbind, lapply(list_csv_files, function(x) read.csv(x, stringsAsFactors = FALSE)))})
Par

autoplot(Par)

#Change directory
setwd("~/INTI College Penang - BCS/Semester 3_Aug 2022/5011CEM Big Data Programming Project/Assignment/BigDataProgramming/Dataset")

#Health
child_obesity_borough <- read.csv("obesity_diabetes/child_obesity_london_borough_2015-2016.csv")
london_obesity_borough <- read.csv("obesity_diabetes/london_obesity_borough_2012.csv")

#Area
borough <- read.csv("area_level/year_borough_grocery.csv")
