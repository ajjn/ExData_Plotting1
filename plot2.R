library(dplyr)
library(data.table)

## Download data

download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile="data.zip", method="wget")

## Unzip

system("unzip data.zip")


fileOut <- "plot2.png"
fileIn <- "household_power_consumption.txt"

## read data
data <- fread(fileIn)
## Take only dates 1.2.2007 and 2.2.2007
filtered <- rbind(filter(data, Date =="1/2/2007"), filter(data, Date =="2/2/2007"))
filtered <- cbind(filtered, datetime=strptime(paste(filtered$Date,filtered$Time), "%d/%m/%Y %H:%M:%S"))
png(fileOut)
with(filtered, plot(datetime, as.numeric(Global_active_power), ylab="Global Active power (kilowatts)", xlab="", type="n"))
with(filtered, lines(datetime, as.numeric(Global_active_power)))
dev.off()
