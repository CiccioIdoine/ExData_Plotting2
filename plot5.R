# Read in data
NEI <- readRDS("../summarySCC_PM25.rds")
SCC <- readRDS("../Source_Classification_Code.rds")

# Loading library ggplot2
library(ggplot2)

# Subset data for Baltimore
subBaltimore = subset(NEI, fips == "24510")

# Match Veh short.name column of classification file and retrieve them in the Baltimore data
vehiculeSCC <- SCC[grepl("veh", SCC$Short.Name, ignore.case=TRUE),]
vehiculeBaltimoreNEI <- subset(subBaltimore, SCC %in% vehiculeSCC$SCC)

# Sum the data per year
vehiculeBaltimoreSum = aggregate(Emissions ~ year, sum, data = vehiculeBaltimoreNEI)

# Create PNG file
png(file = "plot5.png")

# Plot the data
ggplot(vehiculeBaltimoreSum, aes(x=year, y=Emissions)) +
    geom_line() +
    xlab("Year") +
    ylab("PM2.5 (tons)") +
    ggtitle("PM2.5 from Vehicules in Baltimore per Year")

# Close dev
dev.off()