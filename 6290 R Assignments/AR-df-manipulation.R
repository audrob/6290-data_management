#Data frame Manipulation

#Question 1

## set working directory to file path
setwd("C:/Users/arobe/OneDrive/Documents/R_Data")
## import libs
library(dplyr)
library(tidyverse)

## i) read T2D_data01.csv into dataframe T2D_1
T2D_1 <- read.csv("T2D_data01.csv", header=TRUE); T2D_1
## ii) read T2D_data02.txt into datafram T2D_2
T2D_2 <- read.table("T2D_data02.txt", header=TRUE, sep=""); T2D_2

## iii) join T2D_1 and T2D_2 into df T2D by ID variable
T2D<- T2D_1 %>% full_join(T2D_2, by=join_by(CT_ID));T2D

## iv) display df T2D and find number of observations (rows) 
## and number of variables (columns)
str(T2D)
### T2D has 12 obs and 8 vars

## v) identify and remove any duplicate columns
duplicated(colnames(T2D))
### no duplicated columns

## vi) filter females with BMI over 28 and subset into new df
## find obs of new df
T2D_BMI <- T2D %>% filter(Gender=="F" & BMI>28);T2D_BMI
  count(T2D_BMI)
### T2D_BMI has 6 obs

## vii) from T2D_BMI, select CT_ID, Age, Gender, Fast_Gluc, Adipo 
## and subset into new df
T2D_BMIsub <- T2D_BMI %>% select(CT_ID, Age, Gender, Fast_Gluc, 
                                 Adipo);T2D_BMIsub

## viii) create new variable from T2D of Age squared 
## Mutate T2D to create new df with new var
T2D_Agesq <- T2D %>% mutate(Age_sq=Age^2);T2D_Agesq

## ix) from T2D_Agesq, select current smokers and subset into new df
## save df into CSV file of given name
T2D_smokers <- T2D_Agesq %>% filter(Smoking=="Current");T2D_smokers
  write.csv(T2D_smokers, "T2D_smokers.csv", row.names=FALSE)


#Question 2

##Modify the three hypothetical data frames x, y, y2 in our lecture notes, 
  ##to create three new data frames with the following characteristics:
  
###Input data frames
x <- as.data.frame(cbind(id= c(1, 2, 3), value_x= c("x1", "x2", "x3")))
y <- as.data.frame(cbind(id = c(1, 2, 4), value_y = c("y1", "y2", "y4")))
y2 <- as.data.frame(cbind(idy = c(1, 2, 4), value_y = c("y1", "y2", "y4")))
  x;y;y2
  
   ###x_new: having two records for subject #2, with values being x2_1 and x2_2
xa <- as.data.frame(cbind(id= c(2,2), value_x= c("x2_1", "x2_2")))
x_new <- x[-2,] %>% full_join(xa, by=join_by(id,value_x)) %>% arrange(id);x_new
  
  ###y_new: have three records for subject #2, with values being y2_1, y2_2, 
  ###and y2_3
ya <- as.data.frame(cbind(id= c(4, 4, 4), 
                               value_y= c("y4_1", "y4_2", "y4_3"))) 
y_new <- y[-3,] %>% full_join(ya, by=join_by(id,value_y)) %>% arrange(id);y_new
  
  ###y2_new: have two records for subject #4, with values being y4_1 and y4_2
y2a <- as.data.frame(cbind(idy= c(4, 4), value_y= c("y4_1", "y4_2")))
y2_new <- y2[-3,] %>% full_join(y2a, by=join_by(idy,value_y)) %>% 
  arrange(id);y2_new
 
## Compare the results when left joining x_new and y_new vs right joining x_new
  ## and y_new. 
b1 <- x_new %>% left_join(y_new, by=join_by(id)); b1
b2 <- x_new %>% right_join(y_new, by=join_by(id)); b2
### left join keeps rows from x and matches them to rows in y by id
### right join keeps rows from y and matches them to rows in x by id

  ## What about y_new vs y2_new (with different variable names 
     ## considered: that is, “id” from y_new is matched with “idy” in y2_new)? 
b3 <- y_new %>% left_join(y2_new, by=join_by(id==idy, value_y)); b3
b4 <- y_new %>% right_join(y2_new, by=join_by(id==idy, value_y)); b4
### left join keeps rows from y and matches them to rows in y2 by id/idy
### right join keeps rows from y2 and matches them to rows in y by id/idy

  ## Briefly describe how these two functions work when records have duplicates.
### When a subject (id) has a duplicate record in data frame, the single record 
### of the other data frame being joined is duplicated/repeated

## Apply full_join() and inner_join() to x_new and y_new.
c1 <- x_new %>% full_join(y_new, by=join_by(id)); c1
c2 <- x_new %>% inner_join(y_new, by=join_by(id)); c2

## Apply full_join() and inner_join() to y_new and y2_new.
d1 <- y_new %>% full_join(y2_new, by=join_by(id==idy, value_y)); d1
d2 <- y_new %>% inner_join(y2_new, by=join_by(id==idy, value_y)); d2

## Briefly describe how full_join() and inner_join() work when records have 
##duplicates.
### When a subject (id) has a duplicate record in data frame, the single record 
### of the other data frame being joined is duplicated/repeated

