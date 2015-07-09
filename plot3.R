
## Warning! If you want to run this script, make sure that you set the working directory
## to the folder where the data file is found

## Suggestion!  You can read only 100 rows first and see how the data looks like such as dimension and colnames
## df<-read.csv2("household_power_consumption.txt", nrows=100)

## It takes only a few seconds to read all data into data frame on my laptop so I didn't do any filtering first using the below command
## df<-read.csv2.sql("household_power_consumption.txt", sql = "select * from file where Date='01/02/2007' || Date='02/02/2007'", eol="\n")
## Note filtering before reading is just a suggestion, not mandatory if you don't have
## problems reading all data into the memory.

## Use read.table to read the file with more options in parameters
## na.strings="?" is used as missing values are quoted as ?
data<-read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings="?",
               colClasses=c("character", "character", rep("numeric",7)))

# Subsetting the rows with Dates = 2007-02-01 or 2007-02-02
data1<-subset(data, Date=="1/2/2007" | Date=="2/2/2007")

# Adding a new DateTime column using the Date and Time variables
# You can leave the Date and Time columns for now
data2<-mutate(data1, DateTime=as.POSIXlt(paste(Date, Time),format = "%d/%m/%Y %H:%M:%S"))
              
# Now the data2 is ready for plotting and output to a PNG file
png("plot3.png", width=480, height=480) # open a PNG file device
plot(data2$DateTime, data2$Sub_metering_1, type="l", col="purple4",ylab="Energy sub metering",xlab="")
lines(data2$DateTime, data2$Sub_metering_2,col="red")
lines(data2$DateTime, data2$Sub_metering_3,col="blue")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col=c("purple4","red","blue"),bg="white",lwd=1)
dev.off() # Always close the device
