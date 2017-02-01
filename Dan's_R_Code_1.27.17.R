# Quick script to deal with some allometric data	
# including plotting individual trees over time,	
# distributions of variables across site, etc.	
# Dan Krofcheck - 07-23-15	
# Edited for site specific QA/QC 8-13-15 by Dan Krofcheck	

library(reshape)	
library(ggplot2)	

# Read in the allometric file exported from Access	
# Here, because there are empty cells in our dataframe, 	
# add the fill = TRUE param to tell R that everything will	
# be OK	
#allometry <- read.csv('Z:/eddyflux/Tower sites/All_Sites/Circle_Plots_All_Sites/2017 NPP Calculations/RCode-Bobby/Allometry_All_qry.csv', 	
#	sep = ',', header = TRUE, fill = TRUE)

allometry <- read.csv('Z:/eddyflux/Tower sites/All_Sites/Circle_Plots_All_Sites/2017 NPP Calculations/RCode-Bobby/Allometry_All_qry.csv', 	
                      sep = ',', header = TRUE, fill = TRUE)

# The simplest thing we can do is generate histograms of some of the allometrics	
# by site and species, for instance height -- because there are no calculations	
# involved.	

ggplot(allometry, aes(x = Height)) + geom_density(aes(color = Species)) + 	
  facet_grid(Site~Year, scale = 'free') + theme_bw()

# Thats neat.. but we don't really care about most of the species in the list,	
# given that most of them are herbaceous guys (or gals). Lets just isolate	
# a list of species that we actually care about.	
# To start, lets actually only look at JSAV.	
JSAV_Only <- allometry[allometry$Site == 'JSAV', ]	
PPINE_Only <- allometry[allometry$Site == 'PPINE', ]	

# Quick histograms of Height as an example, by year and species.	
ggplot(JSAV_Only, aes(x = Height)) + geom_histogram(aes(color = Species)) + 	
  facet_grid(Site~Year, scale = 'free') + theme_bw()

# Lets create some boxplots by year to make the frass less terrible	
ggplot(JSAV_Only, aes(factor(Year), Height)) + geom_boxplot(aes(color = Species)) + 	
  facet_grid(Site~., scale = 'free') + theme_bw()+ geom_jitter(aes(color = Species)) 

# Now we need to do something with the various allometric measurements which we use 	
# to generate biomass for these trees. The ground based allmetry that we use is driven	
# only by RCD, however given the multiply branching nature of the vegetation, we need to	
# calculate an equivalent diameter (ESD). Lets handle the NA's by filling them with 0's,	
# and add a column to our dataframe that includes this useful ESD value.	
JSAV_Only[is.na(JSAV_Only)] <- 0	
JSAV_Only['ESD_Calc'] <- sqrt(JSAV_Only$RCD_1^2 + JSAV_Only$RCD_2^2 + JSAV_Only$RCD_3^2 + JSAV_Only$RCD_4^2 + JSAV_Only$RCD_5^2 +	
                                JSAV_Only$RCD_6^2 + JSAV_Only$RCD_7^2 + JSAV_Only$RCD_8^2 + JSAV_Only$RCD_9^2 + JSAV_Only$RCD_10^2 +	
                                JSAV_Only$RCD_11^2 + JSAV_Only$RCD_12^2 + JSAV_Only$RCD_13^2 + JSAV_Only$RCD_14^2 + JSAV_Only$RCD_15^2 +	
                                JSAV_Only$RCD_16^2 + JSAV_Only$RCD_17^2 + JSAV_Only$RCD_18^2 + JSAV_Only$RCD_19^2)	

# Lets check out our shiny new ESD column	
ggplot(JSAV_Only, aes(factor(Year), ESD_Calc)) + geom_boxplot(aes(color = Species)) + 	
  facet_grid(Site~., scale = 'free') + theme_bw()+ geom_jitter(aes(color = Species)) 

# Woah, looks like we don't have any stem diameters for 2007? Not likely, its probably a naming	
# problem:	
ggplot(JSAV_Only, aes(factor(Year), RCD_Calculations)) + geom_boxplot(aes(color = Species)) + 	
  facet_grid(Site~., scale = 'free') + theme_bw()+ geom_jitter(aes(color = Species)) 

