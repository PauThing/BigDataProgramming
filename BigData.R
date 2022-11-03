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
#Whole area level
df <-
  list.files(path = ".", pattern = "*.csv") %>%
  map_df(~read_csv(.))
df

#Change directory
setwd("~/INTI College Penang - BCS/Semester 3_Aug 2022/5011CEM Big Data Programming Project/Assignment/BigDataProgramming/Dataset")

#Health
child_obesity_borough <- read.csv("obesity_diabetes/child_obesity_london_borough_2015-2016.csv")
london_obesity_borough <- read.csv("obesity_diabetes/london_obesity_borough_2012.csv")

#Area
borough <- read.csv("area_level/year_borough_grocery.csv")
