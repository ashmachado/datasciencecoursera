##How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

## Working directory should be set at the location of zip file - exdata-data-NEI_data.zip
## Place this file in the same location
## Run this code by using command :  source("plot5.R")

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

#Get all motor vehicle sources scc 
sccMotorss <- subset(scc, grepl('^Mobile - On-Road', scc$EI.Sector, ignore.case = TRUE))

##Subset the NEI data based on the motor vehicle sources scc
NEIMotor <- subset(NEI, SCC %in% sccMotorss$SCC)

## Filter by baltimore FIPS= 24510, group annually and sum the emissions.
motorsourceDF <- NEIMotor %>% filter(fips =="24510") %>% group_by(year) %>% summarize(TotalPol = sum(Emissions))

##Drawing plot to show total annual emissions from PM2.5 Emissions from Motor Vehicle sources
## xaxt = 'n' is to draw the X axis seperately
qplot(year,TotalPol,data = motorsourceDF,geom = 'line', xaxt = 'n', 
      xlab = 'Year', ylab = 'TotalPM2.5 Emissions', main = "PM2.5 Emissions from Motor Vehicle sources")


##Drawing plot to show total annual emissions from PM2.5 Emissions from Motor Vehicle sources
## xaxt = 'n' is to draw the X axis seperately
## with(motorsourceDF, plot(year, TotalPol, xlab = "Year", ylab = "Total PM2.5 Emissions", 
##                       type = 'l', col='blue', xaxt = 'n', main = "PM2.5 Emissions from Motor Vehicle sources"))

##Creating X Axis based on the year
## axis(side = 1, at = motorsourceDF$year)

##Plotting the points
## points(motorsourceDF$year,motorsourceDF$TotalPol,pch =20, color = 'blue')

dev.copy(png, "plot5.png")
dev.off()
