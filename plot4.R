library(lubridate)

# Date format 
setClass('myDate')
setAs('character', 
      'myDate', 
      function(from) as.Date( from, format = '%d/%m/%Y'))

# Read data
data <- read.csv(
  file = './household_power_consumption.txt', 
  sep= ';',
  header = TRUE,
  colClasses= c('myDate', rep('character', 8) )
)

# Subset data
startDate <- as.Date( '2007-02-01' )
endDate <- as.Date( '2007-02-02' )
int <- new_interval( startDate, endDate )
dataSubset <- data[ data$Date %within% int, ]

# Merge date and time columns
dateTimeCol <- as.POSIXct( paste( dataSubset$Date, dataSubset$Time ), format='%Y-%m-%d %H:%M:%S')

# Plotting 
png(filename = './plot4.png', width = 480, height = 480)
par(
  mfrow = c(2, 2), 
  mar = c(6, 4, 2, 2)
  )

# Global Active Power plot
plot(
  x = dateTimeCol, 
  y = dataSubset$Global_active_power,
  ylab = 'Global Active Power',
  xlab = '',
  pch = '.',
  type = 'n'
)

lines(
  x = dateTimeCol, 
  y = dataSubset$Global_active_power,
)

# Voltage plot
plot(
  x = dateTimeCol,
  y = dataSubset$Voltage,     
  ylab = 'Voltage',
  xlab = 'datetime',
  pch = '.',
  type= 'n'
)

lines(
  x = dateTimeCol, 
  y = dataSubset$Voltage,
)

# Energy sub metering plot
plot(
  x = dateTimeCol,
  y = dataSubset$Sub_metering_1,     
  ylab = 'Energy sub metering',
  xlab = '',
  pch = '.',
  type = 'n'
)

# plotting submetering 1
lines(
  x = dateTimeCol, 
  y = dataSubset$Sub_metering_1,
  col = 'black'
)

# plotting submetering 2
lines(
  x = dateTimeCol, 
  y = dataSubset$Sub_metering_2,
  col = 'red'
)

# plotting submetering 3
lines(
  x = dateTimeCol, 
  y = dataSubset$Sub_metering_3,
  col = 'blue'
)

# Adding a legend
legend(
  'topright', 
  c('Sub_metering_1','Sub_metering_2', 'Sub_metering_3'),
  lty= c(1, 1, 1),
  col= c('black', 'red', 'blue'),
  bty = 'n'
)

# Global Reactive Power plot
plot(
  x = dateTimeCol,
  y = dataSubset$Global_reactive_power,     
  ylab = 'Global_reactive_power',
  xlab = 'datetime',
  pch = '.',
  type= 'n'
)

lines(
  x = dateTimeCol, 
  y = dataSubset$Global_reactive_power,
)

dev.off()