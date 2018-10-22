# IV Exploratory Data Analysis
# Week 1
# Peer-graded Assignment
#
# Plotting Assignment 1, Plot 4 - Multiple charts including Voltage
#
# Calls .R-script from the present working directory,
# File plot?.png will be written to present working directory,
# Uses /data for downloading and unzipping the dataset.


# Source / Presets
zipUrl = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipFile = "data/exdata_data_household_power_consumption.zip"
dataFile = "data/household_power_consumption.txt"

# Retrive zipfile and unpack data
if (!file.exists("data")){
        dir.create("data")
                } else {
                        print("Data directory already exists.")
}
if (!file.exists(zipFile)) {
        download.file(zipUrl, destfile = zipFile, method = "curl")
        dateDownloaded <- date()
                } else {
                        print("Zipped data file already downloaded.")
}
if (!file.exists(dataFile)) {
        unzip(zipFile, exdir = "data")
                } else {
                        print("Dataset already unzipped.")
}


# Import data
print("Importing data...")
DF <- read.csv(dataFile,
               sep = ";",
               header = TRUE,
               stringsAsFactors = FALSE)
print("...done.")


# Reformat data and subset
Sys.setlocale("LC_TIME", "en_US.UTF8") #use english weekdays
print("Reformatting data...")
DF$Date <- as.Date(DF$Date, format = "%d/%m/%Y")
wantedDF <- subset(DF, Date >= "2007-02-01" & Date <= "2007-02-02")
wantedDF$Time <- strptime(paste(wantedDF$Date, wantedDF$Time), "%Y-%m-%d %H:%M:%S")
print("Date/time data reformatted.")

wantedDF$Global_active_power <- as.numeric(wantedDF$Global_active_power)
wantedDF$Global_reactive_power <- as.numeric(wantedDF$Global_reactive_power)
wantedDF$Voltage <- as.numeric(wantedDF$Voltage)
wantedDF$Global_intensity <- as.numeric(wantedDF$Global_intensity)
wantedDF$Sub_metering_1 <- as.numeric(wantedDF$Sub_metering_1)
wantedDF$Sub_metering_2 <- as.numeric(wantedDF$Sub_metering_2)
# wantedDF$Sub_metering_3 <- as.numeric(wantedDF$Sub_metering_3) <<- is already numeric


# create Plot 4 as PNG
png(filename = "plot4.png",
     width = 480,
     height = 480)

par(mfcol = c(2, 2))

# Plot 4.1 Global Active Power (= Plot 1)

with(wantedDF, plot(Time, Global_active_power,
                    type = "l",
                    xlab = "",  
                    ylab = "Global Active Power"))

# Plot 4.2 Energy sub metering

with(wantedDF, plot(Time, Sub_metering_1,
                    type = "l",
                    col = "black",
                    xlab = "",
                    ylab = "Energy sub metering"))
with(wantedDF, lines(Time, Sub_metering_2,
                     type = "l",
                     col = "red"))
with(wantedDF, lines(Time, Sub_metering_3,
                     type = "l",
                     col = "blue"))
legend("topright",
       bty = "n",
       lty = 1,
       col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Plot 4.3 Voltage

with(wantedDF, plot(Time, Voltage,
                    type = "l",
                    xlab = "datetime"))

# Plot 4.4 Global_reactive_power

with(wantedDF, plot(Time, Global_reactive_power,
                    type = "l",
                    xlab = "datetime"))

dev.off()

print("File plot4.png created.")
