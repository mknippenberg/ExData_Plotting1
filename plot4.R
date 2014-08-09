


#### Load Data ####
setwd("~/Repos/ExData_Plotting1")
if(!file.exists("./data")){dir.create("./data")}

## Header labels
h <- c("Date", "Time", "Global_active_power", "Global_reactive_power",
       "Voltage", "Global_intensity", "Sub_metering_1", 
       "Sub_metering_2", "Sub_metering_3")

## If the file isn't downloaded, then download it, regardless load the 
## 2880 rows for the 2 days of interest
if(!file.exists("./data/household_power_consumption.txt")){
    fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(fileUrl,destfile="./data/electricity.zip",method="curl")
    unzip("./data/electricity.zip", exdir = "./data")
    data <- read.table("./data/household_power_consumption.txt", 
                       header = F, sep = ";", na.strings = c("NA", "?"), 
                       skip = 66637, nrows = 2880, col.names = h)
} else {
    data <- read.table("./data/household_power_consumption.txt", 
                       header = F, sep = ";", na.strings = c("NA", "?"), 
                       skip = 66637, nrows = 2880, col.names = h)
}

## Subset the data to the day of interest
## This code helped determine the skip and nrows values for the load 
## function but isn't needed for the plot
'
sdata[,1] <- as.Date(data[,1], format = "%d/%m/%Y")
feb <- subset(data, (data$Date == "2007-02-01" | data$Date == "2007-02-02"))
strptime(feb$Time, format = "%H:%M:%S") 
'

## Concatenate time into date and format
data$Date <- strptime(paste(data$Date,data$Time), "%d/%m/%Y %H:%M:%S")


## Start PNG graphics device
png(filename = "plot4.png")
par(mfrow = c(2,2))
## Top Left plot
plot(data$Date, data$Global_active_power, ylab = "Global Active Power",
     type = "l", xlab = "")

## Top Right plot
plot(data$Date, data$Voltage, ylab = "Voltage", xlab = "datetime",
     type = "l")
## Bottom Left plot
plot(data$Date, data$Sub_metering_1, ylab = "Energy sub metering",
     type = "l", xlab = "")
lines(data$Date, data$Sub_metering_2,  col ="red")
lines(data$Date, data$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", 
        "Sub_metering_3"), col = c("black", "red", "blue"),
       lty = 1, lwd = 1, bty = "n")

## Bottom Right plot
plot(data$Date, data$Global_reactive_power, 
     ylab = "Global_reactive_power", xlab = "datetime",
     type = "l")
## Close graphics device
dev.off()

