#Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
#Which city has seen greater changes over time in motor vehicle emissions?
## Working directory should be set at the location of zip file - exdata-data-NEI_data.zip
## Place this file in the same location
## Run this code by using command :  source("plot6.R")


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
NEIMotor <- subset(NEI, SCC %in% scccoalss$SCC)

## Filter by baltimore FIPS= 24510, group annually and sum the emissions.
BaltimoremotorsourceDF <- NEIMotor %>% filter(fips =="24510") %>% group_by(year) %>% summarize(TotalPol = sum(Emissions))
BaltimoremotorsourceDF <- mutate(BaltimoremotorsourceDF, City = c('Baltimore'))


## Filter by Los Angeles County FIPS= 06037, group annually and sum the emissions.
LAmotorsourceDF <- NEIMotor %>% filter(fips =="06037") %>% group_by(year) %>% summarize(TotalPol = sum(Emissions))
LAmotorsourceDF <- mutate(LAmotorsourceDF, City = c('Los Angeles'))

mergedDF <- rbind(BaltimoremotorsourceDF,LAmotorsourceDF)

qplot(year,TotalPol,data = mergedDF, color = City, geom = c('point','smooth'), xaxt = 'n', 
      xlab = 'Year', ylab = 'Annual Total pollution', main = "PM2.5 Emissions for Baltimore vs Los Angeles")
dev.copy(png, "plot6.png")
dev.off()