###################
# Plots For Manuscript and Supplement
# Brian McKay 
# 3-23-19
####################

#Clean up global enviroment
rm(list=ls())

#Remove any packages that might have conflicts with the required packages
if(!is.null(names(sessionInfo()$otherPkgs))){
  lapply(paste('package:',names(sessionInfo()$otherPkgs),sep=""),detach,character.only=TRUE,unload=TRUE)}

#Load or install required packages ####
# For figures 
if (require('ggplot2')==FALSE) {install.packages('ggplot2', repos="https://cran.rstudio.com"); require(ggplot2)}
if (require('ggcorrplot')==FALSE) {install.packages('ggcorrplot', repos="https://cran.rstudio.com"); require(ggcorrplot)}
if (require('gridExtra')==FALSE) {install.packages('gridExtra', repos="https://cran.rstudio.com"); require(gridExtra)}


# Analysis and Data Wrangling
if (require('tidyverse')==FALSE) {install.packages('tidyverse', repos="https://cran.rstudio.com"); require(tidyverse);}
if (require('reshape2')==FALSE) {install.packages('reshape2', repos="https://cran.rstudio.com"); require(reshape2)}
if (require('DescTools')==FALSE) {install.packages('DescTools', repos="https://cran.rstudio.com"); require(DescTools)}



#Load data from "Data Cleaning.R" script in the "2 Data Cleaning Script" folder ####
SympAct_Lab_Pos<-readRDS("3 Clean Data/SympAct_Lab_Pos.Rda")
SympAct_Any_Pos<-readRDS("3 Clean Data/SympAct_Any_Pos.Rda")


#Correlation of Symptoms Variables #####
# cat(paste(shQuote(colnames(SympAct_Any_Pos)),collapse = ", ")) 




#### For Patients with a lab test

#Calculate Yule's Q for every pair
SympCorT<-PairApply(SympAct_Lab_Pos[,c( "CoughYN", "ChestCongestion", "Sneeze", "RunnyNose", "NasalCongestion")], 
                    YuleQ, symmetric = TRUE)

SympCorI<-PairApply(SympAct_Lab_Pos[,c( "SubjectiveFever", "ChillsSweats", "MyalgiaYN", "WeaknessYN", "Headache", 
                                        "Fatigue", "Insomnia", "Breathless", "Wheeze", "ChestPain", "Pharyngitis", 
                                        "AbPain", "Diarrhea", "Nausea", "Vomit",  "EarPn", "ToothPn", 
                                        "EyePn", "ItchyEye", "SwollenLymphNodes")], 
                    YuleQ, symmetric = TRUE)


#Make a Plot of infectiousness correlation Co
graphics.off(); #close all graphics windows

ww=8; wh=2/3*ww; #window size, can be adjusted

windows(width=ww, height=wh) #for windows: opens window of the specified dimensions


ggcorrplot(SympCorI, lab = T, lab_col = "white", lab_size = 2, tl.srt = 75, colors = c("red", "white","blue"))


dev.print(device=tiff,filename ="5 Results/Figures/CorLabI.tiff",width=ww, height=wh, units="in",pointsize = 12, compression =c("lzw"), res=320)

dev.off()


#Make a Plot of morbidity correlation Co
graphics.off(); #close all graphics windows

ww=8; wh=2/3*ww; #window size, can be adjusted

windows(width=ww, height=wh) #for windows: opens window of the specified dimensions


p1<-ggcorrplot(SympCorT,lab = T, lab_col = "white", colors = c("red", "white","blue"))


ggsave(file = "5 Results/Figures/CorLabT.tiff",p1, dpi=320, compression = "lzw")

dev.off()




#Generalized plot to convey understanding to reader #####

# This function describes the transmission related symptoms
sigmoidTS <- function(x) {
  1 / (1 + exp(-(10*x)+3) +.15)
}

# This function describes the contact rate
sigmoidCR <- function(x) {
  1 / (1 + exp((9*x)-4)+.30)
}

# # This function describes the morbidity symptoms
# expoMS <- function(x) {
#   exp(1.9*x-7)
# }
#lines(x,yMS, col="brown", lty=3, lwd=3)
#yMS<- expoMS(x)

