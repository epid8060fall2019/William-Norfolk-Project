####################

#this script loads the raw data, processes and cleans it 
#and saves it as Rds file in the processed_data folder

#load needed packages. make sure they are installed.

library(readxl)
library(dplyr)
library(tidyverse)


#load data. path is relative to project directory.
wqrawdata <- readxl::read_excel("./data/raw_data/RAW_WQ DATA.xlsx")

#take a look at the data
dplyr::glimpse(wqrawdata)

#We should have 11 variables in our data set but it seems that 13 have 
#been loaded. The variables "Timestamp" and "...13" are errors and should 
#be dropped.

wqrawdata_11 <- select(wqrawdata, -c(Timestamp, ...13))





#TO DO-make NA = na in r try replace_with_na() function, 
#   remove timestamp variabe, remove ...13 variable, add ocean or 
#   bay variable, add age-group variable to group cohorts.

#