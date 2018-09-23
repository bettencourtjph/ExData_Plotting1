# Script to plot a composite of data for days 2007/02/01 and 2007/02/02, 
# from the "Individual household electric power consumption Data Set" ( UC Irvine Machine Learning Repository).

library(dplyr)

# Read data

dataFile <- "household_power_consumption.txt"

# We add a variable that is the date-time in POSIXct format

dataHousePC <- read.table(dataFile,header=TRUE,sep = ";", na.strings = "?", nrows = 2075259,
                          colClasses = c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric")) %>% 
  mutate(Datetime <- as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S"))

# Subset data for the days in questions

day1 = as.POSIXct("2007-02-01")
day2 = as.POSIXct("2007-02-03") 

dataHousePCSub <- subset(dataHousePC, dataHousePC$Datetime >= day1 & dataHousePC$Datetime < day2)

# Plot composite to png device

png(filename = "plot4.png",width = 480, height = 480)

par(mfrow=c(2,2)) # Arrange plots in 2 x 2, fill by rows

# (1,1)
with(housepconSub, plot(Datetime, Global_active_power, 
                        col="black",
                        type = "l", 
                        xlab = "",
                        ylab = "Global Active Power (kilowatts)"))
#(1,2)
with(housepconSub, plot(Datetime, Voltage, 
                        col="black",
                        type = "l", 
                        ylab = "Voltage"))
#(2,1)
with(housepconSub, plot(Datetime, Sub_metering_1, 
                        col="black",
                        type = "l",
                        xlab="", 
                        ylab="Energy sub metering"))
with(housepconSub, lines(Datetime, Sub_metering_2, 
                         col="red",
                         type = "l"))
with(housepconSub, lines(Datetime, Sub_metering_3, 
                         col="blue",
                         type = "l"))
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col=c("black","red","blue"), lwd = 1, bty = "n")

#(2,2)
with(housepconSub, plot(Datetime, Global_reactive_power, 
                        col="black",
                        type = "l"))

dev.off()