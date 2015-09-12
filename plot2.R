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
png("plot2.png")

## Create line plot of date-time vs. Global Active Power
plot(newFeb$date.time,newFeb$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")

## Close PNG graphics device
dev.off()







