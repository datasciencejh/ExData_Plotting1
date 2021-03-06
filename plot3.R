#Assignment 1
#Check if file already exists, dont download again
# Plot 3

if (! file.exists(".\\data\\household_power_consumption.txt" ))
{
  
  
  url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(url,destfile = ".\\data\\householdpowerconsumption.zip")
  unzip(".\\data\\householdpowerconsumption.zip" , exdir =  ".\\data")
  
}
#load data to data frame
alldata <- read.table(".\\data\\household_power_consumption.txt" , sep =";" ,header = TRUE)

#subset data for 2 interested date
plotdata <- subset(alldata, Date == '1/2/2007' | Date == '2/2/2007')

#data type conversion
plotdata[,1]<- as.Date(plotdata[,1],  "%d/%m/%Y" )
for (i in 3:8){
  plotdata[,i] <- suppressWarnings(as.numeric( levels(plotdata[,i])[plotdata[,i]]))
  
}
# add datetime
plotdata$datetime = as.POSIXct(paste(plotdata$Date,plotdata$Time))

png(filename = "plot3.png", width = 480, height = 480, units = "px")

# master plot
plot(plotdata$datetime, plotdata$Sub_metering_1,  type='n',main='', xlab='', ylab='Energy sub metering')
#  generate lines
lines(plotdata$datetime, plotdata$Sub_metering_1, type='l',  col='black')

lines(plotdata$datetime, plotdata$Sub_metering_2, type='l', col='red')

lines(plotdata$datetime, plotdata$Sub_metering_3, type='l', col='blue')
# Change legends on top right
legend('topright', lty=1, lwd=1, col=c('black','red','blue'), legend=c('Sub_metering_1','Sub_metering_2','Sub_metering_3'))

dev.off()

