# Read in data
NEI <- readRDS("../summarySCC_PM25.rds")
SCC <- readRDS("../Source_Classification_Code.rds")

# Loading library ggplot2
library(ggplot2)

# Subset data for Baltimore & LA
subBaltLa <- NEI[NEI$fips %in% c("24510", "06037"),]


# Match Veh short.name column of classification file and retrieve them in the Baltimore & LA data
vehiculeSCC <- SCC[grepl("veh", SCC$Short.Name, ignore.case=TRUE),]
vehiculeBaltLaNEI <- subset(subBaltLa, SCC %in% vehiculeSCC$SCC)

# Sum the data per year & replace region code by explicit name
vehiculeBaltLaSum = aggregate(vehiculeBaltLaNEI$Emissions, by=list(year=vehiculeBaltLaNEI$year, fips=vehiculeBaltLaNEI$fips), FUN=sum)
vehiculeBaltLaSum$fips <- rep(c("Los Angeles", "Baltimore"), each=4)

# Create PNG file
png(file = "plot6.png")

# Plot the data
ggplot(vehiculeBaltLaSum, aes(x=year, y=x, group=fips, colour=fips)) +
    geom_line() +
    xlab("Year") +
    ylab("PM2.5 (tons)") +
    ggtitle("PM2.5 from Motor Vehicles vs. Year in Baltimore and Los Angeles")

# Close dev
dev.off()