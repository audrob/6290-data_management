* access data file by using 'libname' with path of the data file;
libname path "C:\Users\arobe\OneDrive\Documents\SAS_Data";
* read in data to temp set called 'HEARTSTUDY';
data HEARTSTUDY;
	set path.heartstudy;
run;
* Q4b print variables of FIRST 7 observations using 'proc print' and 'obs =';
proc print data=HEARTSTUDY(obs = 7);
run
