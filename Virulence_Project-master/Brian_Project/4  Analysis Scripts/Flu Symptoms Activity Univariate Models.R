###################
# Regression Models and Cochran-Mantel-Haenszel Test
# Brian McKay 
# 3-23-19
####################


# Clean up global enviroment ####  
rm(list=ls())
if(!is.null(names(sessionInfo()$otherPkgs))){
  lapply(paste('package:',names(sessionInfo()$otherPkgs),sep=""),detach,character.only=TRUE,unload=TRUE)}

#Load or install required packages
#Used for the ordinal regression 
if (require('finalfit')==FALSE) {install.packages('finalfit', repos="https://cran.rstudio.com"); require(finalfit)}
if (require('vcdExtra')==FALSE) {install.packages('vcdExtra', repos="https://cran.rstudio.com"); require(vcdExtra)}
if (require('tidyverse')==FALSE) {install.packages('tidyverse', repos="https://cran.rstudio.com"); require(tidyverse)}
if (require('DescTools')==FALSE) {install.packages('DescTools', repos="https://cran.rstudio.com"); require(DescTools)}

#Load data from "Data-Cleaning.R" script 
SympAct_Lab_Pos<-readRDS("3 Clean Data/SympAct_Lab_Pos.Rda")
SympAct_Any_Pos<-readRDS("3 Clean Data/SympAct_Any_Pos.Rda") 


# Models and Tests for Manuscript ####

########Score Trend Tests Lab Diagnosis

##Impact Score  and Activity 
Impact_Trend_Lab<-CMHtest(Freq~ActivityLevelF+ImpactScoreFD, SympAct_Lab_Pos)
Impact_Trend_Lab
saveRDS(Impact_Trend_Lab, file = "5 Results/Models/Impact_Trend_Lab.Rda")
###Checking the expected values for Impact
ImpactTable<-table(SympAct_Lab_Pos$ActivityLevelF,SympAct_Lab_Pos$ImpactScoreFD)
Impact_Chi<-chisq.test(ImpactTable)
Impact_Chi$expected

##Trans Score and Activity
Trans_Trend_Lab<-CMHtest(Freq~ActivityLevelF+TransScoreF, SympAct_Lab_Pos)
Trans_Trend_Lab
saveRDS(Trans_Trend_Lab, file = "5 Results/Models/Trans_Trend_Lab.Rda")
###Checking the expected values for Trans
TransTable<-table(SympAct_Lab_Pos$ActivityLevelF,SympAct_Lab_Pos$TransScoreF)
Trans_Chi<-chisq.test(TransTable)
Trans_Chi$expected

##Trans Vs Impact
TvI_Trend_Lab<-CMHtest(Freq~ImpactScoreFD+TransScoreF, SympAct_Lab_Pos)
TvI_Trend_Lab
saveRDS(TvI_Trend_Lab, file = "5 Results/Models/TvI_Trend_Lab.Rda")
###Checking the expected values for Trans Vs Impact
TvITable<-table(SympAct_Lab_Pos$ImpactScoreFD,SympAct_Lab_Pos$TransScoreF)
TvI_Chi<-chisq.test(TvITable)
TvI_Chi$expected

########## Correlation of For scores and activity Lab Diagnosis 
Impact_Cor_Lab<-SpearmanRho(SympAct_Lab_Pos$ImpactScore, SympAct_Lab_Pos$ActivityLevel, conf.level = 0.95)
saveRDS(Impact_Cor_Lab, file = "5 Results/Models/Impact_Cor_Lab.Rda")

Trans_Cor_Lab<-SpearmanRho(SympAct_Lab_Pos$TransScore, SympAct_Lab_Pos$ActivityLevel, conf.level = 0.95)
saveRDS(Trans_Cor_Lab, file = "5 Results/Models/Trans_Cor_Lab.Rda")

