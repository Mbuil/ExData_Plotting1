## Put data file into R working directory before start

## read data
Alldata <- read.table("household_power_consumption.txt",sep=";",header=TRUE)
## convert Date column
Alldata$Date <- strptime(Alldata$Date,format="%d/%m/%Y")

## subset dataset
data <- Alldata[Alldata$Date>="2007-02-01" & Alldata$Date <="2007-02-02",]
data$Global_active_power <- as.numeric(as.character(data$Global_active_power))

## For Time column, strptime() will automatically add today's date before all
## times, which can leads to confusion when calculating
## e.g., try: test <- strptime(Alldata$Time,format="%H:%M:%S")
## need to separate the time for Feb 1 and time for Feb 2
library(lubridate)
feb1 <- data[data$Date=="2007-02-01",]
feb2 <- data[data$Date=="2007-02-02",]
time1 <- strptime(feb1$Time,format="%H:%M:%S")
time2 <- time1+hms("24:00:00")
# use hms() to convert string into time format, then add 24 hours to time1
newtime <- c(time1,time2)
data$Time <- newtime

## plot2
a <- as.numeric(data$Time)
par(mar=c(4,4,4,2))
# use xaxt='n' argument to eliminate tick marks in x axis
plot(data$Global_active_power~a,type="l",ylab="Global Active Power (kilowatts)",xlab="",xaxt='n')
# add new tick marks
axis(side=1,labels=c("Thu","Fri","Sat"),at=c(min(a),median(a),max(a)))
# save to file
dev.copy(png,file="plot2.png",width=480,height=480,units="px")
dev.off()
