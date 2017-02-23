# This script uses a litter dataset exported from Access. It is the first in a series of scripts to calculate the annual mass of each trap over the years. 

####before reading in the litter dataset- change the date format to MM/DD/YYYY in Microsoft Excel. This will save trouble later on 
# Load some important libraries that contain functions you might use
# Before you start, make sure these are downloaded and up-to-date
library(ggplot2)
library(RColorBrewer)
library(gridExtra)
library(reshape2)
library(lubridate)
library(plyr)
library(data.table)

# Read in the litter dataset
litter <- read.csv('Z:/eddyflux/Tower sites/All_Sites/Biomass_All_Sites/Litter_Biomass_All_Sites/Litter QC in R/Litter NPP Calculations/Litter_Biomass_All_qry.csv', sep=",", header=TRUE, strip.white=TRUE, fill=NA)

# If you change your dataset and want to save it:
#write.csv(litter, 'Z:/eddyflux/Tower sites/All_Sites/Biomass_All_Sites/Litter_Biomass_All_Sites/Litter QC in R/Litter NPP Calculations/temporary file for Litter plot files/Bobby_litter.csv', row.names=F)

# Look at the column names and first few rows (dataframe head) to see what the dataframe looks like
#colnames(litter) 
#head(litter)

#Let's rename some column names
setnames(litter, "Transect_Name" , "Transect")
setnames(litter, "Date_collected" , "Date")
setnames(litter, "Year_collected" , "Year")
setnames(litter, "Month_collected" , "Month")
setnames(litter, "Litter_dry_mass" , "DryMass")
setnames(litter, "Cover_Type" , "CoverType")  
setnames(litter, "Distance", "TransectDistance")
setnames(litter, "Covered_Open" , "CoveredOpen")
setnames(litter, "Day_collected" , "Day")
setnames(litter, "Category" , "LitterType")

# Exclude miscellaneous and scat categories
# Exclude data from before 2012 because it looks crazy
litter <- litter[is.na(litter$LitterType) | (litter$LitterType != "m" & litter$LitterType != "s"),]
litter <- litter[is.na(litter$LitterType) | (litter$LitterType != "<NA>"),]
litter <- litter[litter$Year >= 2012 ,]

# Now lets clean up the dataset and get rid of some columns
litter <- subset(litter, select = c("Site" , "Transect" , "TransectDistance" , "CoveredOpen" , "CoverType" , "Date" , "Month" , "Day" , "Year" , "DryMass"))

# Now create new column named "Trap" that defines each trap by transect, distance, litter, and cover type, and paste it into the litter dataframe
litter['Trap'] <- paste(litter$Site, litter$Transect, litter$TransectDistance, litter$CoverType, sep = "_")

# Now try looking at the structure of the dataframe, a summary of one of the columns, and all of the unique entries within a column
#str(litter)
#summary(litter$CoverType)
#unique(litter$Trap)

# If you've already changed date format in Excel, ignore thsese steps
# Dates never read in correctly, so we need to format as a date object
#litter$Date <- as.POSIXlt(strptime(litter$Date, format="%Y-%m-%d"))
# Or use lubridate package
litter$Date <- mdy(litter$Date)


# Let's rename and order the Sites in order of elevation so the graphs look better
litter$Site <- factor(litter$Site, levels = c("SHRUB", "Jsav", "PJGirdle", "PJControl", "PPINE", "MCON", "NewMCON"))


# Use ddply to create summary statistics
# Calculate total litter biomass per trap per collection date
trap.mass <- ddply(litter, c("Site", "Transect" , "TransectDistance" , "Year" , "Date" , "Month" , "Day" , "CoveredOpen" , "CoverType" , "Trap" ), function(x)
  data.frame(totalmass = colSums(x["DryMass"], na.rm=T) /
               length(unique("Trap")),
             varmass = var(x$DryMass, na.rm=T)))
#look at results
head(trap.mass)

write.csv(trap.mass, 'Z:/eddyflux/Tower sites/All_Sites/Biomass_All_Sites/Litter_Biomass_All_Sites/Litter QC in R/Litter NPP Calculations/temporary file for Litter plot files/littertrap.mass.csv', row.names=F)


#Next, use the script called "Litter code for annual weight"
