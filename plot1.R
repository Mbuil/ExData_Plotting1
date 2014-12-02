## Put data file into R working directory before start

## read data
Alldata <- read.table("household_power_consumption.txt",sep=";",header=TRUE)
## convert Date column
Alldata$Date <- strptime(Alldata$Date,format="%d/%m/%Y")

## subset dataset
data <- Alldata[Alldata$Date>="2007-02-01" & Alldata$Date <="2007-02-02",]
data$Global_active_power <- as.numeric(as.character(data$Global_active_power))

## plot1
par(mar=c(4,4,4,2))
hist(data$Global_active_power,col="red",main="Global Active Power",xlab="Global Active Power (kilowatts)")
dev.copy(png,file="plot1.png",width=480,height=480,units="px")
dev.off()
