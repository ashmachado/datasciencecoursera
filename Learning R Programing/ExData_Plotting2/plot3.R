##Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
##which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? 
##Which have seen increases in emissions from 1999-2008? 
##Use the ggplot2 plotting system to make a plot answer this question.

## Working directory should be set at the location of zip file - exdata-data-NEI_data.zip
## Place this file in the same location
## Run this code by using command :  source("plot3.R")

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

BaltimorePollutantDF <- NEI %>% filter(fips =="24510") %>% group_by(year,type) %>% summarize(TotalPol = sum(Emissions))

##qplot(year,TotalPol,data = BaltimorePollutantDF, facets = .~type, binwidth = 5, density('line'))

qplot(year,TotalPol,data = BaltimorePollutantDF, color = type, geom = c('point','smooth'), xaxt = 'n', 
      xlab = 'Year', ylab = 'Annual Total pollution', main = "Baltimore city PM2.5 Emissions for different types")

dev.copy(png, "plot3.png")
dev.off()