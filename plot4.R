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

## plot4
par(mfrow = c(2,2), mar = c(4,4,2,1))
with(df, {
# top left
plot(df$DT, as.numeric(as.character(df$Global_active_power)), type = "l", xlab = "", ylab = "Global Active Power")

# top right
plot(df$DT, as.numeric(as.character(df$Voltage)), type = "l", xlab = "datetime", ylab = "Voltage")

#bottom left
with(df, plot(df$DT, as.numeric(as.character(df$Sub_metering_1)), type = "l", xlab = "", ylab = "Energy Sub metering "))
with(df, lines(df$DT, as.numeric(as.character(df$Sub_metering_2)), col = "red"))
with(df, lines(df$DT, as.numeric(as.character(df$Sub_metering_3)), col = "blue"))
legend("topright", pch = "-", col = c("black","red","Blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Bottom right 
plot(df$DT, as.numeric(as.character(df$Global_reactive_power)), type = "l", xlab = "datetime", ylab = "Global Reactive Power")
} )
dev.copy (png, file="plot4.png")
dev.off()
