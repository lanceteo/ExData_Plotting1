##Download the required data and read this into R

if(!file.exists("./data")) {dir.create("./data")} ##create directory "data" if it does not exist in wd

fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileurl, destfile="./data/Dataset.zip")

unzip(zipfile="./data/Dataset.zip",exdir="./data")

fileloc <- file.path("./data")
files <- list.files(fileloc)

##Read data into R
class <- c("character","character",rep("numeric",7))
data <- read.table(file.path(fileloc,"household_power_consumption.txt"),sep=";",header=TRUE,
                   stringsAsFactors=FALSE,colClasses=class,na.strings="?")

##Subset into required date range and change the format of Date and Time
data2 <- subset(data,data$Date %in% c('1/2/2007','2/2/2007'))
data2$date_time <- strptime(paste(data2$Date,data2$Time),format="%d/%m/%Y %H:%M:%S")

#Plotting the Graph

par(mfrow=c(2,2))
plot(data2$date_time,data2$Global_active_power,type='l',xlab='',ylab='Global Active Power')
plot(data2$date_time,data2$Voltage,type='l',xlab='datetime',ylab='Voltage')
plot(data2$date_time,data2$Sub_metering_1,type='n',xlab='',ylab='Energy sub metering')
points(data2$date_time,data2$Sub_metering_1,type='l')
points(data2$date_time,data2$Sub_metering_2,type='l',col='red')
points(data2$date_time,data2$Sub_metering_3,type='l',col='blue')
legend('topright',c('Sub_metering_1','Sub_metering_2','Sub_metering_3'),lty=1,col=c('black','red','blue'),box.lty=0)
plot(data2$date_time,data2$Global_reactive_power,type='l',xlab='datetime',ylab='Global_reactive_power')


#Saving the Plot into "plot4.png"
dev.copy(png,file="plot4.png")
dev.off()