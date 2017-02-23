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
litter <- read.csv('Z:/eddyflux/Tower sites/All_Sites/Biomass_All_Sites/Litter_Biomass_All_Sites/Litter QC in R/Litter NPP Calculations/Litter_Biomass_All_qry.csv', sep=",", header=TRUE, strip.white=TRUE, fill=NA)

# If you change your dataset and want to save it:
#write.csv(litter, 'Z:/eddyflux/Tower sites/All_Sites/Biomass_All_Sites/Litter_Biomass_All_Sites/Litter QC in R/Litter NPP Calculations/temporary file for Litter plot files/Bobby_litter.csv', row.names=F)

# Look at the column names and first few rows (dataframe head) to see what the dataframe looks like
colnames(litter) 
head(litter)

# Now create new column named "Trap" that defines each trap by transect, distance, litter, and cover type, and paste it into the litter dataframe
litter['Trap'] <- paste(litter$Site, litter$Transect, litter$TransectDistance, litter$CoveredOpen, sep = "_")

# Now try looking at the structure of the dataframe, a summary of one of the columns, and all of the unique entries within a column
str(litter)
summary(litter$CoverType)
unique(litter$LitterSpecies)

# Dates never read in correctly, so we need to format as a date object
#litter$Date <- as.POSIXlt(strptime(litter$Date, format="%Y-%m-%d"))
# Or use lubridate package
litter$Date <- mdy(litter$Date)


# Let's rename and order the Sites in order of elevation so the graphs look better
litter$Site <- factor(litter$Site, levels = c("SHRUB", "Jsav", "PJGirdle", "PJControl", "PPINE", "MCON", "NewMCON"))

# Exclude miscellaneous and scat categories
# Exclude data from before 2012 because it looks crazy
litter <- litter[is.na(litter$LitterType) | (litter$LitterType != "m" & litter$LitterType != "s"),]
litter <- litter[is.na(litter$LitterType) | (litter$LitterType != "<NA>"),]
litter <- litter[litter$Year >= 2012 ,]

# Use ddply to create summary statistics
# Calculate total litter biomass per trap per collection date
trap.weight <- ddply(litter, c("Trap", "Date"), function(x)
  data.frame(totalweight = colSums(x["DryWeight"], na.rm=T) /
               length(unique("Trap")),
             varweight = var(x$DryWeight, na.rm=T)))

#look at results
head(trap.weight)

