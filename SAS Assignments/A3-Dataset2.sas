*Name data with 'data' and identify variables with 'input';
	*use $ after str variables;
	*input data with 'datalines';
data mydata1;
	input ID $ Age gender $ married $ weight_in_pounds;
	datalines;
00001 23 M Y 201
00021 43 F Y 154
00043 33 F N 133
00054 29 M N 173
00132 49 F Y 114
;
run;
*print dataset with 'proc print';
proc print data = mydata1;
run;
