####################################
# Data cleaning script 
# Cleans and merges data 
# Data from UHC flu season of 2016-2017
# Last edit 3-21-2019
# Author: Brian McKay
####################################

# Clean up enviroment
rm(list=ls())
if(!is.null(names(sessionInfo()$otherPkgs))){
  lapply(paste('package:',names(sessionInfo()$otherPkgs),sep=""),detach,character.only=TRUE,unload=TRUE)}

# loading required packages
if (require('tidyverse')==FALSE) {install.packages('tidyverse', repos="https://cran.rstudio.com"); require(tidyverse);}

# Don't need the bookdown package now but is required for the included Markdown files so we will just install it now.
if (require('bookdown')==FALSE) {install.packages('bookdown', repos="https://cran.rstudio.com"); require(bookdown);}

# Load Data Merged Data Set  
#####
dat<-readRDS("1 Anonymized Data/Data.Rda")

# This analysis requires data from two data sets
# The "fieldnotes.csv" dataset contains the variables collected at the time of registration
# This includes self reported activity level and symptoms
# The "temps.csv" has the temp of the pateint recorded at the clinic 
# This is generally data from the day after self-reported data is collected
# They have already been merged into the DatRaw.Rda file so now I will select the observations and variables I need


###########################
# CLEANING UP VARIABLES
dat.2<-dat

# making a factor version of the activity levels varaible
dat.2$PtQ.URI.24ActivityImpactF<-as.factor(as.character(dat.2$PtQ.URI.24ActivityImpact))

summary(dat.2$PtQ.URI.24ActivityImpactF)

# fixing the order of the factor levels
dat.2$PtQ.URI.24ActivityImpactF<-factor(dat.2$PtQ.URI.24ActivityImpactF, levels =c("0","1","2","3","4","5","6","7","8","9","10"))


# need to create the right order for factor varables 

# Myalgia
summary(dat.2$PtQ.URI.Intensity.Myalgia)
dat.2$PtQ.URI.Intensity.Myalgia<-factor(dat.2$PtQ.URI.Intensity.Myalgia, levels =c("None","Mild","Moderate","Severe"))

# Asthenia
summary(dat.2$PtQ.URI.Intensity.Asthenia)
dat.2$PtQ.URI.Intensity.Asthenia<-factor(dat.2$PtQ.URI.Intensity.Asthenia, levels =c("None","Mild","Moderate","Severe")) 

# Cough
summary(dat.2$PtQ.URI.Intensity.Cough)
dat.2$PtQ.URI.Intensity.Cough<-factor(dat.2$PtQ.URI.Intensity.Cough, levels =c("None","Mild","Moderate","Severe")) 



# Changing variable names to make them more clear 
dat.3<-dat.2

# Activity level numeric
dat.3$ActivityLevel<-dat.3$PtQ.URI.24ActivityImpact
dat.3$PtQ.URI.24ActivityImpact<-NULL

# Activity level factor
dat.3$ActivityLevelF<-dat.3$PtQ.URI.24ActivityImpactF
dat.3$PtQ.URI.24ActivityImpactF<-NULL

# Activity level high low factor (split at median)
# 0-4 is low and 5-10 is high
dat.3$ActivityLevelHL<-findInterval(dat.3$ActivityLevel,c(median(dat.3$ActivityLevel)))
dat.3$ActivityLevelHL<-as.factor(dat.3$ActivityLevelHL)
summary(dat.3$ActivityLevelHL)


# Adenopathy or swollen lymph nodes
dat.3$SwollenLymphNodes<-dat.3$PtQ.URI.Adenopathy
dat.3$PtQ.URI.Adenopathy<-NULL

# Flu shot self reported by students 
dat.3$FluShot<-dat.3$PtQ.URI.AnnualFluShotPtEntered
dat.3$PtQ.URI.AnnualFluShotPtEntered<-NULL

# Chest cogestion
dat.3$ChestCongestion<-dat.3$PtQ.URI.ChestCongestion
dat.3$PtQ.URI.ChestCongestion<-NULL

# Chills and sweats
dat.3$ChillsSweats<-dat.3$PtQ.URI.ChillsSweats
dat.3$PtQ.URI.ChillsSweats<-NULL

# Nasal congestion 
dat.3$NasalCongestion<-dat.3$PtQ.URI.Congested
dat.3$PtQ.URI.Congested<-NULL

