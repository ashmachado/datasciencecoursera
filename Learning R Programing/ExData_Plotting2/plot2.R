##Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
##Use the base plotting system to make a plot answering this question.

## Working directory should be set at the location of zip file - exdata-data-NEI_data.zip
## Place this file in the same location
## Run this code by using command :  source("plot2.R")


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

BaltimorePollutantDF <- NEI %>% filter(fips =="24510") %>% group_by(year) %>% summarize(TotalPol = sum(Emissions))


## Use qplot from ggplot2 package
qplot(year,TotalPol,data = BaltimorePollutantDF, geom = 'line', xaxt = 'n',  
      xlab = 'Year', ylab = 'Total PM2.5 Emissions', main = "Total PM2.5 Emissions in Baltimore,Maryland")


##with(BaltimorePollutantDF, plot(year, TotalPol, xlab = "Year", ylab = "Total PM2.5 Emissions", 
  ##                         type = 'l', col='blue', xaxt = 'n', main = "Total PM2.5 Emissions for Baltimore,Maryland"))
##axis(side = 1, at = YearPollutantDF$year)
##points(BaltimorePollutantDF$year,BaltimorePollutantDF$TotalPol, col = "black", pch = 20)
##regline <- lm(BaltimorePollutantDF$TotalPol~BaltimorePollutantDF$year)

dev.copy(png, "plot2.png")
dev.off()