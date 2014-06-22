# Read in data
NEI <- readRDS("../summarySCC_PM25.rds")
SCC <- readRDS("../Source_Classification_Code.rds")

# Subset data for Baltimore
subBaltimore = subset(NEI, fips == "24510")

# Sum emissions per year
sumsBaltimore <- aggregate(subBaltimore$Emissions, by=list(Year = subBaltimore$year), sum)

# Create PNG file
png(file = "plot2.png")

# Plot the data
plot(sumsBaltimore[,1], sumsBaltimore[,2], type="l", xlab="Year", ylab="PM2.5 (tons)", main="Total emissions from PM2.5 in Baltimore (1998 to 2008)")

# Close dev
dev.off()