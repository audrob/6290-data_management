*use import... name SAS file with 'out', locating data file with 'file', and specifiying file type with 'dbms';

proc import out=carsmpg file="C:\Users\arobe\OneDrive\Documents\SAS_Data\CARSMPG.xlsx" dbms=xlsx;
*get variable names from data file with 'getnames', specify that data is string and numeric with 'mixed';
	getnames=yes;
	mixed=yes;
run;
*print data to check dataset;

proc print data=carsmpg;
run;
 
