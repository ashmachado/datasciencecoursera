##Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, 
##make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

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

YearPollutantDF <- NEI %>% group_by(year) %>% summarize(TotalPol = sum(Emissions))

##with(YearPollutantDF, plot(year, TotalPol, xlab = "Year", ylab = "Total PM2.5 Emissions", 
                         ##  type = 'l', col='blue', xaxt = 'n', main = "Total PM2.5 Emissions Per year"))
##axis(side = 1, at = YearPollutantDF$year)
##points(YearPollutantDF$year,YearPollutantDF$TotalPol, col = "black", pch = 20)

qplot(year,TotalPol,data = YearPollutantDF, geom = 'line', xaxt = 'n',  
      xlab = 'Year', ylab = 'Total PM2.5 Emissions', main = "Total PM2.5 Emissions Per year")

axis(side = 1, at = YearPollutantDF$year)
##regline <- lm(YearPollutantDF$TotalPol~YearPollutantDF$year)
##abline(regline, lwd = 2, col = 'black')

dev.copy(png, "plot1.png")
dev.off()


g <- ggplot(YearPollutantDF, aes(year)) 
g <- g +geom_line(aes(y=TotalPol), color = 'blue') 
g