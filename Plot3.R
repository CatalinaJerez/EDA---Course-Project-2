## ----setup, include=FALSE-----------------------------------------------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, results = 'asis')


## -----------------------------------------------------------------------------------------------------------------
setwd("~/Google Drive/Coursera/EDA")

# Install and load required packages
if (!require('ggplot2'))      {install.packages('ggplot2')}
if (!require('dplyr'))      {install.packages('dplyr')}
if (!require('data.table')) {install.packages('data.table')}

library(ggplot2)
library(dplyr)
library(data.table)



## -----------------------------------------------------------------------------------------------------------------
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



## -----------------------------------------------------------------------------------------------------------------
head(NEI)

Baltimore <- NEI %>% subset(fips == '24510') %>%
 group_by(year, type) %>%
 summarize(Total = sum(Emissions, na.rm = TRUE)) # Removing the NA's

Baltimore




## -----------------------------------------------------------------------------------------------------------------
# Plot using ggplot

Plot3 <- ggplot(Baltimore, aes(as.factor(year), Total, color = type,  alpha = 0.9))+
 geom_point(size = 3, alpha = 0.6, color = 'violet')+
 #geom_boxplot()+
 #geom_jitter(alpha = 0.3)+
 facet_grid(. ~ type)+
 labs(x = 'Years', y = 'Total emissions (tons)', 
      title = 'Total Annual Emissions in Baltimore by Year')+
 
 theme_bw()

Plot3
ggsave('Plot3.png', plot = Plot3, width = 18, height = 7, units = 'cm')


## -----------------------------------------------------------------------------------------------------------------
#library(knitr)
#purl('Plot3.Rmd')

