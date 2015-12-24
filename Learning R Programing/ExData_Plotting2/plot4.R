##Across the United States, how have emissions from Coal combustion-related sources changed from 1999-2008?

## Working directory should be set at the location of zip file - exdata-data-NEI_data.zip
## Place this file in the same location
## Run this code by using command :  source("plot4.R")

if(!require(dplyr)) {
  install.packages("dplyr")
  library(dplyr)  
}

if(!require(ggplot2)) {
  install.packages("ggplot2")
  library(ggplot2)  
}

unzip(zipfile = "exdata-data-NEI_data.zip")
NEI <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

##Get coal combustion-related sources SCC 
scccoalss <- subset(scc, grepl('coal$', scc$EI.Sector, ignore.case = TRUE))

##Subset the NEI data based on the coal combustion-related sources SCC 
NEICoal <- subset(NEI, SCC %in% scccoalss$SCC)

## Sum the emissions
coalCombDF <- NEICoal %>% group_by(year) %>% summarize(TotalPol = sum(Emissions))

##coalCombDF <- coalCombDF %>% mutate(TotalPol = (TotalPol/100))

qplot(year,TotalPol,data = coalCombDF,geom = 'line', xaxt = 'n', 
      xlab = 'Year', ylab = 'TotalPM2.5 Emissions', main = "PM2.5 Emissions from Coal combustion-related sources")


##with(coalCombDF, plot(year, TotalPol, xlab = "Year", ylab = "Total PM2.5 Emissions", 
##                         type = 'l', col='blue', xaxt = 'n', main = "PM2.5 Emissions from Coal combustion-related sources"))
##axis(side = 1, at = coalCombDF$year)
##points(coalCombDF$year,coalCombDF$TotalPol,pch =20 )

dev.copy(png, "plot4.png")
dev.off()