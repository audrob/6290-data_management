libname path "C:\Users\arobe\OneDrive\Documents\SAS_Data";
data path.mydataRMDrat;
	input rat $ t1 t2 t3;
	datalines;
	1 10 09 08
	2 11 07 08
	3 12 10 08
	4 11 04 03
	5 11 10 09
	6 13 06 05
	7 11 06 06
	;
