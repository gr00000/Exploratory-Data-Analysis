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

# Plot 2

plot(power_consumption$Global_active_power~power_consumption$Full_date, type="l", ylab="Global Active Power (kilowatts)", xlab="")

# Write to .png

dev.copy(png, file="plot2.png", height=480, width=480) 














