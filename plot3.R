##---------------------------------------------------------------------------
## Reading txt file
##---------------------------------------------------------------------------
hpc <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")


##---------------------------------------------------------------------------
##date and time are pasted in a single column name datetime
## Proper class is given to it
##---------------------------------------------------------------------------

hpc$Date <- as.Date(hpc$Date, format = "%d/%m/%Y")
hpc$datetime <- paste(hpc$Date, hpc$Time)
hpc$datetime <- as.POSIXlt(hpc$datetime)


##---------------------------------------------------------------------------
## Subsetting dataframe with given dates
##---------------------------------------------------------------------------
hpcuse <- subset(hpc, Date >= "2007-02-01" & Date <= "2007-02-02")


##---------------------------------------------------------------------------
## Replacing "?" with "NA" and removing "NA"s
##---------------------------------------------------------------------------
for(i in 3:9){
hpcuse[,i] <- gsub("[?]", NA, hpcuse[,i])
}
hpcuse <- na.omit(hpcuse) 


##---------------------------------------------------------------------------
## Changing the classes of column 3-9 into numeric
##---------------------------------------------------------------------------
for(i in 3:9){
hpcuse[,i] <- as.numeric(as.character(hpcuse[,i]))
}

##---------------------------------------------------------------------------
## Plotting 
##10th column of hpcuse is datetime column which I produced
## 7th column of hpcuse is Sub_metering_1
## 8th column of hpcuse is Sub_metering_2
## 9th column of hpcuse is Sub_metering_3
##---------------------------------------------------------------------------
png("plot3.png", width = 480, height = 480, units = "px", bg = "white")
par(mar= c(4, 4, 2, 1))

plot(hpcuse[,10],hpcuse[,7],ylab = "Energy sub metering", xlab = NA,
	 type = "n")
lines(hpcuse[,10][order(hpcuse[,10])], hpcuse[,7][order(hpcuse[,10])],
	 col = "black")
lines(hpcuse[,10][order(hpcuse[,10])], hpcuse[,8][order(hpcuse[,10])], 
	 col = "red")
lines(hpcuse[,10][order(hpcuse[,10])], hpcuse[,9][order(hpcuse[,10])],
	 col = "blue")
legend("topright", lty = c(1,1,1), col = c("black","red","blue"),
	 legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

dev.off()