#  X Values 
x<-seq(0,1.5,0.001)

# Corresponding Y values
yTS<-sigmoidTS(x)

yCR<-sigmoidCR(x)

# Total transmission potential
TS_CR<-yTS*yCR

# Mean Morbidity Score for each level of activity
SympAct_Lab_Pos$ActivityLevelB<-(SympAct_Lab_Pos$ActivityLevel/max(SympAct_Lab_Pos$ActivityLevel))

medActivity<-SympAct_Lab_Pos %>% 
  group_by(ImpactScoreF) %>%
  summarise_at(vars(ActivityLevelB), list(~mean(., na.rm=TRUE)))

# Mean Transmission Score for each level of activity
SympAct_Lab_Pos$TransScoreB<-(SympAct_Lab_Pos$TransScore/max(SympAct_Lab_Pos$TransScore))

medTsymp<-SympAct_Lab_Pos %>% 
  group_by(ImpactScoreF) %>%
  summarise_at(vars(TransScoreB), list(~mean(., na.rm=TRUE)))

graphics.off(); #close all graphics windows
 
ww=8; wh=2/3*ww; #window size, can be adjusted
 
windows(width=ww, height=wh) #for windows: opens window of the specified dimensions

plot(x, yTS, axes = F, xlab= "", ylab = "", ylim=c(-0.25,1.5), type = "l", lty=1, lwd=2)
lines(x, yCR, lty=2, lwd=2)
lines(x, TS_CR, lty=4, lwd=2)
#points()
axis(side = 2, pos = 0, tck=0, labels = F)
axis(side = 1, pos = 0, tck=0, labels = F)
arrows(1.18, -0.2, 1.45, -0.2, xpd = TRUE)
text(x=.95, y=-0.2, label="Increasing Virulence (v)")
legend("topright", inset = .05, title = "Lines", 
       c("Per-Contact Transmission Potential (p)","Contact Rate (c)", "Total Transmission Potential (T)"), 
       cex = 0.8, lty = c(1,2,4), lwd=c(1,1,1))
legend("topleft", inset = .05, title = "Points", 
       c("Mean Activity", "Mean Infectiousness Score" ), 
       cex = .95, pch=c(5,1))
par(new=T)
plot(y=medActivity$ActivityLevelB, x=seq(0.25,0.7,length=length(medActivity$ActivityLevelB)), xlim = c(0,1.5), ylim=c(-0.25,1.5), axes=F, ylab="", xlab="", pch= 5, cex=1.5, lwd=3)
text(x=.45, y=-0.1, label = "Mobidity Score" )
axis(side = 1, at =seq(0.25,0.7,length=16), labels = c(2:17))
par(new=T)
plot(y=medTsymp$TransScoreB, x=seq(0.25,0.7,length=length(medActivity$ActivityLevelB)), xlim = c(0,1.5), ylim=c(-0.2,1.5), axes=F, ylab="", xlab="", pch= 1, cex=1.5, lwd=2)

dev.print(device=tiff,filename ="5 Results/Figures/ConceptFig.tiff",width=ww, height=wh, units="in",pointsize = 12, compression =c("lzw"), res=300)

dev.off()


#Setting up ggplot Themes ####
#Don't need the legend for right now
#Need text to be smaller
manuscriptTheme <- theme(plot.title = element_text(size = 14, face = "bold", hjust = 0.5), 
                         plot.subtitle = element_text(size = 14, face = "bold"),
                         axis.title.x = element_text(size = 16, face = "bold"),
                         axis.title.y = element_text(size = 16, face = "bold"),
                         axis.text = element_text(size = 14),
                         legend.position = "none",
                         panel.background = element_rect(fill = "white", color = "black"),
                         panel.grid.major = element_blank(),
                         panel.grid.minor = element_blank())

SMTheme <- theme(plot.title = element_text(size = 12, face = "bold", hjust = 0.5), 
                         plot.subtitle = element_text(size = 12, face = "bold"),
                         axis.title.x = element_text(size = 14, face = "bold"),
                         axis.title.y = element_text(size = 14, face = "bold"),
                         axis.text = element_text(size = 12),
                         panel.background = element_rect(fill = "white", color = "black"),
                         panel.grid.major = element_blank(),
                         panel.grid.minor = element_blank())




