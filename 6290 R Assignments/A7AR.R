#paste data
d1 <- c(0.08, 0.47, 0.86, 0.8, 0.28, 0.77, 0.42, 0.14, 0.1, NA, 0.91, 0.45, 0.5, 0.03, 0.49, 0.59, 0.83, 0.38, 0.45, 0.58, 0.68, 0.6, 0.68, NA, 0.32, 0.63, 0.27, 0.78, 0.77, 0.83, 0.09, 0.29, 0.14, 0.26, 0.38, 0.16, 0.36, 0.78, 0.26, 0.52, 0.11, 0.28, 0.08, 0.24, 0.49, 0.25, NA, 0.9, 0.44, 0.7)
d2 <- c(0.98, 1.16, 1.01, 1.04, 0.94, 0.96, NA, 0.66, 0.88, 0.36, 0.73, 0.81, 0.97, 0.89, 0.61, 1.03, 0.9, 1.13, 0.85, 1.02, 0.83, 1.22, 1.04, 0.73, 0.99, 0.63, 0.89, 0.87, 0.9, 0.7, 1.08, 1.03, 0.85, 0.88, 0.59, 1.16, 0.82, 0.97, 1.13, 1, 0.46, 1.07, 1.21, 1.11, NA, 1.13, 0.99, 1.22, 0.64, 0.92)

#transpose data and add Status Column by binding in each group
dd1<-cbind("Case", as.numeric(d1))
dd2<-cbind("Control", as.numeric(d2))

#append the data from d1 and d2 and name columns accordingly
df <- as.data.frame(rbind(dd1,dd2))
colnames(df) <- c("Status", "Value"); df

#create factors for Status and ensure "Value" is numeric
dffa <- (df);rownames(dffa) <-NULL
dffa[,1] <- factor(dffa[,1]);
dt <- transform(dffa, Value=as.numeric(Value))

summary(dt, na.rm=FALSE)

#subset Case data d1 and summarize valid data (mean, median, var)
xd <- dt[dt[,1]=="Case",]
mean(xd[,2], na.rm=TRUE, use="complete")
median(xd[,2], na.rm=TRUE, use="complete")
var(xd[,2], na.rm=TRUE, use="complete")

#subset Control data d2 and summarize valid data (mean, median, var)
##account for missing values in summary value statements
od <- dt[dt[,1]=="Control",]
mean(od[,2], na.rm=TRUE, use="complete")
median(od[,2], na.rm=TRUE, use="complete")
var(od[,2], na.rm=TRUE, use="complete")

#Subset Case data and count where it is greater than its median
##median given by summary function
##two methods shown
xd[xd[,2]>(median(xd[,2], na.rm=TRUE, use="complete")),]
summary(xd[,2]>(as.numeric(sub('.*:', '', summary(xd)[10]))))


#Subset Control data and count where it is greater than its median
  ##median given by summary function
  ##two methods shown
summary(od[od$Value>(as.numeric(sub('.*:', '', summary(od)[10]))),])
summary(od[,2]>(as.numeric(sub('.*:', '', summary(od)[10]))))


#Subset Case data and find where it is greater than value
  ##bind logical data set to d1 subset to identify values
sx <- xd[,2]>0.95
sxd <- cbind(xd,sx)
colnames(sxd) <- c("Status", "Value", "Greater than 0.95?")
sxd



