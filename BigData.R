#Individual Assignment

#Install packages
install.packages("microbenchmark")
install.packages("corrplot")
install.packages("GGally")

#Run the libraries
library(dplyr)
library(ggplot2)
library(tidyr)
library(tidyverse)
library(ggpubr)
library(microbenchmark)
library(cluster)
library(parallel)
library(data.table)
library(corrplot)
library(GGally)

#Processing
#Change directory
setwd("~/INTI College Penang - BCS/Dataset/several_al")

#Import the dataset
csv_files <- list.files(path = ".")

#Sequential
#Whole area level
Seq <- microbenchmark("Sequential " = {do.call(rbind, lapply(csv_files, function(x) 
                      read.csv(x, stringsAsFactors = FALSE)))})
Seq

autoplot(Seq)

#Change directory
setwd("~/INTI College Penang - BCS/Dataset/several_al")

#Import the dataset
csv_files2 <- list.files(path = ".")

#Parallel
#Whole area level
Par <- microbenchmark("Parallel " = {do.call(rbind, mclapply(csv_files, function(x) 
                      read.csv(x, stringsAsFactors = FALSE)))})
Par

autoplot(Par)




#Objective
#Change directory
setwd("~/INTI College Penang - BCS/Dataset")

#Health data
child_obesity <- read.csv("obesity_diabetes/child_obesity_london_borough_2015-2016.csv")

#Area data
area_borough <- read.csv("area_level/year_borough_grocery.csv")

#View the datasets
view(child_obesity)
view(area_borough)

#Merge datasets
data <- merge(area_borough, child_obesity,
                  by.x = "area_id")

obesity <- data %>% select(area_id, prevalence_obese_reception, carb, sugar, fat, 
                           saturate, protein, fibre)

#View selected data as a dataset
view(obesity)

#Correlation - Nutrients and Child Obesity
#Calculation
corArr <- c("Carbohydrates" = cor(obesity$prevalence_obese_reception, obesity$carb),
            "Sugar" = cor(obesity$prevalence_obese_reception, obesity$sugar), 
            "Fat" = cor(obesity$prevalence_obese_reception, obesity$fat),
            "Saturated Fat" = cor(obesity$prevalence_obese_reception, obesity$saturate),
            "Protein" = cor(obesity$prevalence_obese_reception, obesity$protein),
            "Fibre" = cor(obesity$prevalence_obese_reception, obesity$fibre))
corArr

#Answer: Fibre
min(corArr)

#Plot the correlation
corrplot(corr = cor(obesity[2:8]),
         title = "Correlation - Child Obesity and Nutrients",
         method = "number",  # Correlation plot method
         type = "upper",     # Correlation plot style (also "upper" and "lower")
         diag = FALSE,       # If TRUE (default), adds the diagonal
         tl.col = "black",   # Labels color
         bg = "black",       # Background color
         tl.cex = 0.7,       # Font size of text labels
         number.cex = 0.9,   # Font size of correlation labels
         cl.ratio = 0.2,     # Plot ratio
         col = NULL,
         mar=c(0,1,2,0))

ggpairs(obesity[2:8])

#Regression - Nutrients and Child Obesity
#Calculation
reg <- lm(obesity$prevalence_obese_reception~obesity$carb)
print(reg)

reg <- lm(obesity$prevalence_obese_reception~obesity$sugar)
print(reg)

reg <- lm(obesity$prevalence_obese_reception~obesity$fat)
print(reg)

reg <- lm(obesity$prevalence_obese_reception~obesity$saturate)
print(reg)

reg <- lm(obesity$prevalence_obese_reception~obesity$protein)
print(reg)

reg <- lm(obesity$prevalence_obese_reception~obesity$fibre)
print(reg)

#Plot the regression
plot(obesity$carb, obesity$prevalence_obese_reception, 
     main = "Regression - Child Obesity and Nutrients", 
     abline(lm(obesity$prevalence_obese_reception~obesity$carb)), 
     cex = 1,pch = 16, xlab = "Carbohydrates", ylab = "Child Obesity")

plot(obesity$sugar, obesity$prevalence_obese_reception, 
     main = "Regression - Child Obesity and Nutrients", 
     abline(lm(obesity$prevalence_obese_reception~obesity$sugar)), 
     cex = 1,pch = 16, xlab = "Sugar", ylab = "Child Obesity")

plot(obesity$fat, obesity$prevalence_obese_reception, 
     main = "Regression - Child Obesity and Nutrients", 
     abline(lm(obesity$prevalence_obese_reception~obesity$fat)), 
     cex = 1,pch = 16, xlab = "Fat", ylab = "Child Obesity")

plot(obesity$saturate, obesity$prevalence_obese_reception, 
     main = "Regression - Child Obesity and Nutrients", 
     abline(lm(obesity$prevalence_obese_reception~obesity$saturate)), 
     cex = 1,pch = 16, xlab = "Saturated Fat", ylab = "Child Obesity")

