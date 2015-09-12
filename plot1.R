setwd("exdata_data_household_power_consumption")

## Read in the dataset column headings
PowerColsRead <- read.table("household_power_consumption.txt", sep=";", nrows=1, na.strings="?")
PowerCols <- c(PowerColsRead[1:9])
PowerCols[] <- lapply(PowerCols, as.character)

## Read in the relevant rows of the dataset (for dates February 1 & 2, 2007)
FebPower <- read.table("household_power_consumption.txt", sep=";", nrows=2880, skip=66637)

## Apply column headings to these rows
colnames(FebPower) <- PowerCols

## Open PNG graphics device (note: default size is 480 x 480 pixels)
png("plot1.png")

## Create histogram
hist(FebPower$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")

## Close PNG graphics device
dev.off()
