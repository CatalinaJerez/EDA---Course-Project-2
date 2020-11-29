## ----setup, include=FALSE-------------------------------
knitr::opts_chunk$set(echo = TRUE, results = 'asis')


## -------------------------------------------------------
setwd("~/Google Drive/Coursera/EDA")

# Install and load required packages
if (!require('ggplot2'))      {install.packages('ggplot2')}
if (!require('dplyr'))      {install.packages('dplyr')}
if (!require('data.table')) {install.packages('data.table')}

library(ggplot2)
library(dplyr)
library(data.table)



## -------------------------------------------------------
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



## -------------------------------------------------------
# Total PM2.5 emission from 1999 to 2008

# First, we look inside the dataset
head(NEI)

# Then, wee group by year, and summarise the total emissions 
Emiss.tot <- NEI %>% 
 group_by(year) %>%
 summarize(Total = sum(Emissions, na.rm = TRUE)) # Removing the NA's
Emiss.tot



## -------------------------------------------------------
# Plot emission using base plotting system


png("Plot1A.png", width = 1000, height = 800, units = 'px')
barplot(Emiss.tot$Total, Emiss.tot$year, 
        col = c("lightblue", "mistyrose","lightcyan", "lavender"), 
        log = 'y', ylab = 'Total PM2.5 emissions',
        xlab = "Years", names.arg = Emiss.tot$year,
        main = "Total emissions from PM2.5 decreased in the United States")
dev.off()

# Plot emission using ggplot2

plot1B <- ggplot(data = Emiss.tot)+
 geom_col(aes(x = as.factor(year), y = Total, fill = year, alpha = 0.9))+
 scale_y_continuous(labels=function(n){format(n, scientific = FALSE)})+
 labs(x = 'Years', y = 'Total PM2.5 emissions', 
      title = 'Total emissions from PM2.5 decreased in the United States')+
 scale_fill_distiller(name = 'Years',palette = "RdYlBu", direction = 1)+
 guides(alpha = 'none')+
 theme_bw()

plot1B

ggsave('Plot1B.png', plot = plot1B, width = 20, height = 15, units = 'cm')



## -------------------------------------------------------
library(knitr)
purl('Plot1.Rmd')

