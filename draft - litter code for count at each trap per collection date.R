ddply 

subsets of date  

# Load some important libraries that contain functions you might use
# Before you start, make sure these are downloaded and up-to-date
library(ggplot2)
library(RColorBrewer)
library(gridExtra)
library(reshape2)
library(lubridate)
library(plyr)

# Read in the litter dataset
litter.gap <- read.csv('Z:/eddyflux/Tower sites/All_Sites/Biomass_All_Sites/Litter_Biomass_All_Sites/Litter QC in R/Litter NPP Calculations/Litter_Biomass_All_qry.csv', sep=",", header=TRUE, strip.white=TRUE, fill=NA)

#look at the header of the file
head(litter.gap)

# Exclude data from before 2012 because it looks crazy

litter.gap2012 <- litter.gap[litter.gap$Year >= 2012 ,]
head(litter.gap2012)
# Now create new column named "Trap" that defines each trap by transect, distance, litter, and cover type, and paste it into the litter dataframe
litter.gap2012['Trap'] <- paste(litter.gap2012$Site, litter.gap2012$Transect_Name, litter.gap2012$Distance, litter.gap2012$Cover_Type, sep = "_")
head(litter.gap2012)

unique(litter.gap2012$Trap)

a <- ddply(litter.gap2012, c("Site", "Year_collected", "Month_collected", "Day_collected" ), function(x)
  data.frame(num_traps = length(unique(x$Trap))))
head(a)
write.csv(a , 'Z:/eddyflux/Tower sites/All_Sites/Biomass_All_Sites/Litter_Biomass_All_Sites/Litter QC in R/Litter NPP Calculations/temporary file for Litter plot files/litterdatagaps.csv', row.names=F)

uniquecomments <- unique(litter.gap$Comments)
uniquecomments