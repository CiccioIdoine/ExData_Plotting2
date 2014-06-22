# Read in data
NEI <- readRDS("../summarySCC_PM25.rds")
SCC <- readRDS("../Source_Classification_Code.rds")

# Loading library ggplot2
library(ggplot2)

# Match coal combustion in short.name column of classification file and retrieve them in the data
coalSCC <- SCC[grepl("comb .* coal", SCC$Short.Name, ignore.case=TRUE),]
coalNEI <- subset(NEI, SCC %in% coalSCC$SCC)

# Sum the data per year
coalSum = aggregate(Emissions ~ year, sum, data = coalNEI)

# Create PNG file
png(file = "plot4.png")

# Plot the data
ggplot(coalSum, aes(x=year, y=Emissions)) +
    geom_line() +
    xlab("Year") +
    ylab("PM2.5 (tons)") +
    ggtitle("PM2.5 from Coal Combustion Sources per Year")

# Close dev
dev.off()