plot(obesity$protein, obesity$prevalence_obese_reception, 
     main = "Regression - Child Obesity and Nutrients", 
     abline(lm(obesity$prevalence_obese_reception~obesity$protein)), 
     cex = 1,pch = 16, xlab = "Protein", ylab = "Child Obesity")

plot(obesity$fibre, obesity$prevalence_obese_reception, 
     main = "Regression - Child Obesity and Nutrients", 
     abline(lm(obesity$prevalence_obese_reception~obesity$fibre)), 
     cex = 1,pch = 16, xlab = "Fibre", ylab = "Child Obesity")



#Correlation - Energy of Nutrients and Child Obesity
obesity2 <- data %>% select(area_id, prevalence_obese_reception, energy_carb, energy_sugar, energy_fat, 
                         energy_saturate, energy_protein, energy_fibre)

#View selected data as a dataset
view(obesity2)

#Correlation - Nutrients and Food Categories
#Calculation
corArr2 <- c("Carbohydrates" = cor(obesity2$prevalence_obese_reception, obesity2$energy_carb),
             "Sugar" = cor(obesity2$prevalence_obese_reception, obesity2$energy_sugar), 
             "Fat" = cor(obesity2$prevalence_obese_reception, obesity2$energy_fat),
             "Saturated Fat" = cor(obesity2$prevalence_obese_reception, obesity2$energy_saturate),
             "Protein" = cor(obesity2$prevalence_obese_reception, obesity2$energy_protein),
             "Fibre" = cor(obesity2$prevalence_obese_reception, obesity2$energy_fibre))
corArr2

#Answer: Fibre
min(corArr2)

#Plot the correlation
corrplot(corr = cor(obesity2[2:8]),
         title = "Correlation - Child Obesity and Energy of Nutrients",
         method = "number",  # Correlation plot method
         type = "upper",     # Correlation plot style (also "upper" and "lower")
         diag = FALSE,       # If TRUE (default), adds the diagonal
         tl.col = "black",   # Labels color
         bg = "black",       # Background color
         tl.cex = 0.7,       # Font size of text labels
         number.cex = 0.9,   # Font size of correlation labels
         cl.ratio = 0.2,     # Plot ratio
         col = NULL,
         mar=c(0,1,2,0))

ggpairs(obesity2[2:8])

#Regression - Energy of Nutrients and Child Obesity
#Calculation
reg2 <- lm(obesity2$prevalence_obese_reception~obesity2$energy_carb)
print(reg2)

reg2 <- lm(obesity2$prevalence_obese_reception~obesity2$energy_sugar)
print(reg2)

reg2 <- lm(obesity2$prevalence_obese_reception~obesity2$energy_fat)
print(reg2)

reg2 <- lm(obesity2$prevalence_obese_reception~obesity2$energy_saturate)
print(reg2)

reg2 <- lm(obesity2$prevalence_obese_reception~obesity2$energy_protein)
print(reg2)

reg2 <- lm(obesity2$prevalence_obese_reception~obesity2$energy_fibre)
print(reg2)

#Plot the regression
plot(obesity2$energy_carb, obesity2$prevalence_obese_reception, 
     main = "Regression - Child Obesity and Energy of Nutrients", 
     abline(lm(obesity2$prevalence_obese_reception~obesity2$energy_carb)), 
     cex = 1,pch = 16, xlab = "Carbohydrates", ylab = "Child Obesity")

plot(obesity2$energy_sugar, obesity2$prevalence_obese_reception, 
     main = "Regression - Child Obesity and Energy of Nutrients", 
     abline(lm(obesity2$prevalence_obese_reception~obesity2$energy_sugar)), 
     cex = 1,pch = 16, xlab = "Sugar", ylab = "Child Obesity")

plot(obesity2$energy_fat, obesity2$prevalence_obese_reception, 
     main = "Regression - Child Obesity and Energy of Nutrients", 
     abline(lm(obesity2$prevalence_obese_reception~obesity2$energy_fat)), 
     cex = 1,pch = 16, xlab = "Fat", ylab = "Child Obesity")

plot(obesity2$energy_saturate, obesity2$prevalence_obese_reception, 
     main = "Regression - Child Obesity and Energy of Nutrients", 
     abline(lm(obesity2$prevalence_obese_reception~obesity2$energy_saturate)), 
     cex = 1,pch = 16, xlab = "Saturated Fat", ylab = "Child Obesity")

plot(obesity2$energy_protein, obesity2$prevalence_obese_reception, 
     main = "Regression - Child Obesity and Energy of Nutrients", 
     abline(lm(obesity2$prevalence_obese_reception~obesity2$energy_protein)), 
     cex = 1,pch = 16, xlab = "Protein", ylab = "Child Obesity")

plot(obesity2$energy_fibre, obesity2$prevalence_obese_reception, 
     main = "Regression - Child Obesity and Energy of Nutrients", 
     abline(lm(obesity2$prevalence_obese_reception~obesity2$energy_fibre)), 
     cex = 1,pch = 16, xlab = "Fibre", ylab = "Child Obesity")