# Cough
dat.3$CoughYN<-dat.3$PtQ.URI.Cough
dat.3$PtQ.URI.Cough<-NULL

# Sneeze
dat.3$Sneeze<-dat.3$PtQ.URI.Sneeze
dat.3$PtQ.URI.Sneeze<-NULL

# Duration of illness 
dat.3$DurationOfIllness<-dat.3$PtQ.URI.DaysDuration
dat.3$PtQ.URI.DaysDuration<-NULL

# Fatigue
dat.3$Fatigue<-dat.3$PtQ.URI.FAtigue
dat.3$PtQ.URI.FAtigue<-NULL

# Subjective Fever (patient asked if they feel like they have a fever)
dat.3$SubjectiveFever<-dat.3$PtQ.URI.Fever
dat.3$PtQ.URI.Fever<-NULL

# HA is Head ache 
dat.3$Headache<-dat.3$PtQ.URI.HA
dat.3$PtQ.URI.HA<-NULL

# Asthenia (Weakness or lack of energy)
dat.3$Weakness<-dat.3$PtQ.URI.Intensity.Asthenia
dat.3$PtQ.URI.Intensity.Asthenia<-NULL
#also making a yes no version 
dat.3$WeaknessYN<-plyr::revalue(dat.3$Weakness, c("None"="No", "Mild"="Yes", "Moderate"="Yes", "Severe"="Yes"))

# Cough intensity
dat.3$CoughIntensity<-dat.3$PtQ.URI.Intensity.Cough
dat.3$PtQ.URI.Intensity.Cough<-NULL

# Myalgia or body pain 
dat.3$Myalgia<-dat.3$PtQ.URI.Intensity.Myalgia
dat.3$PtQ.URI.Intensity.Myalgia<-NULL
 #also making a yes no version 
dat.3$MyalgiaYN<-plyr::revalue(dat.3$Myalgia, c("None"="No", "Mild"="Yes", "Moderate"="Yes", "Severe"="Yes"))

# Rhinorrhea or Runny nose
dat.3$RunnyNose<-dat.3$PtQ.URI.Rhinorrhea
dat.3$PtQ.URI.Rhinorrhea<-NULL

# AbdPain is abdominal pain 
dat.3$AbPain<-dat.3$PtQ.URI.AbdPain
dat.3$PtQ.URI.AbdPain<-NULL

# Chest pain is pain in the chest
dat.3$ChestPain<-dat.3$PtQ.URI.ChestPain
dat.3$PtQ.URI.ChestPain<-NULL

# Diarrhea
dat.3$Diarrhea<-dat.3$PtQ.URI.Diarrhea
dat.3$PtQ.URI.Diarrhea<-NULL

# EyePn is Eye pain 
dat.3$EyePn<-dat.3$PtQ.URI.EyePn
dat.3$PtQ.URI.EyePn<-NULL

# Insomnia is the can't sleep 
dat.3$Insomnia<-dat.3$PtQ.URI.Insomnia
dat.3$PtQ.URI.Insomnia<-NULL

# Itchy Eyes
dat.3$ItchyEye<-dat.3$PtQ.URI.ItchyEye
dat.3$PtQ.URI.ItchyEye<-NULL

# Nausea feeling like you are going to be sick 
dat.3$Nausea<-dat.3$PtQ.URI.Nausea
dat.3$PtQ.URI.Nausea<-NULL

# Otalgia is ear pain 
dat.3$EarPn<-dat.3$PtQ.URI.Otalgia
dat.3$PtQ.URI.Otalgia<-NULL

# CantHear is hearing loss
dat.3$Hearing<-dat.3$PtQ.URI.CantHear
dat.3$PtQ.URI.CantHear<-NULL

# Pharyngitis is throat pain 
dat.3$Pharyngitis<-dat.3$PtQ.URI.Pharyngitis
dat.3$PtQ.URI.Pharyngitis<-NULL

# SOB is shortness of breath
dat.3$Breathless<-dat.3$PtQ.URI.SOB
dat.3$PtQ.URI.SOB<-NULL

# Toothpn is tooth pain 
dat.3$ToothPn<-dat.3$PtQ.URI.ToothPn
dat.3$PtQ.URI.ToothPn<-NULL

# Vision is blurred vision 
dat.3$Vision<-dat.3$PtQ.URI.Vision
dat.3$PtQ.URI.Vision<-NULL

# Vomit
dat.3$Vomit<-dat.3$PtQ.URI.Vomit
dat.3$PtQ.URI.Vomit<-NULL

