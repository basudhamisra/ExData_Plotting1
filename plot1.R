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
## Plotting Histogram
##---------------------------------------------------------------------------
png("plot1.png", width = 480, height = 480, units = "px", bg = "white")
par(mar= c(4, 4, 2, 1))
hist(hpcuse[,3], col = "red", 
	xlab = "Global Active Power (kilowatts)",main ="Global Active Power")

dev.off()















