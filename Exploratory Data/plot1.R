## Exploratory Data Project 1- plot1.R
## Working directory should be set at the location of zip file - exdata-data-household_power_consumption.zip
## Place this file in the same location
## Run this code by using command :  source("plot1.R")

#Unzips the file
unzip(zipfile = "exdata-data-household_power_consumption.zip")
fileName <- "household_power_consumption.txt"

##Below command will load file data with Date range 1/2/2007 and 2/2/2007.
##Alternate command(not shown below) is to read all the data and then subset
powerConc <- read.table(text = grep("^[1,2]/2/2007", readLines(fileName),value = T), sep = ";", header = T,
       col.names = c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity"
      ,"Sub_metering_1","Sub_metering_2","Sub_metering_3"), na.strings = "?")


##Plot1
hist(x = powerConc$Global_active_power, xlab = "Global Active Power(kilowatts)", col = "red", 
     main = "Global Active Power")
dev.copy(png, "plot1.png")
dev.off()