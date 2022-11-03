#Individual Assignment
#Connect Github

library(dplyr)
library(ggplot2)
library(tidyverse)
library(ggpubr)
library(parallel)

#Change directory
setwd("~/INTI College Penang - BCS/Semester 3_Aug 2022/5011CEM Big Data Programming Project/Assignment/BigDataProgramming/Dataset")

#Import the dataset
#Whole area level
df <-
  list.files(path = "/area_level/", pattern = "*.csv") %>%
  map_df(~read_csv(.))
df

#Health
child_obesity_borough <- read.csv("obesity_diabetes/child_obesity_london_borough_2015-2016.csv")
london_obesity_borough <- read.csv("obesity_diabetes/london_obesity_borough_2012.csv")

#Area
borough <- read.csv("area_level/year_borough_grocery.csv")
