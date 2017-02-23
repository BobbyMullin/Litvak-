# This script uses a pre-cleaned Litvak litter dataset to create summary figures for Missy & Andrea's lab presentation

# Load some important libraries that contain functions you might use
# Before you start, make sure these are downloaded and up-to-date
library(ggplot2)
library(RColorBrewer)
library(gridExtra)
library(reshape2)
library(lubridate)
library(plyr)

# Read in the litter dataset
littertrap.mass <- read.csv('Z:/eddyflux/Tower sites/All_Sites/Biomass_All_Sites/Litter_Biomass_All_Sites/Litter QC in R/Litter NPP Calculations/temporary file for Litter plot files/littertrap.mass.csv')
head(littertrap.mass)

# Make some plots!
# Total litter weight timeline
littertrap.plot <- ggplot(littertrap.mass[littertrap.mass$Site == "Jsav",], aes(x=Date, y=totalmass, colour=Site)) +
  geom_point(size=2, alpha=0.8) +
  geom_line(size=1.5, alpha=0.5) +
  ggtitle("Title") + 
  xlab("Date") + ylab("Total Dry Mass (grams)") +
  theme_bw() 

littertrap.plot

#Make a timeseries graph of trap weight at Jsav
Jsavlittertrap.plot <- ggplot(littertrap.mass[littertrap.mass$Site =="Jsav",], aes(x=Date, y=totalmass, group= Trap, colour= Trap)) + 
  geom_point(size=2, alpha=0.8) +
  geom_line(size=1.5, alpha=0.5) +
  xlab("Date") + ylab("Total Dry Mass (grams)") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) + 
  facet_grid(Transect~.)
Jsavlittertrap.plot


#Make a timeseries graph of trap weight at PJControl
PJClittertrap.plot <- ggplot(littertrap.mass[littertrap.mass$Site =="PJControl",], aes(x=Date, y=totalmass, group= Trap, colour= Trap)) + 
  geom_point(size=2, alpha=0.8) +
  geom_line(size=1.5, alpha=0.5) +
  xlab("Date") + ylab("Total Dry Mass (grams)") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) + 
  facet_grid(Transect~.)
PJClittertrap.plot

#Make a timeseries graph of trap weight at PJGirdle
PJGlittertrap.plot <- ggplot(littertrap.mass[littertrap.mass$Site =="PJGirdle",], aes(x=Date, y=totalmass, group= Trap, colour= Trap)) + 
  geom_point(size=2, alpha=0.8) +
  geom_line(size=1.5, alpha=0.5) +
  xlab("Date") + ylab("Total Dry Mass (grams)") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) + 
  facet_grid(Transect~.)
PJGlittertrap.plot

#Make a timeseries graph of trap weight at PPINE
PPINElittertrap.plot <- ggplot(littertrap.mass[littertrap.mass$Site =="PPINE",], aes(x=Date, y=totalmass, group= Trap, colour= Trap)) + 
  geom_point(size=2, alpha=0.8) +
  geom_line(size=1.5, alpha=0.5) +
  xlab("Date") + ylab("Total Dry Mass (grams)") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) + 
  facet_grid(Transect~.)
PPINElittertrap.plot

#Make a timeseries graph of trap weight at SHRUB
SHRUBlittertrap.plot <- ggplot(littertrap.mass[littertrap.mass$Site =="SHRUB",], aes(x=Date, y=totalmass, group= Trap, colour= Trap)) + 
  geom_point(size=2, alpha=0.8) +
  geom_line(size=1.5, alpha=0.5) +
  xlab("Date") + ylab("Total Dry Mass (grams)") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) + 
  facet_grid(Transect~.)
SHRUBlittertrap.plot