# Wheezing 
dat.3$Wheeze<-dat.3$PtQ.URI.Wheeze
dat.3$PtQ.URI.Wheeze<-NULL

# temp taken at by nurse at office 
dat.3$BodyTemp<-dat.3$temp1
dat.3$temp1<-NULL

# Rapid antigen flu A test 
dat.3$RapidFluA<-dat.3$FLU.A.ANTIGEN
dat.3$FLU.A.ANTIGEN<-NULL

# Rapid antigen flu B test
dat.3$RapidFluB<-dat.3$FLU.B.ANTIGEN
dat.3$FLU.B.ANTIGEN<-NULL

# Rapid PCR flu A test
dat.3$PCRFluA<-dat.3$Flu.A.PCR
dat.3$Flu.A.PCR<-NULL

# Rapid PCR flu B test
dat.3$PCRFluB<-dat.3$Flu.B.PCR
dat.3$Flu.B.PCR<-NULL


# Create new variable called TransScore it will be 0-3 focusing on the transmission related symptoms
# Transmission Max score will be made up of Cough, Sneeze, RunnyNose, Nasal congestion, Chest congestion

# quickly make some logical variables
dat.3$hasCough<-dat.3$CoughYN=="Yes"
dat.3$hasSneeze<-dat.3$Sneeze=="Yes"
dat.3$hasRunnyNose<-dat.3$RunnyNose=="Yes"
dat.3$hasNasalCongestion<-dat.3$NasalCongestion=="Yes"
dat.3$hasChestCongestion<-dat.3$ChestCongestion=="Yes"

# add up the scores for PCR and Rapid
dat.3$TransScore<-dat.3$hasSneeze+dat.3$hasRunnyNose+dat.3$hasNasalCongestion+dat.3$hasChestCongestion


# Score if empirical diagnosis is included (Any)
dat.3$TransScoreSM<-dat.3$hasCough+dat.3$hasSneeze+dat.3$hasRunnyNose+dat.3$hasNasalCongestion+dat.3$hasChestCongestion

# keeping one as numeric creating new one that is a factor
dat.3$TransScoreF<-as.factor(dat.3$TransScore)
dat.3$TransScoreSMF<-as.factor(dat.3$TransScoreSM)


# Making a Hi / Lo version of the transmission score

dat.3$TransScoreHL<-fct_collapse(dat.3$TransScoreF, Low = c("0","1","2"), High =c("3","4"))


# Create new variable called ImpactScore it will be 0-3 focusing on the symptoms associated with "Feeling Bad"
# Impact on behavoir Max score will be made up of ChillsSweats, Fatigue, SubjectiveFever, Headache, Weakness, Myalgia, Swollen Lymph Nodes.

# Logical versions of the symptoms that will make up the score 

dat.3$hasSubjectiveFever<-dat.3$SubjectiveFever=="Yes"
dat.3$hasChillsSweats<-dat.3$ChillsSweats=="Yes"
dat.3$hasMyalgiaYN<-dat.3$MyalgiaYN=="Yes"
dat.3$hasWeaknessYN<-dat.3$WeaknessYN=="Yes"
dat.3$hasHeadache<-dat.3$Headache=="Yes"
dat.3$hasFatigue<-dat.3$Fatigue=="Yes"
dat.3$hasInsomnia<-dat.3$Insomnia =="Yes"
dat.3$hasBreathless<-dat.3$Breathless =="Yes"
dat.3$hasWheeze<-dat.3$Wheeze =="Yes"
dat.3$hasChestPain<-dat.3$ChestPain =="Yes"
dat.3$hasPharyngitis<-dat.3$Pharyngitis =="Yes"
dat.3$hasAbPain<-dat.3$AbPain =="Yes"
dat.3$hasDiarrhea<-dat.3$Diarrhea =="Yes"
dat.3$hasNausea<-dat.3$Nausea =="Yes"
dat.3$hasVomit<-dat.3$Vomit =="Yes"
dat.3$hasEarPn<-dat.3$EarPn =="Yes"
dat.3$hasToothPn<-dat.3$ToothPn =="Yes"
dat.3$hasEyePn<-dat.3$EyePn =="Yes"
dat.3$hasItchyEye<-dat.3$ItchyEye =="Yes"
dat.3$hasSwollenLymphNodes<-dat.3$SwollenLymphNodes=="Yes"


