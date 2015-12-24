##Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
##Use the base plotting system to make a plot answering this question.

## Working directory should be set at the location of zip file - exdata-data-NEI_data.zip
## Place this file in the same location
## Run this code by using command :  source("plot2.R")


if(!require(dplyr)) {
  install.packages("dplyr")
  library(dplyr)  
}

unzip(zipfile = "exdata-data-NEI_data.zip")

NEI <- readRDS("summarySCC_PM25.rds")

BaltimorePollutantDF <- NEI %>% filter(fips =="24510") %>% group_by(year) %>% summarize(TotalPol = sum(Emissions))


with(BaltimorePollutantDF, plot(year, TotalPol, xlab = "Year", ylab = "Total PM2.5 Emissions", 
                           type = 'l', col='blue', xaxt = 'n', main = "Total PM2.5 Emissions for Baltimore,Maryland"))
axis(side = 1, at = YearPollutantDF$year)
points(BaltimorePollutantDF$year,BaltimorePollutantDF$TotalPol, col = "black", pch = 20)

dev.copy(png, "plot2.png")
dev.off()