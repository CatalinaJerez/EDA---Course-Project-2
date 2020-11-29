## ----setup, include=FALSE----------------------------------------
knitr::opts_chunk$set(echo = TRUE, results = 'asis')


## ----------------------------------------------------------------
setwd("~/Google Drive/Coursera/EDA")

# Install and load required packages
if (!require('ggplot2'))      {install.packages('ggplot2')}
if (!require('dplyr'))      {install.packages('dplyr')}
if (!require('data.table')) {install.packages('data.table')}

library(ggplot2)
library(dplyr)
library(data.table)



## ----------------------------------------------------------------
# name for zip file
setwd("~/Google Drive/Coursera/EDA")
file.zip <- 'EDA_Final.zip' 

# Cheking if zip file exists
if (!file.exists(file.zip)){
 file.URL <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip'
 download.file(file.URL, file.zip, method = 'curl')
 unzip(file.zip, exdir = '.')} 

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")



## ----------------------------------------------------------------
head(NEI)

Baltimore <- NEI %>% subset(fips == '24510') %>%
 group_by(year) %>%
 summarize(Total = sum(Emissions, na.rm = TRUE)) # Removing the NA's

Baltimore




## ----------------------------------------------------------------
# Plot emission using base plotting system


png("Plot2A.png", width = 1000, height = 800, units = 'px')
barplot(Baltimore$Total, Baltimore$year, 
        col = c("lightblue", "mistyrose","lightcyan", "lavender"), 
        log = 'y', ylab = 'Total PM2.5 emissions per year (tons)',
        xlab = "Years", names.arg = Baltimore$year,
        main = "Total emissions from PM2.5 decreased in Baltimore")
dev.off()

# Plot emission using ggplot2

plot2B <- ggplot(data = Baltimore)+
 geom_col(aes(x = as.factor(year), y = Total, fill = year, alpha = 0.9))+
 scale_y_continuous(labels=function(n){format(n, scientific = FALSE)})+
 labs(x = 'Years', y = 'Total PM2.5 emissions per year (tons)', 
      title = 'Total emissions from PM2.5 decreased in Baltimore')+
 scale_fill_distiller(name = 'Years',palette = "RdYlGn", direction = 1)+
 guides(alpha = 'none')+
 theme_bw()

plot2B

ggsave('Plot2B.png', plot = plot2B, width = 10, height = 7, units = 'cm')



## ----------------------------------------------------------------
#library(knitr)
#purl('Plot1.Rmd')