#Plot labels with number of observations for each factor level ####

#Any DX
##Transmission
TransAnytab<-table(SympAct_Any_Pos$TransScoreSMF)
TransAny_xlabs<-paste0(c(seq(0,to=length(TransAnytab), by=1))," (n=", TransAnytab, ")")
##Impact
ImpactAnytab<-table(SympAct_Any_Pos$ImpactScoreSMF)
ImpactAny_xlabs<-paste0(c(seq(0,to=length(ImpactAnytab), by=1))," (n=", ImpactAnytab, ")")

#Lab DX
##Transmission
TransLabtab<-table(SympAct_Lab_Pos$TransScoreF)
TransLab_xlabs<-paste0(c(seq(0,to=length(TransLabtab), by=1))," (n=", TransLabtab, ")")
##Impact
ImpactLabtab<-table(SympAct_Lab_Pos$ImpactScoreF)
ImpactLab_xlabs<-paste0(c(seq(0,to=length(ImpactLabtab), by=1))," (n=", ImpactLabtab, ")")
##Impact using 0.75
ImpactLabCCtab<-table(SympAct_Lab_Pos$ImpactScoreCCF)
ImpactLabCC_xlabs<-paste0(c(seq(0,to=length(ImpactLabCCtab), by=1))," (n=", ImpactLabCCtab, ")")



#Set window size for the two following figures ####
graphics.off(); #close all graphics windows

ww=8; wh=2/3*ww; #window size, can be adjusted

windows(width=ww, height=wh) #for windows: opens window of the specified dimensions

#ggplots for Manuscript ####

# Barchart of infectiousness score
pA<-ggplot(SympAct_Lab_Pos, aes(TransScore))+ 
  geom_bar()+
  scale_x_continuous(breaks=0:5)+
  geom_text(stat='count', aes(label=..count..), vjust=-.60)+
  labs(x="Infectiousness Score", y="Patient Count")+
  manuscriptTheme
ggsave(file = "5 Results/Figures/InfectScoreLabBarChart.tiff",pA, dpi=320, compression = "lzw")

# Barchart of morbidity score
pB<-ggplot(SympAct_Lab_Pos, aes(ImpactScore))+ 
  geom_bar()+
  scale_x_continuous(limits = c(0,19),breaks=0:19)+
  geom_text(stat='count', aes(label=..count..), vjust=-.60)+
  labs(x="Morbidity Score", y="Patient Count")+
  manuscriptTheme
ggsave(file = "5 Results/Figures/MorbScoreLabBarChart.tiff",pB, dpi=320, compression = "lzw")


#Set window size for the two combined figures ####
graphics.off(); #close all graphics windows

ww=9; wh=2/3*ww; #window size, can be adjusted

windows(width=ww, height=wh) #for windows: opens window of the specified dimensions

# Make a combined figure
pA<-pA+ggtitle("A")
pB<-pB+ggtitle("B")

plotG <- grid.arrange(pA, pB, ncol = 2, widths=1:2)

ggsave(file="5 Results/Figures/IandMScoresLabBarChart.tiff", plot=plotG, dpi = 320, compression = "lzw")


#Set window size for all the following figures ####
graphics.off(); #close all graphics windows

ww=8; wh=2/3*ww; #window size, can be adjusted

windows(width=ww, height=wh) #for windows: opens window of the specified dimensions


# Barchart of activity for manuscript
p1<-ggplot(SympAct_Lab_Pos, aes(ActivityLevel))+ 
  geom_bar()+
  scale_x_continuous(breaks=0:10)+
  geom_text(stat='count', aes(label=..count..), vjust=-.75)+
  labs(x="Activity Level", y="Patient Count")+
  manuscriptTheme
ggsave(file = "5 Results/Figures/ActivityLabBarChart.tiff",p1, dpi=320, compression = "lzw")