# Huh... OK, lets try and fix this by adding the value of RCD_Calculations to our 	
# ESD_Calc column, iff year == 2007.	

JSAV_Only$ESD_Calc[JSAV_Only$Year == 2007] <- JSAV_Only$RCD_Calculations[JSAV_Only$Year == 2007]

# and now re-plot	
ggplot(JSAV_Only, aes(factor(Year), ESD_Calc)) + geom_boxplot(aes(color = Species)) + 	
  facet_grid(Site~., scale = 'free') + theme_bw()+ geom_jitter(aes(color = Species)) 
# I'm satisfied.. but we don't need the rest of the species, just the JUMO for the time being.	
# So, strip it down further to only Species == JUMO.	
JSAV_Only <- JSAV_Only[JSAV_Only$Species == 'JUMO', ]	
# and now re-plot

ggplot(JSAV_Only, aes(factor(Year), ESD_Calc)) + geom_boxplot(aes(color = Species)) + 	
  theme_bw()+ geom_jitter(aes(color = Species)) + xlab('Year') + ylab('Equivalent Stem Diameter (cm^2)')

# Now boxplots by circle plot	
ggplot(JSAV_Only, aes(factor(Year), ESD_Calc)) + geom_boxplot(aes(color = factor(Plot_Name))) + 	
  theme_bw()+ geom_jitter(aes(color = Species)) + xlab('Year') + ylab('Equivalent Stem Diameter (cm^2)')

# Now trends of individuals over time (spooky stuff)	
ggplot(JSAV_Only, aes(factor(Year), Height)) + geom_line(aes(color = ESD_Calc, group = Tree_Tag_Number)) + 	
  facet_grid(~Plot_Name) + theme_bw()+ xlab('Year') + ylab('Height (m)') + geom_text(aes(label = Tree_Tag_Number))

ggplot(JSAV_Only, aes(factor(Year), Height)) + geom_line(aes(group = Tree_Tag_Number)) + 	
  facet_grid(~Plot_Name) + theme_bw()+ xlab('Year') + ylab('Height (m)') + geom_text(aes(label = Tree_Tag_Number, size = ESD_Calc))

# How do we pick out 'reasonable trends' ?? 	
check <- aggregate(JSAV_Only, FUN = var, na.rm = TRUE, by = list(JSAV_Only$Tree_Tag_Number))	
ggplot(check, aes(Group.1, Height)) + geom_point(aes(size = Height)) + 	
  theme_bw()+ xlab('Tag #') + ylab('Height (m)') + geom_text(data=subset(check, Height > 1.5),
                                                             aes(label=Group.1, hjust = 0, vjust = 1.2)) 


ggplot(check, aes(Group.1, ESD_Calc)) + geom_point(aes(size = ESD_Calc)) + 	
  theme_bw()+ xlab('Tag #') + ylab('ESD (cm^2)') + geom_text(data=subset(check, ESD_Calc> 125),
  aes(label=Group.1, hjust = 0, vjust = 1.2))

# Gross. Lets append a biomass column -- this means drawing from 1 of 2 equations on a per row basis,	
# depending on some maturity proxy (in this case, RCD (or ESD)).	
JSAV_Only['Biomass'] <- NA	
JSAV_Only$Biomass[JSAV_Only$ESD_Calc > 5] <- 69.66 * JSAV_Only$ESD_Calc[JSAV_Only$ESD_Calc > 5]^(2.086)	
JSAV_Only$Biomass[JSAV_Only$ESD_Calc <= 5] <-  1760*JSAV_Only$Volume[JSAV_Only$ESD_Calc <= 5]^(0.6781)	

# So thats basically the gist of things, lets recreate some of those previous plots with Biomass and 	
# see how the variability in ESD translates to kg C =]	

ggplot(JSAV_Only, aes(factor(Year), Biomass)) + geom_line(aes(group = Tree_Tag_Number)) + 	
  facet_grid(~Plot_Name) + theme_bw()+ xlab('Year') + ylab('Biomass') + geom_text(aes(label = Tree_Tag_Number, size = ESD_Calc))






