## plot1.R
## Histogram of Global Active Power, 1 and 2 February 2007

## Download and unzip the data if not already present
zipFile  <- "household_power_consumption.zip"
dataFile <- "household_power_consumption.txt"
if (!file.exists(dataFile)) {
    if (!file.exists(zipFile)) {
        download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                      destfile = zipFile, mode = "wb")
    }
    unzip(zipFile)
}

## Read the full dataset (missing values are coded as "?")
power <- read.table(dataFile, header = TRUE, sep = ";", na.strings = "?",
                    colClasses = c("character", "character", rep("numeric", 7)))

## Keep only 2007-02-01 and 2007-02-02
power <- subset(power, Date %in% c("1/2/2007", "2/2/2007"))

## Plot to PNG
png("plot1.png", width = 480, height = 480)
hist(power$Global_active_power, col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")
dev.off()
