# Assignment: Housing Dataset
# Name: Shrestha, Saurabh
# Date: 2021-04-14
install.packages("dplyr")
library(readxl)
library(dplyr)
# Set working directory
setwd("C:/Users/Saurabh/Desktop/DSC 520/Week5")

# Load the housing dataset
housing_data = read_excel("week-6-housing.xlsx")
head(housing_data)

# GroupBy, Summarize, Mutate, Filter, Select, and Arrange
colnames(housing_data)[2] <- "Sale_Price"
housing_data %>% group_by(Sale_Price)
housing_data %>% group_by(Sale_Price) %>% summarize(mean(square_feet_total_living))

# Mutate
housing_data %>% mutate(price_per_square_ft = Sale_Price/square_feet_total_living)

housing_data %>% summarize(mean(Sale_Price))

# Filter 
housing_data %>% filter(Sale_Price < 300000)

# Select 
housing_data %>% select(`Sale Date`,Sale_Price,square_feet_total_living,bedrooms)

# Arrange
housing_data %>% arrange(Sale_Price, square_feet_total_living, bedrooms)

library(purrr)
# purr functions
zip_data <- compact(housing_data$zip5)
low_price <- housing_data$Sale_Price %>% keep(function(x) x < 250000)
head(zip_data)
head(low_price)

# cbind

baths <- cbind(housing_data$bath_full_count, housing_data$bath_half_count,
               housing_data$bath_3qtr_count)
head(baths)

#rbind

expensive_house <- housing_data %>% filter(Sale_Price >= 250000)
less_expensive_house <- housing_data %>% filter(Sale_Price < 250000)
# joined these two dfs to one
house_range<- rbind(expensive_house,less_expensive_house)
head(house_range)

# string concatenation(concatenating addr_full, postalctyn and zip5)
library(stringr)

address_categories <- str_split(string = housing_data$addr_full,pattern = ' ')
housing_data$full_address <- paste(housing_data$addr_full,housing_data$postalctyn,housing_data$zip5,sep = ',')
head(housing_data %>% select(`Sale Date`, Sale_Price,full_address))

