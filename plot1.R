fileURL <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
td <- tempdir()
tf <- tempfile(tmpdir = td, fileext=".zip")
if(!file.exists(tf)){
     download.file(fileURL, tf)
}

unzip(tf)

data <- read.table(".//household_power_consumption.txt", sep=";", header = TRUE)

## plot1
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
df <- subset(data, data$Date > "2007-01-31" & data$Date < "2007-02-03") 
hist(as.numeric(as.character(df$Global_active_power)), col = "red", xlab = "Global Active Power(kilowatt)", main="Global Active Power")
dev.copy (png, file="plot1.png")
dev.off()
