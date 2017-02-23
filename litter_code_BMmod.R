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
litter['Trap'] <- paste(litter$Site, litter$Transect, litter$TransectDistance, litter$CoverType, sep = "_")

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
# Calculate total litter biomass per site per collection date
#total.weight <- ddply(litter, c("Site", "Date"), function(x)
 data.frame(totalweight = colSums(x["DryWeight"], na.rm=T) /
               length(unique(c(x$Transect, x$TransectDistance))),
             varweight = var(x$DryWeight, na.rm=T))

trap.weight <- ddply(litter, c("Site", "Transect" , "TransectDistance" , "Year" , "Date" , "Month" , "Day" , "CoveredOpen" , "CoverType" , "DryWeight" , "Trap" , "Comments"), function(x)
  data.frame(totalweight = colSums(x["DryWeight"], na.rm=T) /
               length(unique("Trap")),
             varweight = var(x$DryWeight, na.rm=T)))
#Look at the output headers
head(trap.weight) 

write.csv(trap.weight, 'Z:/eddyflux/Tower sites/All_Sites/Biomass_All_Sites/Litter_Biomass_All_Sites/Litter QC in R/Litter NPP Calculations/temporary file for Litter plot files/trap_weight.csv', row.names=F)

#total.weight 
# Calculate total litter biomass per site, collection date, open/covered, litter species, and litter type
group.weight <- ddply(litter, c("Site", "Date", "CoveredOpen", "LitterSpecies", "LitterType"), function(x)
  data.frame(groupedweight = colSums(x["DryWeight"], na.rm=T),
             vargroupedweight = var(x$DryWeight, na.rm=T)))

head(group.weight) #Look at the output

#Calculate mean litter per site, collection date, cover, species, and type
mean.weight <- ddply(litter, c("Site", "Date", "CoveredOpen", "LitterSpecies", "LitterType"), function(x)
  data.frame(Mean_weight = colMeans(x["DryWeight"], na.rm=T),
             varMeanweight = var(x$DryWeight, na.rm=T)))
#mean.weight

# Merge these groups onto the main dataset
#litter <- merge(litter, total.weight, by=c("Site", "Date"), all=T)
#litter <- merge(litter, group.weight, by=c("Site", "Date", "CoveredOpen", "LitterSpecies", "LitterType"), all=T)
#litter <- merge(litter, mean.weight, by =c("Site", "Date", "CoveredOpen", "LitterSpecies", "LitterType"))
litter <- merge(litter, trap.weight, by = C("Trap", "Date", "CoverType", "totalweight"))

# Make some plots!
# Total litter weight timeline
littertrap.plot <- ggplot(litter, aes(x=Date, y=trap.weight, group="Trap", colour="Trap")) +
  geom_point(size=2, alpha=0.8) +
  geom_line(size=1.5, alpha=0.5) +
  facet_grid(Site~.) +
  ggtitle("Title") + 
  xlab("Axis title") + ylab("Total dry weight (grams)") +
  theme_bw() 

littertrap.plot

# Breakdown of litter weight by species and cover
litter.sp.plot <- ggplot(litter[litter$Year>=2014 & 
                                  !is.na(litter$LitterType) & 
                                  litter$CoveredOpen=="covered",], 
                         aes(x=Month, y=groupedweight, 
                             group=interaction(LitterSpecies, LitterType, Year), 
                             colour=LitterSpecies, shape=as.factor(Year))) +
  geom_point(size=2, alpha=0.8) +
  geom_line(size=1.5, alpha=0.5) +
  facet_grid(Site~, scales="free_y") +
  ggtitle("Title") + 
  xlab("Axis title") + ylab("Total dry weight (grams)") +
  theme_bw() 
litter.sp.plot


# Trends in reproductive litter
litter.r.plot <- ggplot(litter[litter$Year>=2014 & 
                                  !is.na(litter$LitterType) & 
                                  litter$CoveredOpen=="covered" & 
                                  litter$LitterType=="r",], 
                         aes(x=Month, y=groupedweight, 
                             group=interaction(LitterSpecies, LitterType, Year), 
                             colour=LitterSpecies, shape=as.factor(Year))) +
  geom_point(size=2, alpha=0.8) +
  geom_line(size=1.5, alpha=0.5) +
  facet_grid(Site~., scales="free_y") +
  ggtitle("Title") + 
  xlab("Axis title") + ylab("Total dry weight (grams)") +
  theme_bw() 
litter.r.plot
