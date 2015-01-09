# load required libraries 
library(grDevices) 

# I'm in Finland so I set locale -- just in case 
Sys.setlocale("LC_TIME", "English") 


# download file and unzip it 
if( !file.exists("household_power_consumption.txt")) 
{ 
    download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",  
                  "data.zip",  
                  mode="wb")
    
    unzip("data.zip") 
} 

# read data to memory
data <- read.table("household_power_consumption.txt", header=TRUE, sep = ";", na.strings = "?",  
                   colClasses=c("character","character","numeric","numeric", 
                                "numeric","numeric","numeric","numeric", "numeric")
) 

# select desired dates for graphic analyses 
data <- subset(data, as.Date(data[,"Date"], "%d/%m/%Y") >= as.Date("01/02/2007", "%d/%m/%Y") &  
                   as.Date(data[,"Date"], "%d/%m/%Y") <= as.Date("02/02/2007", "%d/%m/%Y")) 

# create timestamp column from date and time
data$Datetime <- strptime(paste(data[,"Date"], data[,"Time"]), "%d/%m/%Y %H:%M:%S")

# Define png
png(filename = "plot3.png",  
    width = 504,  
    height = 504,  
    units = "px"  
    ) 

plot(data$Datetime, data$Sub_metering_1, type="l", col="black", xlab="", ylab="Energy sub metering") 
points(data$Datetime, data$Sub_metering_2, type="l", col="red") 
points(data$Datetime, data$Sub_metering_3, type="l", col="blue") 
legend("topright",  col=c("black", "red", "blue"),  
    legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty="solid") 
 

dev.off() 





