#read in the csv source file
trapmasshydroannual <- read.csv('Z:/eddyflux/Tower sites/All_Sites/Biomass_All_Sites/Litter_Biomass_All_Sites/Litter QC in R/Litter NPP Calculations/temporary file for Litter plot files/trapmassbyhydroyear.csv')
head(trapmasshydroannual)
unique(trapmasshydroannual$Site)
#Jsav
Jsavlittertraphydroannual.plot <- ggplot(trapmasshydroannual[trapmasshydroannual$Site =="Jsav",], aes(x=HydroYear, y=V1, group= Trap, colour= Trap)) + 
  geom_point(size=2, alpha=0.8) +
  geom_line(size=1.5, alpha=0.5) +
  xlab("HydroYear") + ylab("Total Dry Mass (grams)") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) + 
  facet_grid(Transect~.)
Jsavlittertraphydroannual.plot

#Shrub
Shrublittertraphydroannual.plot <- ggplot(trapmasshydroannual[trapmasshydroannual$Site =="SHRUB",], aes(x=HydroYear, y=V1, group= Trap, colour= Trap)) + 
  geom_point(size=2, alpha=0.8) +
  geom_line(size=1.5, alpha=0.5) +
  xlab("HydroYear") + ylab("Total Dry Mass (grams)") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) + 
  facet_grid(Transect~.)
Shrublittertraphydroannual.plot

#PJControl
PJControllittertraphydroannual.plot <- ggplot(trapmasshydroannual[trapmasshydroannual$Site =="PJControl",], aes(x=HydroYear, y=V1, group= Trap, colour= Trap)) + 
  geom_point(size=2, alpha=0.8) +
  geom_line(size=1.5, alpha=0.5) +
  xlab("HydroYear") + ylab("Total Dry Mass (grams)") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) + 
  facet_grid(Transect~.)
PJControllittertraphydroannual.plot

#PJGirdle
PJGirdlelittertraphydroannual.plot <- ggplot(trapmasshydroannual[trapmasshydroannual$Site =="PJGirdle",], aes(x=HydroYear, y=V1, group= Trap, colour= Trap)) + 
  geom_point(size=2, alpha=0.8) +
  geom_line(size=1.5, alpha=0.5) +
  xlab("HydroYear") + ylab("Total Dry Mass (grams)") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) + 
  facet_grid(Transect~.)
PJGirdlelittertraphydroannual.plot

#PPINE
PPINElittertraphydroannual.plot <- ggplot(trapmasshydroannual[trapmasshydroannual$Site =="PPINE",], aes(x=HydroYear, y=V1, group= Trap, colour= Trap)) + 
  geom_point(size=2, alpha=0.8) +
  geom_line(size=1.5, alpha=0.5) +
  xlab("HydroYear") + ylab("Total Dry Mass (grams)") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) + 
  facet_grid(Transect~.)
PPINElittertraphydroannual.plot

#MCON - Data set is only contains 2010? - needs to be confirmed
MCONlittertraphydroannual.plot <- ggplot(trapmasshydroannual[trapmasshydroannual$Site =="MCON",], aes(x=HydroYear, y=V1, group= Trap, colour= Trap)) + 
  geom_point(size=2, alpha=0.8) +
  geom_line(size=1.5, alpha=0.5) +
  xlab("HydroYear") + ylab("Total Dry Mass (grams)") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) + 
  facet_grid(Transect~.)
MCONlittertraphydroannual.plot 