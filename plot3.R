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

## plot3
a <- as.numeric(data$Time)
sub1 <- as.numeric(as.character(data$Sub_metering_1))
sub2 <- as.numeric(as.character(data$Sub_metering_2))
sub3 <- as.numeric(as.character(data$Sub_metering_3))

#to print using screen device, first input: windows(width=10,height=8)
# the windows() step is to open a plot of the exact size you need before plotting
# this prevents manually widened plot window
# see http://stackoverflow.com/questions/15436720/legend-box-width-not-correct-when-using-par?rq=1
# for more

# however, dev.copy was giving me trouble of inaccurate copy, so save to file directly

png("plot3.png")
par(mar=c(2.5,4,1,1))
plot(sub1~a,type="l",ylab="Energy sub metering",xlab="",xaxt='n')
lines(a,sub2,col="red")
lines(a,sub3,col="blue")
axis(side=1,labels=c("Thu","Fri","Sat"),at=c(min(a),median(a),max(a)))
legend("topright",lty=1,col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),xjust=1,cex=1)
dev.off()