# Add up the score for PCR and Rapid Dx 
dat.3$ImpactScore<-dat.3$hasSubjectiveFever+dat.3$hasChillsSweats+
                    dat.3$hasMyalgiaYN+dat.3$hasHeadache+dat.3$hasFatigue+
                    dat.3$hasInsomnia+dat.3$hasBreathless+dat.3$hasWheeze+
                    dat.3$hasChestPain+dat.3$hasPharyngitis+dat.3$hasAbPain+
                    dat.3$hasDiarrhea+dat.3$hasNausea+dat.3$hasVomit+
                    dat.3$hasEarPn+dat.3$hasToothPn+
                    dat.3$hasEyePn+dat.3$hasItchyEye+dat.3$hasSwollenLymphNodes

# Score if empirical diagnosis method is included (Any)
dat.3$ImpactScoreSM<-dat.3$hasSubjectiveFever+dat.3$hasChillsSweats+
                      dat.3$hasMyalgiaYN+dat.3$hasHeadache+dat.3$hasFatigue+
                      dat.3$hasInsomnia+dat.3$hasBreathless+dat.3$hasWheeze+
                      dat.3$hasChestPain+dat.3$hasPharyngitis+dat.3$hasAbPain+
                      dat.3$hasDiarrhea+dat.3$hasNausea+dat.3$hasVomit+
                      dat.3$hasEarPn+dat.3$hasToothPn+dat.3$hasWeaknessYN+
                      dat.3$hasEyePn+dat.3$hasItchyEye+dat.3$hasSwollenLymphNodes

# Score if correlation cut off is .75
dat.3$ImpactScoreCC<-dat.3$hasSubjectiveFever+dat.3$hasMyalgiaYN+
                    dat.3$hasHeadache+dat.3$hasInsomnia+
                    dat.3$hasBreathless+dat.3$hasWheeze+
                    dat.3$hasChestPain+dat.3$hasAbPain+
                    dat.3$hasDiarrhea+dat.3$hasNausea+
                    dat.3$hasEarPn+dat.3$hasItchyEye+
                    dat.3$hasSwollenLymphNodes

# keeping one as numeric creating new one that is a factor
dat.3$ImpactScoreF<-as.factor(dat.3$ImpactScore)
dat.3$ImpactScoreSMF<-as.factor(dat.3$ImpactScoreSM)
dat.3$ImpactScoreCCF<-as.factor(dat.3$ImpactScoreCC)


######
#Creating a total symptom score just to have it 

# Add up everything 
dat.3$TotalSymp<-(dat.3$hasSubjectiveFever+dat.3$hasChillsSweats+dat.3$hasMyalgiaYN+ 
                  dat.3$hasWeaknessYN+dat.3$hasHeadache+dat.3$hasFatigue+
                  dat.3$hasInsomnia+dat.3$hasBreathless+dat.3$hasWheeze+
                  dat.3$hasChestPain+dat.3$hasPharyngitis+dat.3$hasAbPain+
                  dat.3$hasDiarrhea+dat.3$hasNausea+dat.3$hasVomit+
                  dat.3$hasEarPn+dat.3$hasToothPn+
                  dat.3$hasEyePn+dat.3$hasItchyEye+dat.3$hasSwollenLymphNodes+
                  dat.3$hasCough+dat.3$hasSneeze+dat.3$hasRunnyNose+
                  dat.3$hasNasalCongestion+dat.3$hasChestCongestion)

dat.3$TotalSympF<-as.factor(dat.3$TotalSymp)

# get rid of the logical versions 
dat.3$hasSubjectiveFever<-NULL
dat.3$hasChillsSweats<-NULL
dat.3$hasMyalgiaYN<-NULL 
dat.3$hasWeaknessYN<-NULL
dat.3$hasHeadache<-NULL
dat.3$hasFatigue<-NULL
dat.3$hasInsomnia<-NULL
dat.3$hasBreathless<-NULL
dat.3$hasWheeze<-NULL
dat.3$hasChestPain<-NULL
dat.3$hasPharyngitis<-NULL
dat.3$hasAbPain<-NULL
dat.3$hasDiarrhea<-NULL
dat.3$hasNausea<-NULL
dat.3$hasVomit<-NULL
dat.3$hasEarPn<-NULL
dat.3$hasHearing<-NULL
dat.3$hasToothPn<-NULL
dat.3$hasEyePn<-NULL
dat.3$hasItchyEye<-NULL
dat.3$hasSwollenLymphNodes<-NULL
dat.3$hasCough<-NULL
dat.3$hasSneeze<-NULL
dat.3$hasRunnyNose<-NULL
dat.3$hasNasalCongestion<-NULL
dat.3$hasChestCongestion<-NULL


