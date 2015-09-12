setwd("exdata_data_household_power_consumption")

## Read in the dataset column headings
PowerColsRead <- read.table("household_power_consumption.txt", sep=";", nrows=1, na.strings="?")
PowerCols <- c(PowerColsRead[1:9])
PowerCols[] <- lapply(PowerCols, as.character)

## Read in the relevant rows of the dataset (for dates February 1 & 2, 2007)
FebPower <- read.table("household_power_consumption.txt", sep=";", nrows=2880, skip=66637)

## Apply column headings to these rows
colnames(FebPower) <- PowerCols

## Create a new column with combined date and time
newdate <- as.Date(FebPower$Date, "%d/%m/%Y")     ## Parse the date format
tempcol <- paste(newdate,FebPower$Time)           ## Append the time to the date
date.time <- strptime(tempcol, format="%Y-%m-%d %H:%M:%S")     ## Turn it into a POSIXlt object
newFeb <- cbind(date.time,FebPower)               ## Add this column to the dataset

## Open PNG graphics device (note: default size is 480 x 480 pixels)
png("plot4.png")

## Set up 2 x 2 format for the four graphs (to be filled column-wise)
par(mfcol=c(2,2))

## 1st graph: Create line plot of date-time vs. Global Active Power
plot(newFeb$date.time,newFeb$Global_active_power, type="l", xlab="", ylab="Global Active Power")

## 2nd graph: Create overlaid line plot of date-time vs. the three sub-metering values, with legend (not in a box)
plot(newFeb$date.time,newFeb$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(newFeb$date.time,newFeb$Sub_metering_2, type="l", col="red", xlab="", ylab="")
lines(newFeb$date.time,newFeb$Sub_metering_3, type="l", col="blue", xlab="", ylab="")
legend("topright", lty=1, col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),bty="n")

## 3rd graph: Create line plot of voltage over time
plot(newFeb$date.time,newFeb$Voltage, type="l", xlab="datetime", ylab="Voltage")

## 4th graph: Create line plot of Global reactive power over time
plot(newFeb$date.time,newFeb$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

## Close PNG graphics device
dev.off()

