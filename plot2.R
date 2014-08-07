fileURL <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
td <- tempdir()
tf <- tempfile(tmpdir = td, fileext=".zip")
if(!file.exists(tf)){
     download.file(fileURL, tf)
}

unzip(tf)

data <- read.table(".//household_power_consumption.txt", sep=";", header = TRUE)
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
df <- subset(data, data$Date > "2007-01-31" & data$Date < "2007-02-03")
df$DT <- paste(df$Date, df$Time)
df$DT <- strptime(df$DT, "%Y-%m-%d %H:%M:%S") 

## plot2 
with(df, plot(df$DT, as.numeric(as.character(df$Global_active_power)), type = "l", xlab = "", ylab = "Global Active Power(kilowatt)"))
dev.copy (png, file="plot2.png")
dev.off()
