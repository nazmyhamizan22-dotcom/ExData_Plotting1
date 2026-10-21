## plot4.R
## Four panel plot, 1 and 2 February 2007

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
png("plot4.png", width = 480, height = 480)
par(mfrow = c(2, 2))

## Top left: Global Active Power
plot(power$DateTime, power$Global_active_power, type = "l",
     xlab = "", ylab = "Global Active Power")

## Top right: Voltage
plot(power$DateTime, power$Voltage, type = "l",
     xlab = "datetime", ylab = "Voltage")

## Bottom left: Energy sub metering
plot(power$DateTime, power$Sub_metering_1, type = "l", col = "black",
     xlab = "", ylab = "Energy sub metering")
lines(power$DateTime, power$Sub_metering_2, col = "red")
lines(power$DateTime, power$Sub_metering_3, col = "blue")
legend("topright", lty = 1, bty = "n", col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Bottom right: Global Reactive Power
plot(power$DateTime, power$Global_reactive_power, type = "l",
     xlab = "datetime", ylab = "Global_reactive_power")

dev.off()
