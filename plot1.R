library(lubridate)

# Date format 
setClass('myDate')
setAs('character', 'myDate', function(from) as.Date( from, , format = '%d/%m/%Y'))

# Read data
data <- read.csv(
  file = './household_power_consumption.txt', 
  sep= ';',
  header = TRUE,
  colClasses= c( 'myDate', rep('character', 8) )
  )

# Subset data
startDate <- as.Date( '2007-02-01' )
endDate <- as.Date( '2007-02-02' )
int <- new_interval( startDate, endDate )
dataSubset <- data[ data$Date %within% int, ]

# Plot
png(filename = './plot1.png', width = 480, height = 480)
par(mar = rep(6, 6, 4, 1))
hist( 
  as.numeric(dataSubset$Global_active_power), 
  col = 'red', 
  xlab = 'Global Active Power (kilowatts)', 
  ylab = 'Frequency',  
  main = 'Global Active Power')
dev.off()