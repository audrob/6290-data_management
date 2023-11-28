* Q1 read in data with 'datalines'and variables with 'input'; 
* save to tempoary WORK file 'blood_pressure';
data blood_pressure;
	input PATIENT_ID $ BMI SBP DBP;
	datalines;
	A1 20.52 117 74
	A2 24.25 112 80
	A3 26.05 111 79
	A4 23.50 110 76
	B1 30.54 149 94
	B2 32.24 115 76
	B3 22.77 127 80
run;
* Q2 identify directory path for permanent data set;
libname path "C:\Users\arobe\OneDrive\Documents\SAS_Data";
* create copy of the temporary set and save to path;
data path.copyofblood_pressure;
	set blood_pressure;
* label variables;
	label BMI = "body mass index"
		  SBP = "systolic blood pressure"
		  DBP = "diastolic blood pressure";
run;
*Q3 print labelled data with 2 levels of titles;
proc print data=path.copyofblood_pressure label;
	title1 "Blood pressure data for seven patients";
	title3 "Patients from two groups";
run;
	
