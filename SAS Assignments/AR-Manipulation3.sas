*input dataset given;
data dat1; 
  length debt $ 3; 
  input famid year faminc spend debt $ ; 
datalines; 
1 96 40000 38000 yes 
1 97 40500 39000 yes 
1 98 41000 40000 no 
2 96 45000 42000 yes 
2 97 45400 43000 no 
2 98 45800 44000 no 
3 96 75000 70000 no 
3 97 76000 71000 no 
3 98 77000 72000 no 
; 
run;
*transpose to create var for faminc(year);
proc transpose data=dat1 out=dat1wf prefix=faminc;
	by famid;
	id year;
	var faminc;
run;
*transpose to create var for spend(year);
proc transpose data=dat1 out=dat1ws prefix=spend;
	by famid;
	id year;
	var spend;
run;
*transpose to create var for debt(year);
proc transpose data=dat1 out=dat1wd prefix=debt;
	by famid;
	id year;
	var debt;
run;
*merge all transposed data into new set;
*drop var names "_NAME_";
data dat1wnew;
	merge dat1wf dat1ws dat1wd;
	by famid;
	drop _NAME_;
run;
*print the merged transposed dataset;
proc print data=dat1wnew;
	title Audrey_Robertson;
run;
