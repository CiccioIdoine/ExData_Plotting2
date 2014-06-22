# Read in data
NEI <- readRDS("../summarySCC_PM25.rds")
SCC <- readRDS("../Source_Classification_Code.rds")

# Loading library ggplot2
library(ggplot2)

# Subset data for Baltimore
subBaltimore = subset(NEI, fips == "24510")

# Split data into subsets from types of source and sum them
typeBaltimore = aggregate(Emissions ~ type + year, sum, data=subBaltimore)

# Create PNG file
png(file = "plot3.png")

# Plot the data
#ggplot(typeBaltimore, aes(x = factor(year), y = Emissions, fill=type)) + geom_bar(stat="identity", position="dodge") + ggtitle("Emissions per type from 1999 - 2008") + xlab("Year")

ggplot(typeBaltimore, aes(x=year, y=Emissions, group=type, colour=type)) +
    geom_line() +
    xlab("Year") +
    ylab("PM2.5 (tons)") +
    ggtitle("PM2.5 vs. Year by Source Type")

# Close dev
dev.off()