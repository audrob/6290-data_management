data mydata1;
	input y1 y2 y3 ;
	datalines;
	10 09 08
	11 07 08
	12 10 08
	11 04 03
	11 10 09
	13 06 05
	11 06 06
	;
proc means data=mydata1;
run;
proc glm data=mydata1;
	model y1 y2 y3 = / nouni;
	repeated test 3 contrast(2) / summary;
run;