TvI_Cor_Lab<-SpearmanRho(SympAct_Lab_Pos$ImpactScore, SympAct_Lab_Pos$TransScore, conf.level = 0.95)
saveRDS(TvI_Cor_Lab, file = "5 Results/Models/TvI_Cor_Lab.Rda")

########## Linear Regression For Symptoms and Activity Lab Diagnosis

explanatory<-c("CoughYN",  "ChestCongestion", "NasalCongestion", "Sneeze", "RunnyNose",
               "ChillsSweats", "Fatigue", "SubjectiveFever", 
               "Headache", "WeaknessYN", "MyalgiaYN", "SwollenLymphNodes",
               "AbPain", "ChestPain", "Diarrhea", "EyePn", "Insomnia", 
               "ItchyEye", "Nausea", "EarPn", "Pharyngitis", "Breathless", 
               "ToothPn", "Vomit", "Wheeze")

explanatory <- str_sort(explanatory)

# Based on subset selection using MLR (code in "Multivariate Subset Selection.R" script)
explanatory_multi<-c("ChestCongestion", "SubjectiveFever", "Headache", "WeaknessYN", "Insomnia", "Vomit")

dependent<-"ActivityLevel"


LmActvSympLab<-SympAct_Lab_Pos %>% finalfit(dependent, explanatory, explanatory_multi, add_dependent_label=TRUE)

saveRDS(LmActvSympLab, file = "5 Results/Models/LmActvSympLab.Rda")


# RESULTS PRESENTED IN THE SUPPLEMENT ####

######## Sensitivity Analysis with Yule's Q cut off at 0.75 instead of 0.9 for Lab Dx (PCR or Rapid) ####

# ONLY THE MORBIDITY SCORE CHANGES

## 0.75 Cut off Impact Score  and Activity  
Impact75_Trend_Lab<-CMHtest(Freq~ActivityLevelF+ImpactScoreCCFD, SympAct_Lab_Pos)
Impact_Trend_Lab
saveRDS(Impact75_Trend_Lab, file = "5 Results/Models/Impact75_Trend_Lab.Rda")
### 0.75 Cut off Checking the expected values for Impact
ImpactTable<-table(SympAct_Lab_Pos$ActivityLevelF,SympAct_Lab_Pos$ImpactScoreCCFD)
Impact_Chi<-chisq.test(ImpactTable)
Impact_Chi$expected

## 0.75 Cut off Trans Vs Impact
TvI75_Trend_Lab<-CMHtest(Freq~ImpactScoreCCFD+TransScoreF, SympAct_Lab_Pos)
TvI75_Trend_Lab
saveRDS(TvI75_Trend_Lab, file = "5 Results/Models/TvI75_Trend_Lab.Rda")
###Checking the expected values for Trans Vs Impact
TvITable<-table(SympAct_Lab_Pos$ImpactScoreCCFD,SympAct_Lab_Pos$TransScoreF)
TvI_Chi<-chisq.test(TvITable)
TvI_Chi$expected

########## Correlation of For 0.75 Cut off scores and activity Lab Diagnosis 

Impact75_Cor_Lab<-SpearmanRho(SympAct_Lab_Pos$ImpactScoreCC, SympAct_Lab_Pos$ActivityLevel, conf.level = 0.95)
saveRDS(Impact75_Cor_Lab, file = "5 Results/Models/Impact75_Cor_Lab.Rda")

Trans75_Cor_Lab<-SpearmanRho(SympAct_Lab_Pos$TransScore, SympAct_Lab_Pos$ActivityLevel, conf.level = 0.95)
saveRDS(Trans75_Cor_Lab, file = "5 Results/Models/Trans75_Cor_Lab.Rda")

TvI75_Cor_Lab<-SpearmanRho(SympAct_Lab_Pos$ImpactScoreCC, SympAct_Lab_Pos$TransScore, conf.level = 0.95)
saveRDS(TvI75_Cor_Lab, file = "5 Results/Models/TvI75_Cor_Lab.Rda")


