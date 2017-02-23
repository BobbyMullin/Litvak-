#This Script is designed to calculate the total mass of litter collected in each trap for each year. 

#####To calculate the total litter based on a hydrological calender (beginning Oct. 1), I edited the csv source file IN excel, to create a column called HydroYear. 
#Using the formula: "=YEAR(E2)+(IF(MONTH(E2)>=10,1,0)" to generate the value for hydraulic year
#This uses E2 as the date cell and tells excel, if the month in E2 >= October, add 1 to the year value, if not, then add 0. 
#Then drag down to autofill the remaining cell


#Load libraries
library(ggplot2)
library(RColorBrewer)
library(gridExtra)
library(reshape2)
library(lubridate)
library(plyr)
library(data.table)

#read in the csv source file
trapmass <- read.csv('Z:/eddyflux/Tower sites/All_Sites/Biomass_All_Sites/Litter_Biomass_All_Sites/Litter QC in R/Litter NPP Calculations/temporary file for Litter plot files/littertrap.mass.csv')


#Check to confirm that the HydroYear column is included in the source file
head(trapmass)
#Now, we calculate the total mass at each trap for each year
trapmassbyyear <- as.data.table(trapmass) [, sum(totalmass), by = .(Trap, Year, Site, Transect)]
head(trapmassbyyear)

write.csv(trapmassbyyear, 'Z:/eddyflux/Tower sites/All_Sites/Biomass_All_Sites/Litter_Biomass_All_Sites/Litter QC in R/Litter NPP Calculations/temporary file for Litter plot files/trapmassbyyear.csv', row.names=F)

#now we calculate the total mass at each trap for each hydrological year
trapmassbyhydroyear <- as.data.table(trapmass)[, sum(totalmass), by = .(Trap, HydroYear, Site, Transect)]

write.csv(trapmassbyhydroyear, 'Z:/eddyflux/Tower sites/All_Sites/Biomass_All_Sites/Litter_Biomass_All_Sites/Litter QC in R/Litter NPP Calculations/temporary file for Litter plot files/trapmassbyhydroyear.csv', row.names=F)


#trying something new (need to create table with additional columns for site, trap, transect)
trapmassbyyear <- as.data.table(trapmass) [, sum(totalmass), by = .(Trap, Year, Site, Transect)]
                          
trapmassbyyear
