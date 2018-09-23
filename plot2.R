# Script to plot the time series of global active power for days 2007/02/01 and 2007/02/02, 
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

# Plot time series to png device

png(filename = "plot2.png",width = 480, height = 480)
with(housepconSub, plot(Datetime, Global_active_power, 
                        col="black",
                        type = "l", 
                        xlab = "",
                        ylab = "Global Active Power (kilowatts)"))
dev.off()
