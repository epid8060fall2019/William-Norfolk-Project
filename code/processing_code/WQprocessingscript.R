####################

#This script loads the raw data, processes and cleans it 
#and saves it as Rds file in the processed_data folder

#Load needed packages. make sure they are installed.

library(readxl)
library(dplyr)
library(tidyverse)


#Load the data. path is relative to project directory.
wqrawdata <- readxl::read_excel("./data/raw_data/RAW_WQ DATA.xlsx")


#Take a look at the data
dplyr::glimpse(wqrawdata)

#At a glance there is clearly some cleaning to be done. First the values for the
#variables "Date" and "Time" did not read into r properly. This is likely due
#to the autoformatting of dates by Excel. These data will not read into 
#the program properly and will cause problems downstream so it is best to solve
#this issue by reformatting the data entries in Excel by adding new columns to 
#replace the date and time variables. Date will now be represented as the new
#variable "Numeric Date" which has reformatted the date to a mm.dd.yy style. 
#Time will be represented as the new variable "Military Time" which has 
#reformatted the time to standard numeric military time. Both original variables 
#will be kept in the raw data set, but will be removed by further r processing.


#Reload the data with the reformatted Excel sheet.
wqrawdata <- readxl::read_excel("./data/raw_data/RAW_WQ DATA_TimeModified.xlsx")


#Take a look at the data once more. 
dplyr::glimpse(wqrawdata)


#We should have 11 variables in our data set but it seems that 15 have 
#been loaded. The variables "Timestamp" and "...15" are errors and should 
#be dropped. Also the old "Date" and "Time" variables should be removed.

wqrawdata_11 <- select(wqrawdata, -c(Timestamp, ...15, Date, Time))

wqrawdata_11

#The resulting data set is a tibble with 522 observations and 11 variables.
#Next the correct classes must be assigned to each variable so the data can be
#properly manipulated. All variables are currently listed as "characters" we 
#must change Military Time, pH, Dissolved Oxygen, Ammonia, Water Temp, and
#Salinity to numeric classes. 



#TO DO-make 
#Use as.numeric to convert variables
#Add a bay and ocean variable based on sites
