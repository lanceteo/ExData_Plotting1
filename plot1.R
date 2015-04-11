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

#Plotting the Histogram
hist(data2$Global_active_power,
     xlab="Global Active Power (kilowatts)",
     main="Global Active Power",
     col="red")

#Saving the Plot into "plot1.png"
dev.copy(png,file="plot1.png",width=480,height=480)
dev.off()