######## Score Trend Tests Any Diagnosis (Rapid, PCR, and Empirical) ####

##Impact Score  and Activity
Impact_Trend_Any<-CMHtest(Freq~ActivityLevelF+ImpactScoreSMFD, SympAct_Any_Pos)
Impact_Trend_Any
saveRDS(Impact_Trend_Any, file = "5 Results/Models/Impact_Trend_Any.Rda")
###Checking the expected values for Impact
ImpactTable<-table(SympAct_Any_Pos$ActivityLevelF,SympAct_Any_Pos$ImpactScoreSMFD)
Impact_Chi<-chisq.test(ImpactTable)
Impact_Chi$expected

##Trans Score and Activity
Trans_Trend_Any<-CMHtest(Freq~ActivityLevelF+TransScoreSMF, SympAct_Any_Pos)
Trans_Trend_Any
saveRDS(Trans_Trend_Any, file = "5 Results/Models/Trans_Trend_Any.Rda")
###Checking the expected values for Trans
TransTable<-table(SympAct_Any_Pos$ActivityLevelF,SympAct_Any_Pos$TransScoreSMF)
Trans_Chi<-chisq.test(TransTable)
Trans_Chi$expected

##Trans Vs Impact
TvI_Trend_Any<-CMHtest(Freq~ImpactScoreSMFD+TransScoreSMF, SympAct_Any_Pos)
TvI_Trend_Any
saveRDS(TvI_Trend_Any, file = "5 Results/Models/TvI_Trend_Any.Rda")
###Checking the expected values for Trans Vs Impact
TvITable<-table(SympAct_Any_Pos$ImpactScoreSMFD,SympAct_Any_Pos$TransScoreSMF)
TvI_Chi<-chisq.test(TvITable)
TvI_Chi$expected

########## Correlation of For scores and activity Any Diagnosis

Impact_Cor_Any<-SpearmanRho(SympAct_Any_Pos$ImpactScoreSM, SympAct_Any_Pos$ActivityLevel, conf.level = 0.95)
saveRDS(Impact_Cor_Any, file = "5 Results/Models/Impact_Cor_Any.Rda")

Trans_Cor_Any<-SpearmanRho(SympAct_Any_Pos$TransScoreSM, SympAct_Any_Pos$ActivityLevel, conf.level = 0.95)
saveRDS(Trans_Cor_Any, file = "5 Results/Models/Trans_Cor_Any.Rda")

TvI_Cor_Any<-SpearmanRho(SympAct_Any_Pos$TransScoreSM, SympAct_Any_Pos$ImpactScoreSM, conf.level = 0.95)
saveRDS(TvI_Cor_Any, file = "5 Results/Models/TvI_Cor_Any.Rda")

########## Linear Regression For Symptoms and Activity Any Diagnosis

explanatory<-c("CoughYN",  "ChestCongestion", "NasalCongestion", "Sneeze", "RunnyNose",
               "ChillsSweats", "Fatigue", "SubjectiveFever",
               "Headache", "WeaknessYN", "MyalgiaYN", "SwollenLymphNodes",
               "AbPain", "ChestPain", "Diarrhea", "EyePn", "Insomnia",
               "ItchyEye", "Nausea", "EarPn", "Pharyngitis", "Breathless",
               "ToothPn", "Vomit", "Wheeze")

explanatory <- str_sort(explanatory)

# Based on subset selection using MLR (code in "Multivariate Subset Selection.R" script)
explanatory_multi<-c("ChillsSweats", "SubjectiveFever", "Headache", "WeaknessYN", "Insomnia", "Vomit")

dependent<-"ActivityLevel"


LmActvSympAny<-SympAct_Any_Pos %>% finalfit(dependent, explanatory, explanatory_multi, add_dependent_label=TRUE)

saveRDS(LmActvSympAny, file = "5 Results/Models/LmActvSympAny.Rda")

