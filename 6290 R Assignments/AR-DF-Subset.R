#Dataframe Subsetting

## set working directory to file path
setwd("C:/Users/arobe/OneDrive/Documents/R_Data")

## i) read T2D_data01.csv into dataframe T2D_1
T2D_1 <- read.csv("T2D_data01.csv", header=TRUE); T2D_1

## ii) read T2D_data02.txt into datafram T2D_2
T2D_2 <- read.table("T2D_data02.txt", header=TRUE, sep=""); T2D_2

## iii) merge T2D_1 and T2D_2 into df T2D by ID variable
T2D <- cbind(T2D_1, T2D_2);T2D

## iv) display df T2D and find number of observations (rows) 
## and number of variables (columns)
nrow(T2D)
ncol(T2D)
### 12 obs and 9 var

## v) identify and remove any duplicate columns
duplicated(colnames(T2D))
### column 5 [,5] is a duplicate
T2D <- T2D[,-5]; T2D

## vi) select females with BMI over 28 and subset into new df
## find obs of new df
T2D_BMI <- T2D[T2D$Gender=="F" & T2D$BMI>28,];T2D_BMI
nrow(T2D_BMI)
### 6 obs

## vii) from T2D_FO, select CT_ID, Age, Gender, Fast_Gluc, Adipo 
## and subset into new df
T2D_BMIsub <- T2D_BMI[, c("CT_ID", "Age", "Gender", "Fast_Gluc", "Adipo")]
T2D_BMIsub

## viii) create new variable from T2D of Age squared 
## create new df with new var
Age_sq <- T2D$Age^2
T2D_Agesq <- cbind(T2D,Age_sq)
T2D_Agesq

## ix) from T2D_Agesq, select current smokers and subset into new df
## save df into CSV file of given name
T2D_smokers <- T2D_Agesq[T2D_Agesq$Smoking=="Current",];T2D_smokers
write.csv(T2D_smokers, "T2D_smokers.csv", row.names=FALSE)
