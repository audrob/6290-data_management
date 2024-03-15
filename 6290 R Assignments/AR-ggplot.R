# Assignment 10 R Graphics
# Consider the Olympic medal data used for SAS graphics lectures. Now instead  
# of using SAS procs, we will use R functions to complete the following tasks:

# set working directory
setwd("C:/Users/arobe/OneDrive/Documents/R_Data")

# import libs
library(dplyr)
library(tidyverse)
library(ggplot2)
library(gcookbook)

# Create data frame
## Create Variable Vectors
Country_Name <- c("United_States", "China", "Great_Britain", "Russia",
                  "South_Korea", "Germany", "France", "Italy", "Hungary", 
                  "Australia")
Abbr_Name    <- c("USA", "CHN", "GBR", "RUS", "KOR", "GER", "FRA", "ITA", "HUN", 
               "AUS")

Gold <- c(46, 38, 29, 24, 13, 11, 11, 8, 8, 7) 
Silver <- c(28, 28, 17, 25, 8, 19, 11, 9, 4, 16)
Bronze <- c(29, 22, 19, 32, 7, 14, 12, 11, 6, 12)

## Join variables into data frame as columns
SO_12 <- as.data.frame(cbind(Country_Name, Abbr_Name, Gold, Silver, Bronze))
SO_12


# Q1 Create a scatter plot with x-axis being country names (in whatever order),
#  and y-axis being the number of medals. For each country, three medal count 
#  numbers will be included. The plot needs to satisfy the following 
#  requirements:

## 1) Use different symbols for gold, silver and bronze medals
## 2) Use different colors for medal counts across countries (medal counts for 
##    the same country will have the same color)
## 3) The size of symbols will be proportional to the count value.

## Transform data to combine Medals, name and label values as count
SO_12_long <- SO_12 %>%
  pivot_longer(cols = c(Gold, Silver, Bronze),
               names_to = "Medal",
               values_to = "Count")
SO_12_long$Count <- as.numeric(SO_12_long$Count);SO_12_long

## Create scatter plot
ggplot(data = SO_12_long, aes(x = Country_Name, y = Count)) +
  geom_point(aes(shape = Medal, color = Medal, size = Count)) +
  scale_shape_manual(name= "Medal Type", values=c(Gold = 15, 
                                                  Silver = 16, 
                                                  Bronze = 17)) +
  scale_colour_manual(name="Medal Type", values=c(Gold='gold',
                                                  Silver='grey',
                                                  Bronze='brown')) +
  scale_size(range = c(2, 10), name = "Number of Medals") +
  labs(title = "Summer 2012 Olympics Medals Earned by Country",
       x = "Country", y = "Number of Medals")


# Q2 Select the top three countries. For each country, use the three medal 
#  counts as height to create three bars. The bars from the three countries 
#  should be placed side by side. That is, we have a bar chart with nine bars: 
#  the first three for gold, mid three for silver, and last three for bronze. 
#  Make sure to use appropriate colors to represent data from different 
#  countries.

## Create df for top 3 countries
SO_12_top3 <- SO_12_long %>%
  group_by(Country_Name) %>%
  summarise(Total = sum(Count)) %>%
  top_n(3, Total) %>%
  arrange(desc(Total)) %>%
  left_join(SO_12_long, by = "Country_Name")

## Reorder levels of Medal
SO_12_top3$Medal <- factor(SO_12_top3$Medal, 
                           levels = c("Gold", "Silver", "Bronze"))

## Create bar plot grouping by Medal and Fill by Country_Name

ggplot(data=SO_12_top3, aes(x=Medal, y=Count)
       )+
  geom_bar(aes(fill=Country_Name),position="dodge", stat="identity")+
  labs(title="Top 3 Countries in Summer 2012 Olympics", 
       x="Medal Type", y="Medal Count")
  