# Lab flu Dx TransScore and ActivityLevel for manuscript
p1<- ggplot(SympAct_Lab_Pos, aes(x=TransScoreF, y=ActivityLevel))+
  geom_boxplot()+
  stat_smooth(method = 'lm', se=T, aes(group=1))+
  geom_jitter(height = 0, width = .3, size = 1, shape=1)+
  stat_summary(fun.y = mean, geom = "point", shape = 18, color="red", size=5)+
  scale_y_continuous(limits = c(0,10), breaks=seq(from=0, to=10, by=2))+
  scale_x_discrete(breaks=0:(length(TransLab_xlabs)-1), labels=TransLab_xlabs)+
  labs(x="Infectiousness Score", y="Activity Level")+
  manuscriptTheme
ggsave(file = "5 Results/Figures/ActivityVSTransScore_Lab.tiff",p1, dpi=320, compression = "lzw")

# Lab flu Dx ImpactScore and ActivityLevel for manuscript
p1<- ggplot(SympAct_Lab_Pos, aes(x=ImpactScoreF, y=ActivityLevel))+
  geom_boxplot()+
  stat_smooth(method = 'lm', se=T, aes(group=1))+
  geom_jitter(height = 0, width = .3, size = 1, shape=1)+
  stat_summary(fun.y = mean, geom = "point", shape = 18, color="red", size=5)+
  scale_y_continuous(limits = c(0,10), breaks=seq(from=0, to=10, by=2))+
  scale_x_discrete(breaks=0:(length(ImpactLab_xlabs)-1), labels=ImpactLab_xlabs)+
  labs(x="Morbidity Score", y="Activity Level")+
  manuscriptTheme+
  theme(axis.text.x = element_text(size = 12, angle = 45, hjust = 0.75, vjust = 0.85))
ggsave(file = "5 Results/Figures/ActivityVSImpactScore_Lab.tiff",p1, dpi=320, compression = "lzw")

# Lab flu Dx ImpactScore and TransScore for manuscript
p1<-ggplot(SympAct_Lab_Pos, aes(x=ImpactScoreF, y=TransScore))+
  geom_boxplot()+
  stat_smooth(method = 'lm', se=T, aes(group=1))+
  geom_jitter(height = 0, width = .3, size = 1, shape=1)+
  stat_summary(fun.y = mean, geom = "point", shape = 18, color="red", size=5)+
  scale_x_discrete(breaks=0:(length(ImpactLab_xlabs)-1), labels=ImpactLab_xlabs)+
  labs(y="Infectiousness Score", x="Morbidity Score")+
  manuscriptTheme+
  theme(axis.text.x = element_text(size = 12, angle = 45, hjust = 0.75, vjust = 0.85))

ggsave(file = "5 Results/Figures/TransScoreVSImpactScore_Lab.tiff",p1, dpi=320, compression = "lzw")




# Plots for SM ####

### Lab diagnosis using 0.75 instead of 0.9

# Barchart of morbidity score created using 0.75
p1<-ggplot(SympAct_Lab_Pos, aes(ImpactScoreCC))+ 
  geom_bar()+
  scale_x_continuous(limits = c(0,13),breaks=0:13)+
  geom_text(stat='count', aes(label=..count..), vjust=-.60)+
  labs(x="Morbidity Score", y="Patient Count")+
  manuscriptTheme
ggsave(file = "5 Results/Figures/75MorbScoreLabBarChart.tiff",p1, dpi=320, compression = "lzw")

# Lab flu Dx ImpactScore and ActivityLevel using 0.75
p1<- ggplot(SympAct_Lab_Pos, aes(x=ImpactScoreCCF, y=ActivityLevel))+
  geom_boxplot()+
  stat_smooth(method = 'lm', se=T, aes(group=1))+
  geom_jitter(height = 0, width = .3, size = 1, shape=1)+
  stat_summary(fun.y = mean, geom = "point", shape = 18, color="red", size=5)+
  scale_y_continuous(limits = c(0,10), breaks=seq(from=0, to=10, by=2))+
  scale_x_discrete(breaks=0:(length(ImpactLabCC_xlabs)-1), labels=ImpactLabCC_xlabs)+
  labs(x="Morbidity Score", y="Activity Level")+
  manuscriptTheme+
  theme(axis.text.x = element_text(size = 12, angle = 45, hjust = 0.75, vjust = 0.85))
