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

SCC.coal = SCC[(grepl(x = SCC$Short.Name, pattern = "Coal", ignore.case=TRUE)),]
NEI.coal = merge(NEI, SCC.coal, by = "SCC")

Emissions <- NEI.coal %>% 
 group_by(year) %>%
 summarize(Total = sum(Emissions, na.rm = TRUE)) # Removing the NA's

Emissions$group = rep("coal",nrow(Emissions))


## -----------------------------------------------------------------------------------------------------------------
Plot4 <- ggplot(Emissions, aes(as.factor(year), Total, group = group, label = round(Total,digits = 0)))+
 geom_point(size = 5, alpha = 0.6, color = 'violet')+
 geom_text(check_overlap = TRUE, family = 'Times New Roman', hjust = 1.3)+
 labs(x = 'Years', y = 'Total emissions (tons)', 
      title = 'Total Annual Coal combustion emissions in the US from 1998 to 2008')+
 theme_bw()

Plot4

ggsave('Plot4.png', plot = Plot4, width = 18, height = 9, units = 'cm')



## -----------------------------------------------------------------------------------------------------------------
#library(knitr)
#purl('Plot4.Rmd')

