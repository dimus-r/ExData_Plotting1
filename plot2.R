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
with(hh_power, 
     plot(datetime, Global_active_power, type="l", 
          xlab = "", ylab = "Global Active Power (kilowatts)"))
# Save to png:
dev.copy(png, "plot2.png")
dev.off()