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

# Plot 4

par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(power_consumption, {
        plot(Global_active_power~Full_date, type="l", 
             ylab="Global Active Power", xlab="")
        plot(Voltage~Full_date, type="l", 
             ylab="Voltage", xlab="datetime")
        plot(Sub_metering_1~Full_date, type="l", 
             ylab="Energy sub metering", xlab="")
        lines(Sub_metering_2~Full_date,col='Red')
        lines(Sub_metering_3~Full_date,col='Blue')
        legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
               legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        plot(Global_reactive_power~Full_date, type="l", 
             ylab="Global Reactive Power",xlab="datetime")
})

# Write to .png

dev.copy(png, file="plot4.png", height=640, width=640)

