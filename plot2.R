## plot2.R
## Global Active Power over time, 1 and 2 February 2007

## Use English weekday labels (Thu, Fri, Sat)
Sys.setlocale("LC_TIME", "C")

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

## Combine Date and Time into a date/time variable
power$DateTime <- as.POSIXct(strptime(paste(power$Date, power$Time),
                                      format = "%d/%m/%Y %H:%M:%S"))

## Plot to PNG
png("plot2.png", width = 480, height = 480)
plot(power$DateTime, power$Global_active_power, type = "l",
     xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()
