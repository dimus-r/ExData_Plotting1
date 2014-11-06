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
with(hh_power, { 
       plot(datetime, Sub_metering_1, type="l", col = "black",
            xlab = "", ylab = "Energy sub metering")
       lines(datetime, Sub_metering_2, type="l", col = "red")
       lines(datetime, Sub_metering_3, type="l", col = "blue")
       legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
              lty = 1, col = c("black", "red", "blue"))
})
# Save to png:
dev.copy(png, "plot3.png")
dev.off()