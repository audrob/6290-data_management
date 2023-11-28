*Q1. Name data, identify data file location with 'infile'.
CARSMPG.csv uses comma separated values, so delimiter is a comma.;
data CARSMPG;
	infile "C:\Users\arobe\OneDrive\Documents\SAS_Data\CARSMPG.csv" dlm="," firstobs=2;
*read-in non-SAS data using 'input'. label string vars with '$' after.;
	input BRAND $ MODEL $ MINIVAN $ WAGON $ PICKUP $ AUTOMATIC $ ENGINESIZE CYLINDERS CITYMPG HWYMPG SUV $ AWD $ HYBRID $;
run;

*Q2. confirm descriptors, formatting, and variables of the data set & use 'varnum' to list variables by order;
proc contents data=CARSMPG varnum;
run;

*Q3. keep only variables that are needed to print in new data set.;
data CARS7V;
	set CARSMPG;
	keep BRAND MODEL ENGINESIZE CYLINDERS CITYMPG HWYMPG;
run;
proc contents data=CARS7V varnum;
run;

*print the first 10 obs of the new truncated data set 'CARS7V';
proc print data=CARS7V (obs=10);
run;
