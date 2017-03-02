##Download and unzip the file

if(!file.exists("plotdata")){
  dir.create("plotdata")
}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

download.file(fileUrl,destfile="./plotdata/plotdata.zip",method="curl")

unzip("./plotdata/plotdata.zip",exdir="./plotdata") 

##Read in the data and subset only the relevant dates

data <- read.table("./plotdata/household_power_consumption.txt",header=TRUE,sep=";")

data_subset <- data[which(data$Date=='1/2/2007' 
                          | data$Date=='2/2/2007'),]

##Make Global_active_power into a numeric vector so it can be plotted

data_subset$Global_active_power <- as.numeric(as.character(data_subset$Global_active_power))

##Reformat Date variable and merge with Time variable into new column (newdate) for plotting purposes

data_subset$Date <- strptime(data_subset$Date,"%d/%m/%Y")
data_subset$newdate <- as.POSIXct(paste(data_subset$Date, data_subset$Time), format="%Y-%m-%d %H:%M:%S") 

##Create a line graph

plot(data_subset$newdate,data_subset$Global_active_power,xlab=NA,ylab="Global Active Power (kilowatts)",pch=NA)
lines(data_subset$newdate,data_subset$Global_active_power)

##Copy plot to png file

dev.copy(png,file="plot2.png")
dev.off()