######
# Save cleaned data for multiple univariate analysis
# dat.2 contains all 2385 students who reported a self-rated activity level 
# Rename data to something meaningful

SympAct<-dat.3

#Labels for variables with better names for the final table and figures
var_Label_List<-list(CoughYN = "Cough",
                     Sneeze = "Sneeze",
                     RunnyNose ="Runny Nose",
                     SubjectiveFever = "Subjective Fever",
                     ChillsSweats = "Chills/Sweats",
                     Fatigue = "Fatigue",
                     Headache = "Headache",
                     WeaknessYN = "Weakness",
                     MyalgiaYN = "Myalgia",
                     TransScoreF = "Infectiousness Score",
                     ImpactScoreF = "Morbidity Score",
                     ActivityLevel = "Activity Level",
                     SwollenLymphNodes = "Swollen Lymph Nodes",
                     ChestCongestion = "Chest Congestion",
                     NasalCongestion = "Nasal Congestion",
                     AbPain = "Abdominal Pain",
                     ChestPain = "Chest Pain",
                     EyePn = "Eye Pain",
                     Insomnia = "Sleeplessness",
                     ItchyEye = "Itchy Eyes",
                     EarPn = "Ear Pain",
                     Hearing = "Loss of Hearing",
                     Pharyngitis = "Sore Throat",
                     Breathless = "Breathlessness",
                     ToothPn = "Tooth Pain",
                     Vision = "Blurred Vision",
                     Vomit = "Vomiting",
                     Wheeze = "Wheezing")

labelled::var_label(SympAct)<-var_Label_List


str(SympAct)


# Data is stratified by diagnosis

## This dataset contains all the individuals with a lab test confirmed for FLU
SympAct_Lab_Pos<-filter(SympAct,RapidFluA %in% c("Positive for Influenza A") |  RapidFluB %in% c("Positive for Influenza B")
                        | PCRFluA %in% c(" Influenza A Detected") |  PCRFluB %in% c(" Influenza B Detected"))
# need to drop empty levels for the analysis so new version of factor variable will be created
SympAct_Lab_Pos$ImpactScoreFD<-droplevels(SympAct_Lab_Pos$ImpactScoreF)
# empty levels dropped for Lab DX for the .75 correlation cut off version of the score in SM 
SympAct_Lab_Pos$ImpactScoreCCFD<-droplevels(SympAct_Lab_Pos$ImpactScoreCCF)

## This dataset contians all the possible diagnosis (PCR, Rapid antigen, or clinical)
SympAct_Any_Pos<-filter(SympAct,RapidFluA %in% c("Positive for Influenza A") |  RapidFluB %in% c("Positive for Influenza B")
                                 | PCRFluA %in% c(" Influenza A Detected") |  PCRFluB %in% c(" Influenza B Detected")
                                 | str_detect(DxName1,"Influenza") | str_detect(DxName2,"Influenza") | str_detect(DxName3,"Influenza") 
                                 | str_detect(DxName4,"Influenza") | str_detect(DxName5,"Influenza"))
# empty levels dropped for the any dx version of the score in SM 
SympAct_Any_Pos$ImpactScoreSMFD<-droplevels(SympAct_Any_Pos$ImpactScoreSMF)

# for what ever reason variable labels are not making it throught the subsetting process 
labelled::var_label(SympAct_Any_Pos)<-var_Label_List
labelled::var_label(SympAct_Lab_Pos)<-var_Label_List

# Clean up the global enviroment 
rm(list=setdiff(ls(),c("SympAct","SympAct_Any_Pos","SympAct_Lab_Pos")))

# Check for symptoms with a prevalance of 5% or less
summary(SympAct_Any_Pos)# Hearing, Vision 
summary(SympAct_Lab_Pos)# Hearing, Vision 

# Save global enviroment 
saveRDS(SympAct, file = "3 Clean Data/SympAct.Rda")

saveRDS(SympAct_Any_Pos, file = "3 Clean Data/SympAct_Any_Pos.Rda")

saveRDS(SympAct_Lab_Pos, file = "3 Clean Data/SympAct_Lab_Pos.Rda")

