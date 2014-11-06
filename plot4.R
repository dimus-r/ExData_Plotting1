# Download and unzip data.
file_url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(file_url, destfile = "hh_power.zip", mode = "wb")
unzip("hh_power.zip")
# Prepare data for analysis:
hh_power = read.table("household_power_consumption.txt", header = TRUE, 
                      sep = ";", stringsAsFactors = FALSE, na.strings = "?")
hh_power[,1] <- as.Date(hh_power[,1], format = "%d/%m/%Y")
hh_power <- hh_power[hh_power$Date >= "2007-02-01" & hh_power$Date <= "2007-02-02",]
hh_power$datetime <- as.POSIXct(strptime(paste(format(hh_power[,1]), hh_power[,2]), 
                                         format = "%Y-%m-%d %H:%M:%S"))
###########################################################################
## Draw something:
png(filename = "plot4.png")
par(mfrow = c(2, 2), oma = c(1, 1, 0, 0), mar = c(5, 4, 2, 2))
with(hh_power, { 
    # top left plot (plot 2)
    plot(datetime, Global_active_power, type="l", 
         xlab = "", ylab = "Global Active Power (kilowatts)")
    # top right plot
    plot(datetime, Voltage, type="l")
    # bottom left plot (plot 3)
    plot(datetime, Sub_metering_1, type="l", col = "black",
         xlab = "", ylab = "Energy sub metering")
    lines(datetime, Sub_metering_2, type="l", col = "red")
    lines(datetime, Sub_metering_3, type="l", col = "blue")
    legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
           lty = 1, col = c("black", "red", "blue"))
    # bottom right plot
    plot(datetime, Global_reactive_power, type="l")
})
dev.off()