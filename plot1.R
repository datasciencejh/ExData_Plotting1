#Assignment 1
#Check if file already exists, dont download again
# Plot 1

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
#plot simple histogram
png(filename = "plot1.png", width = 480, height = 480, units = "px")
with(plotdata, hist(Global_active_power, col='red', main="Global Active Power", xlab='Global Active Power (kilowatts)'))
dev.off()

