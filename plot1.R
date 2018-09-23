# Script to plot the histogram of global active power for days 2007/02/01 and 2007/02/02, 
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

# Plot histogram to png device

png(filename = "plot1.png",width = 480, height = 480)
with(housepconSub, hist(Global_active_power, col="red",
                        main = "Global active power", xlab = "Global Active Power (kilowatts)", ylim=c(0,1200)))
dev.off()
