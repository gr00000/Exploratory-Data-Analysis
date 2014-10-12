#Set system locale to English

Sys.setlocale("LC_TIME", "English")

# Read the data

power_consumption<-read.csv("household_power_consumption.txt", header=T, sep=';', na.strings="?", 
                            nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')

# Set date and "Global Active Power"

power_consumption$Date<-as.Date(strptime(power_consumption$Date,"%d/%m/%Y"))
power_consumption<-subset(power_consumption, Date>as.Date(strptime("31/01/2007","%d/%m/%Y")) & Date<as.Date(strptime("03/02/2007","%d/%m/%Y")))
power_consumption$Global_active_power<-as.numeric(as.character(power_consumption$Global_active_power))
Full_date<-paste(power_consumption$Date,power_consumption$Time,sep=" ")
power_consumption<-cbind(power_consumption,Full_date)
power_consumption$Full_date<-as.POSIXct(strptime(power_consumption$Full_date,"%Y-%m-%d %H:%M:%S"))

# Plot 3

with(power_consumption, {
        plot(Sub_metering_1~Full_date,type="l",col='Black',
             ylab="Energy sub metering", xlab="")
        lines(Sub_metering_2~Full_date,col='Red')
        lines(Sub_metering_3~Full_date,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Write to .png

dev.copy(png, file="plot3.png", height=640, width=640)

