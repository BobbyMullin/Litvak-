# Load some important libraries that contain functions you might use
# Before you start, make sure these are downloaded and up-to-Year
library(ggplot2)
library(RColorBrewer)
library(gridExtra)
library(reshape2)
library(lubriYear)
library(plyr)
library(directlabels)
library(ggrepel)
#read in the csv source file
trapmassannual <- read.csv('Z:/eddyflux/Tower sites/All_Sites/Biomass_All_Sites/Litter_Biomass_All_Sites/Litter QC in R/Litter NPP Calculations/temporary file for Litter plot files/trapmassbyyear.csv')
#head(trapmassannual)
#unique(trapmassannual$Site)
#Jsav
Jsavlittertrapannual.plot <- ggplot(trapmassannual[trapmassannual$Site =="Jsav",], aes(x=Year, y=V1, group= Trap, colour= Trap)) + 
  geom_point(size=2, alpha=0.8) +
  geom_line(size=1.5, alpha=0.5) +
  xlab("Year") + ylab("Total Dry Mass (grams)") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) + 
  facet_grid(Transect~., scales = "free_y") +
  theme(legend.position = "none") 
direct.label(Jsavlittertrapannual.plot, list(last.bumpup, rot= 15, cex=0.5, hjust = 0, vjust = 0.5))

#Jsavlittertrapannual.plot

#Shrub
Shrublittertrapannual.plot <- ggplot(trapmassannual[trapmassannual$Site =="SHRUB",], aes(x=Year, y=V1, group= Trap, colour= Trap)) + 
  geom_point(size=2, alpha=0.8) +
  geom_line(size=1.5, alpha=0.5) +
  xlab("Year") + ylab("Total Dry Mass (grams)") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) + 
  facet_grid(Transect~., scales = "free_y") +
  theme(legend.position = "none") +
  xlim(2012, 2016 + .5)
direct.label(Shrublittertrapannual.plot, list(last.bumpup, rot= 0, cex=0.5, hjust = 0, vjust = 0.5))
#Shrublittertrapannual.plot

#PJControl
PJControllittertrapannual.plot <- ggplot(trapmassannual[trapmassannual$Site =="PJControl" & trapmassannual$Year != 2017,], aes(x=Year, y=V1, group= Trap, colour= Trap)) + 
  geom_point(size=2, alpha=0.8) +
  geom_line(size=1.5, alpha=0.5) +
  xlab("Year") + ylab("Total Dry Mass (grams)") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) + 
  facet_grid(Transect~., scales = "free_y") +
  theme(legend.position = "none") +
  xlim(2012, 2016 + .5)
direct.label(PJControllittertrapannual.plot, list(last.bumpup, rot= 0, cex=0.5, hjust = 0, vjust = 0.5))
#PJControllittertrapannual.plot

#PJGirdle
PJGirdlelittertrapannual.plot <- ggplot(trapmassannual[trapmassannual$Site =="PJGirdle" & trapmassannual$Year != 2017, ], aes(x=Year, y=V1, group= Trap, colour= Trap)) + 
  geom_point(size=2, alpha=0.8) +
  geom_line(size=1.5, alpha=0.5) +
  xlab("Year") + ylab("Total Dry Mass (grams)") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) + 
  facet_grid(Transect~., scales = "free_y") +
  theme(legend.position = "none") +
  xlim(2012, 2016 + .5)
direct.label(PJGirdlelittertrapannual.plot, list(last.bumpup, rot= 0, cex=0.5, hjust = 0, vjust = 0.5))
#PJGirdlelittertrapannual.plot

#PPINE
PPINElittertrapannual.plot <- ggplot(trapmassannual[trapmassannual$Site =="PPINE",], aes(x=Year, y=V1, group= Trap, colour= Trap)) + 
  geom_point(size=2, alpha=0.8) +
  geom_line(size=1.5, alpha=0.5) +
  xlab("Year") + ylab("Total Dry Mass (grams)") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) + 
  facet_grid(Transect~., scales = "free_y") +
  theme(legend.position = "none") 
direct.label(PPINElittertrapannual.plot, list(last.bumpup, rot= 15, cex=0.5, hjust = 0, vjust = 0.5)) 

#PPINElittertrapannual.plot

#MCON - Data set is only contains 2010? - needs to be confirmed
MCONlittertrapannual.plot <- ggplot(trapmassannual[trapmassannual$Site =="MCON",], aes(x=Year, y=V1, group= Trap, colour= Trap)) + 
  geom_point(size=2, alpha=0.8) +
  geom_line(size=1.5, alpha=0.5) +
  xlab("Year") + ylab("Total Dry Mass (grams)") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) + 
  facet_grid(Transect~., scales = "free_y") +
  theme(legend.position = "none") 
direct.label(MCONlittertrapannual, list(last.bumpup, rot= 15, cex=0.5, hjust = 0, vjust = 0.5)) 
#MCONlittertrapannual.plot


