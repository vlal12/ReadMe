library(dplyr)
library(lubridate)

all_data<-read.table("household_power_consumption.txt", sep=";", header=TRUE, stringsAsFactors=FALSE)
tidydata<-filter(all_data, Date=="2/2/2007"|Date=="1/2/2007")
# t<-sapply(tidydata, is.factor)
# tidydata[t]<-lapply(tidydata[t], as.character)
tidydata$newdate<-dmy_hms(paste(tidydata$Date, tidydata$Time))
tidydata$datetime<-as.POSIXlt(tidydata$newdate)

plot(tidydata$datetime, tidydata$Global_active_power, xlab="", ylab="Global Active Power", type="l", cex=5)
dev.copy(png, file="plot2.png")
dev.off()