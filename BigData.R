#Individual Assignment

#Install microbenchmark package
install.packages("microbenchmark")
install.packages("corrgram")
install.packages("corrplot")

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
library(corrgram)
library(corrplot)

#Processing
#Change directory
setwd("~/INTI College Penang - BCS/Dataset/area_level")

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
#Change directory
setwd("~/INTI College Penang - BCS/Dataset/several_al")

#Parallel cluster
numCores <- detectCores()
numCores

cl <- parallel::makeCluster(numCores)

clusterEvalQ(cl, {
  library(parallel)
  library(tidyverse)
})

AL_Grocery2 <-
  list.files(path = ".", pattern = "*.csv") %>%
  map_df(~read_csv(.))
AL_Grocery2

Par <- function(i)
{
  parLapply(cl, 1:100, AL_Grocery2)
  stopCluster(cl)
}

Par <- microbenchmark("Parallel " = {parLapply(cl, 1:100, AL_Grocery2)})
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
obesity <- merge(area_borough, child_obesity,
                  by.x = "area_id")

obesity <- obesity %>% select(area_id, prevalence_obese_reception, carb, sugar, fat, 
                              saturate, protein, fibre)

#View selected data as a dataset
view(obesity)

#Correlation
#Calculation
corArr <- c("Carbohydrates" = cor(obesity$prevalence_obese_reception, obesity$carb),
            "Sugar" = cor(obesity$prevalence_obese_reception, obesity$sugar), 
            "Fat" = cor(obesity$prevalence_obese_reception, obesity$fat),
            "Saturated Fat" = cor(obesity$prevalence_obese_reception, obesity$saturate),
            "Protein" = cor(obesity$prevalence_obese_reception, obesity$protein),
            "Fibre" = cor(obesity$prevalence_obese_reception, obesity$fibre))
corArr

#Answer: The nutrients which has the lowest correlation with obesity is Protein.
min(corArr)

#Plot the correlation
corrplot(corr = cor(obesity[2:8]),
         title = "Correlation - Child Obesity and Nutrients",
         method = "number",  # Correlation plot method
         type = "upper",     # Correlation plot style (also "upper" and "lower")
         diag = FALSE,       # If TRUE (default), adds the diagonal
         tl.col = "black",   # Labels color
         bg = "black",       # Background color
         tl.cex = 0.8,       # Font size of text labels
         number.cex = 0.8,   # Font size of correlation labels
         cl.ratio = 0.2,     # Plot ratio
         col = NULL,
         mar=c(0,1,2,0))

ggpairs(obesity[2:8])
