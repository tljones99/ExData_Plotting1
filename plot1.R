## Plot 1
## Read the consumption data
power <- read.table("~./household_power_consumption.txt", skip=1, sep=";")
names(power) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", 
                  "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", 
                  "Sub_metering_3")
subpower <- subset(power, power$Date=="1/2/2007" | power$Date == "2/2/2007")

## call in the basic plot funciton
hist(as.numeric(as.character(subpower$Global_active_power)), col="red", 
     main="Global Active Power", xlab = "Global Active Power (kilowatts")

## add title to graph
title(main = "Global Active Power")

## Create a png file (480 * 480)
dev.print(png, file="plot1.png", width = 480, height = 480)

