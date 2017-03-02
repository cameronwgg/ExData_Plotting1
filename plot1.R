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

#Create a histogram

hist(data_subset$Global_active_power,xlab="Global Active Power (kilowatts)",col="red",main="Global Active Power")

#Copy plot to png file

dev.copy(png,file="plot1.png")
dev.off()