ggsave(file = "5 Results/Figures/75ActivityVSImpactScore_Lab.tiff",p1, dpi=320, compression = "lzw")

# Lab flu Dx ImpactScore and TransScore using 0.75
p1<-ggplot(SympAct_Lab_Pos, aes(x=ImpactScoreCCF, y=TransScore))+
  geom_boxplot()+
  stat_smooth(method = 'lm', se=T, aes(group=1))+
  geom_jitter(height = 0, width = .3, size = 1, shape=1)+
  stat_summary(fun.y = mean, geom = "point", shape = 18, color="red", size=5)+
  scale_x_discrete(breaks=0:(length(ImpactLabCC_xlabs)-1), labels=ImpactLabCC_xlabs)+
  labs(y="Infectiousness Score", x="Morbidity Score")+
  manuscriptTheme+
  theme(axis.text.x = element_text(size = 12, angle = 45, hjust = 0.75, vjust = 0.85))

ggsave(file = "5 Results/Figures/75TransScoreVSImpactScore_Lab.tiff",p1, dpi=320, compression = "lzw")

### For Any diagnosis 
### For ANY diagnosis (PCR, Rapid, or Empirically)
summary(SympAct_Any_Pos)

#Calculate Yule's Q for every pair
SympCorT<-PairApply(SympAct_Any_Pos[,c( "CoughYN", "ChestCongestion", "Sneeze", "RunnyNose", "NasalCongestion")],
                    YuleQ, symmetric = TRUE)

SympCorI<-PairApply(SympAct_Any_Pos[,c( "SubjectiveFever", "ChillsSweats", "MyalgiaYN", "WeaknessYN", "Headache",
                                        "Fatigue", "Insomnia", "Breathless", "Wheeze", "ChestPain", "Pharyngitis",
                                        "AbPain", "Diarrhea", "Nausea", "Vomit",  "EarPn", "ToothPn",
                                        "EyePn", "ItchyEye", "SwollenLymphNodes")],
                    YuleQ, symmetric = TRUE)


#Make a Plot of infectiousness correlation Cor for any dx
graphics.off(); #close all graphics windows

ww=8; wh=2/3*ww; #window size, can be adjusted

windows(width=ww, height=wh) #for windows: opens window of the specified dimensions

ggcorrplot(SympCorI, lab = T, lab_col = "white", lab_size = 2, tl.srt = 75, colors = c("red", "white","blue"))

dev.print(device=tiff,filename ="5 Results/Figures/CorAnyI.tiff",width=ww, height=wh, units="in",pointsize = 12, compression =c("lzw"), res=320)

dev.off()

#Make a Plot of morbidity correlation Cor for any dx
graphics.off(); #close all graphics windows

ww=8; wh=2/3*ww; #window size, can be adjusted

windows(width=ww, height=wh) #for windows: opens window of the specified dimensions

p1<-ggcorrplot(SympCorT,lab = T, lab_col = "white", colors = c("red", "white","blue"))

ggsave(file = "5 Results/Figures/CorAnyT.tiff",p1, dpi=320, compression = "lzw")

dev.off()


#Set window size for all the following figures ####
graphics.off(); #close all graphics windows

ww=8; wh=2/3*ww; #window size, can be adjusted

windows(width=ww, height=wh) #for windows: opens window of the specified dimensions


# Barchart of activity for Any Diagnosis
p1<-ggplot(SympAct_Any_Pos, aes(ActivityLevel))+
  geom_bar()+
  scale_x_continuous(breaks=0:10)+
  geom_text(stat='count', aes(label=..count..), vjust=-.75)+
  manuscriptTheme
ggsave(file = "5 Results/Figures/ActivityAnyBarChart.tiff",p1, dpi=320, compression = "lzw")

# Barchart of infectiousness score for Any Diagnosis
pA<-ggplot(SympAct_Any_Pos, aes(TransScoreSM))+
  geom_bar()+
  scale_x_continuous(breaks=0:5)+
  geom_text(stat='count', aes(label=..count..), vjust=-.60)+
  labs(x="Infectiousness Score", y="Patient Count")+
  manuscriptTheme
ggsave(file = "5 Results/Figures/InfectScoreAnyBarChart.tiff",pA, dpi=320, compression = "lzw")

