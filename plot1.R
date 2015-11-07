library(dplyr)
library(data.table)

## Download data

download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile="data.zip", method="wget")

## Unzip

system("unzip data.zip")


fileOut <- "plot1.png"
fileIn <- "household_power_consumption.txt"

## read data
data <- fread(fileIn)
## Take only dates 1.2.2007 and 2.2.2007
filtered <- rbind(filter(data, Date =="1/2/2007"), filter(data, Date =="2/2/2007"))
png(fileOut)
hist(as.numeric(filtered$Global_active_power),xlab="Global Active power (kilowatts)",col="red",main="Global Active Power")
dev.off()
