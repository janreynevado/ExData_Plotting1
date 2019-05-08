library(data.table)

#Loading and Cleaning the Data
fileURL = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if (!file.exists('./exdata data household_power_consumption.zip')){
        download.file(fileURL, './exdata data household_power_consumption.zip', mode = 'wb')
        unzip("exdata data household_power_consumption.zip", exdir = getwd())
}
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))
data$Date <- as.Date(data$Date, "%d/%m/%Y")
data <- subset(data, Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))
data <- data[complete.cases(data),]
DateTime <- paste(data$Date, data$Time)
DateTime <- setNames(DateTime, "DateTime")
data <- data[, !(names(data) %in% c("Date", "Time"))]
data <- cbind(DateTime, data)
data$DateTime <- as.POSIXct(DateTime)

#Creating Plot 2 and saving it to PNG format
plot(data$Global_active_power~data$DateTime, type = "l" , xlab = "", ylab = "Global Active Power (kilowatts)")
dev.copy(png,"plot2.png", width = 480, height = 480)
dev.off()