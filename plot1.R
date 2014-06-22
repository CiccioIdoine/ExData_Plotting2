# Read in data
NEI <- readRDS("../summarySCC_PM25.rds")
SCC <- readRDS("../Source_Classification_Code.rds")

# Sum emissions per year and divide for readability
sums <- aggregate(NEI$Emissions, by=list(Year = NEI$year), FUN=sum)

# Create PNG file
png(file = "plot1.png", width = 480, height = 480)

# Plot the data
plot(sums[,1], main="Total emissions from PM2.5 in the United States (1998 to 2008)", ylab="Emissions (in 1000s)")

# Close dev
dev.off()