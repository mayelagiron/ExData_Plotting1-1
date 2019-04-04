# LOAD DATA

rm(list = ls())
data <- read.table("household_power_consumption.txt", header = T, sep = ";", na.strings = "?")

# Convert DATA VARIABLE to DATE CLASS

data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

# Subset

data <- subset(data, subset = (Date >= "2007-02-01" & Date <= "2007-02-02"))

# Convert date and time

data$datetime <- strptime(paste(data$Date, data$Time), "%Y-%m-%d %H:%M:%S")
data$datetime <- as.POSIXct(data$datetime)

# Plot 

attach(data)
plot(Sub_metering_1 ~ datetime, type = "l", ylab = "Energy sub metering", xlab = "")
lines(Sub_metering_2 ~ datetime, col = "Red")
lines(Sub_metering_3 ~ datetime, col = "Blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Save

dev.copy(png, file = "plot3.png", height = 480, width = 480)
dev.off()
detach(data)