library(dplyr)
library(data.table)

## Download data

download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile="data.zip", method="wget")

## Unzip

system("unzip data.zip")

fileOut <- "plot4.png"
fileIn <- "household_power_consumption.txt"

## read data
data <- fread(fileIn)
## Take only dates 1.2.2007 and 2.2.2007
filtered <- rbind(filter(data, Date =="1/2/2007"), filter(data, Date =="2/2/2007"))
filtered <- cbind(filtered, datetime=strptime(paste(filtered$Date,filtered$Time), "%d/%m/%Y %H:%M:%S"))
png(fileOut)
par(mfrow=c(2,2))

## 1
with(filtered, plot(datetime, as.numeric(Global_active_power), ylab="Global Active power", xlab="", type="n"))
with(filtered, lines(datetime, as.numeric(Global_active_power)))

## 2
with(filtered, plot(datetime, as.numeric(Voltage), type="n", ylab="Voltage"))
with(filtered, lines(datetime, as.numeric(Voltage)))

## 3

with(filtered, plot(datetime, as.numeric(Sub_metering_1), ylab="Energy sub metering", xlab="", type="n"))
with(filtered, lines(datetime, as.numeric(Sub_metering_1), col="black") )
with(filtered, lines(datetime, as.numeric(Sub_metering_2), col="red") )
with(filtered, lines(datetime, as.numeric(Sub_metering_3), col="blue") )
legend("topright", lty=1,col=c("black","red","blue"), bty="n", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))


## 4
with(filtered, plot(datetime, as.numeric(Global_reactive_power), ylab="Global_reactive_power" , type="n"))
with(filtered, lines(datetime, as.numeric(Global_reactive_power)))
dev.off()

