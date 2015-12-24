## Exploratory Data Project 1- plot3.R
## Working directory should be set at the location of zip file - exdata-data-household_power_consumption.zip
## Place this file in the same location
## Run this code by using command :  source("plot3.R")

#Unzips the file
unzip(zipfile = "exdata-data-household_power_consumption.zip")
fileName <- "household_power_consumption.txt"

##Below command will load file data with Date range 1/2/2007 and 2/2/2007.
powerConc <- read.table(text = grep("^[1,2]/2/2007", readLines(fileName),value = T), sep = ";", header = T,
                        col.names = c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity"
                                      ,"Sub_metering_1","Sub_metering_2","Sub_metering_3"), na.strings = "?",
                        stringsAsFactors = F)


##Using strptime function
powerConc$TimeStamp <- strptime(paste(powerConc$Date,powerConc$Time),format = '%d/%m/%Y %H:%M:%S')


##Convert Date column from Character to Date class type using as.date and as.POSIXct functions
powerConc$Date <- as.Date(powerConc$Date, format = '%d/%m/%Y')
datetime <- paste(as.Date(powerConc$Date), powerConc$Time)
powerConc$DateTime <- as.POSIXct(datetime)

##Plot3. Column - powerConc$DateTime - can be used instead of column -powerConc$TimeStamp
par(mfrow = c(1,1))
plot(x = powerConc$TimeStamp, y = powerConc$Sub_metering_1,type = "n", ylab = "Energy sub metering", xlab = "")
points(x = powerConc$TimeStamp,  y = powerConc$Sub_metering_1, type = 'l', col = 'black')
points(x = powerConc$TimeStamp,  y = powerConc$Sub_metering_2, type = 'l', col = 'red')
points(x = powerConc$TimeStamp,  y = powerConc$Sub_metering_3, type = 'l', col = 'blue')
legend(x = "topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
       col =c("black", "red", "blue"), lwd = "1", xjust = "0", pt.cex = 1, cex = .5)
dev.copy(png, "plot3.png")
dev.off()
