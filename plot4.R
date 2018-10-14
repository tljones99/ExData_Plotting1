#Plot 4
# Reading, naming, and subsetting the power consumption data
power <- read.table("household_power_consumption.txt",skip=1,sep=";")
names(power) <- c("Date","Time","Global_active_power","Global_reactive_power",
                  "Voltage","Global_intensity","Sub_metering_1","Sub_metering_2",
                  "Sub_metering_3")
powerUse <- subset(power,power$Date=="1/2/2007" | power$Date =="2/2/2007")

# Converting the Date and Time vars from characters into Date and POSIXlt 
powerUse$Date <- as.Date(powerUse$Date, format="%d/%m/%Y")
powerUse$Time <- strptime(powerUse$Time, format="%H:%M:%S")
powerUse[1:1440,"Time"] <- format(powerUse[1:1440,"Time"],"2007-02-01 %H:%M:%S")
powerUse[1441:2880,"Time"] <- format(powerUse[1441:2880,"Time"],"2007-02-02 %H:%M:%S")


# Initiating a composite plot for a quad set of graphs
par(mfrow=c(2,2))

#Calling the basic plot function for the different plot functions that build the 4 plots 
with(powerUse,{
  plot(powerUse$Time, as.numeric(as.character(powerUse$Global_active_power)), type="l",  
       xlab="", ylab="Global Active Power")  
  plot(powerUse$Time, as.numeric(as.character(powerUse$Voltage)), type="l", 
       xlab="datetime", ylab="Voltage")
  plot(powerUse$Time, powerUse$Sub_metering_1, type="n", 
       xlab="", ylab="Energy sub metering")
    with(powerUse, lines(Time, as.numeric(as.character(Sub_metering_1))))
    with(powerUse, lines(Time, as.numeric(as.character(Sub_metering_2)), col="red"))
    with(powerUse, lines(Time, as.numeric(as.character(Sub_metering_3)), col="blue"))
    legend("topright", lty=1, col=c("black","red","blue"),
           legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), cex = 0.6)
  plot(powerUse$Time, as.numeric(as.character(powerUse$Global_reactive_power)), type="l", 
       xlab="datetime", ylab="Global_reactive_power")
})

## Create a png file (480 * 480)
dev.print(png, file="plot4.png", width = 480, height = 480)