# Barchart of morbidity score for Any Diagnosis
pB<-ggplot(SympAct_Any_Pos, aes(ImpactScoreSM))+
  geom_bar()+
  scale_x_continuous(limits = c(0,20) ,breaks=0:20)+
  geom_text(stat='count', aes(label=..count..), vjust=-.60)+
  labs(x="Morbidity Score", y="Patient Count")+
  manuscriptTheme
ggsave(file = "5 Results/Figures/MorbScoreAnyBarChart.tiff",pB, dpi=320, compression = "lzw")

#Set window size for the two combined figures ####
graphics.off(); #close all graphics windows

ww=9; wh=2/3*ww; #window size, can be adjusted

windows(width=ww, height=wh) #for windows: opens window of the specified dimensions

# Make a combined figure
pA<-pA+ggtitle("A")
pB<-pB+ggtitle("B")

plotG <- grid.arrange(pA, pB, ncol = 2, widths=1:2)

ggsave(file="5 Results/Figures/IandMScoresAnyBarChart.tiff", plot=plotG, dpi = 320, compression = "lzw")


#Set window size for all the following figures ####
graphics.off(); #close all graphics windows

ww=8; wh=2/3*ww; #window size, can be adjusted

windows(width=ww, height=wh) #for windows: opens window of the specified dimensions


# Any flu Dx TransScore and ActivityLevel
p1<- ggplot(SympAct_Any_Pos, aes(x=TransScoreSMF, y=ActivityLevel))+
  geom_boxplot()+
  stat_smooth(method = 'lm', se=T, aes(group=1))+
  geom_jitter(height = 0, width = .3, size = 1, shape=1)+
  stat_summary(fun.y = mean, geom = "point", shape = 18, color="red", size=5)+
  scale_y_continuous(limits = c(0,10), breaks=seq(from=0, to=10, by=2))+
  scale_x_discrete(breaks=0:(length(TransAny_xlabs)-1), labels=TransAny_xlabs)+
  labs(x="Infectiousness Score", y="Activity Level")+
  manuscriptTheme
ggsave(file = "5 Results/Figures/ActivityVSTransScore_Any.tiff",p1, dpi=320, compression = "lzw")

# Any flu Dx ImpactScore and ActivityLevel
p1<- ggplot(SympAct_Any_Pos, aes(x=ImpactScoreSMF, y=ActivityLevel))+
  geom_boxplot()+
  stat_smooth(method = 'lm', se=T, aes(group=1))+
  geom_jitter(height = 0, width = .3, size = 1, shape=1)+
  stat_summary(fun.y = mean, geom = "point", shape = 18, color="red", size=5)+
  scale_y_continuous(limits = c(0,10), breaks=seq(from=0, to=10, by=2))+
  scale_x_discrete(breaks=0:(length(ImpactAny_xlabs)-1), labels=ImpactAny_xlabs)+
  labs(x="Morbidity Score", y="Activity Level")+
  manuscriptTheme+
  theme(axis.text.x = element_text(size = 12, angle = 45, hjust = 0.75, vjust = 0.85))
ggsave(file = "5 Results/Figures/ActivityVSImpactScore_Any.tiff",p1, dpi=320, compression = "lzw")

# Any flu Dx ImpactScore and TransScore
p1<-ggplot(SympAct_Any_Pos, aes(x=ImpactScoreSMF, y=TransScoreSM))+
  geom_boxplot()+
  stat_smooth(method = 'lm', se=T, aes(group=1))+
  geom_jitter(height = 0, width = .3, size = 1, shape=1)+
  stat_summary(fun.y = mean, geom = "point", shape = 18, color="red", size=5)+
  scale_x_discrete(breaks=0:(length(ImpactAny_xlabs)-1), labels=ImpactAny_xlabs)+
  labs(y="Infectiousness Score", x="Morbidity Score")+
  manuscriptTheme+
  theme(axis.text.x = element_text(size = 12, angle = 45, hjust = 0.75, vjust = 0.85))

ggsave(file = "5 Results/Figures/TransScoreVSImpactScore_Any.tiff",p1, dpi=320, compression = "lzw")

