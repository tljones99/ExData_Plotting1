#Plot 3
##Reading, naming, and subsetting the power consumption data
power <- read.table("household_power_consumption.txt",skip=1,sep=";")
names(power) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage",
                  "Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
powerUse <- subset(power,power$Date=="1/2/2007" | power$Date =="2/2/2007")

## Change the Date/TIme vars from characters into Date and POSIXLt 

powerUse$Date <- as.Date(powerUse$Date, format="%d/%m/%Y")
powerUse$Time <- strptime(powerUse$Time, format="%H:%M:%S")
powerUse[1:1440,"Time"] <- format(powerUse[1:1440,"Time"],"2007-02-01 %H:%M:%S")
powerUse[1441:2880,"Time"] <- format(powerUse[1441:2880,"Time"],"2007-02-02 %H:%M:%S")

## Call in the basic plot function
plot(powerUse$Time,powerUse$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
with(powerUse,lines(Time,as.numeric(as.character(Sub_metering_1))))
with(powerUse,lines(Time,as.numeric(as.character(Sub_metering_2)),col="red"))
with(powerUse,lines(Time,as.numeric(as.character(Sub_metering_3)),col="blue"))
legend("topright",lty=1, col=c("black","red","blue"),
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

title(main = "Plot 3")

## Create a png file (480 * 480)
dev.print(png, file="plot3.png", width = 480, height = 480)
