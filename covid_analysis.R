
# Data source: https://www.kaggle.com/tunguz/data-on-covid19-coronavirus

# Load libraries
# Preparation for the magic...

# install.packages("tidyverse")
# install.packages("funModeling")
# install.packages("Hmisc")
library(data.table)
library(funModeling) 
library(Hmisc)
library(ggplot2)


#####################
#### Read data    ###
#####################
dt <- fread("data/owid-covid-data.csv")


####################
##    View data  ###
####################
View(dt)



####################################################################
# 1. Checking missing values, zeros, data type, and unique values
####################################################################

# total rows, total columns and column names
nrow(dt)
ncol(dt)


# basic profiling
df_status(dt)
# dt[, lapply(.SD, function(x) sum(is.na(x))/ nrow(dt))]

# profiling categorical variables
freq(dt)


# profiling numerical variables
plot_num(dt)


####################################################################
# 2. Select data of interest
####################################################################

# Netherlands only
nl <- dt[location == 'Netherlands']


# Select some columns
nl <- nl[, .(iso_code, location, date, total_vaccinations, people_vaccinated_per_hundred, people_fully_vaccinated_per_hundred)]
nl <- nl[!is.na(total_vaccinations)]
# nl <- nl[complete.cases(nl)]

####################################################################
# 3. Visualization
####################################################################
p1 <- ggplot(data = nl, aes(x = date, y = people_vaccinated_per_hundred, color = location))
p1 + geom_line(size=1.2) + scale_y_continuous(breaks=c(0,20,40,60), labels= scales::comma) + 
  labs(titles = '% of vaccinated people in the Netherlands',
       x = 'Date',
       y = '% vaccinated people')



p1 <- ggplot(data = dt[location %in% c("Netherlands", "United Kingdom", "France") & !is.na(people_vaccinated_per_hundred)], aes(x = date, y = people_vaccinated_per_hundred, color = location))
p1 + geom_line(size=1.2) + scale_y_continuous(breaks=c(0,20,40,60), labels= scales::comma) + 
  labs(titles = '% of vaccinated people in the Netherlands',
       x = 'Date',
       y = '% vaccinated people')



