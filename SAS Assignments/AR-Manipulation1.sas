*create first dataset;
data a4set1;
	input ID $ answer $ gender $ eye_color $ height_cm @@;
	datalines;
	1 b M blue 187 
	2 c M brown 176
	3 a F brown 170
	4 d M brown 172
	5 b F green 165
	;	
*print first set;
proc print data=a3set1;
run;
*create second dataset;
data a4set2;
	input ID $ answer $ gender $ hair_color $ age @@;
	datalines;
	4 d M brown 25
	5 b F blonde 27
	6 d F red 24
	7 a M brown 30
	8 c F brown 25
	;
*create second set;
proc print data=a3set2;
run;

*Part a, stack datasets;
data a4stacked1;
	set a4set1 a4set2;
	by ID;
run;
proc print data=a4stacked1;
run;

*Part b, combine where subjects overlap;
*merge overlapping subjects;
data a4mer1;
	merge a4set1 (in=a) a4set2 (in=b);
	by ID;
	IF a AND b;
run;
*remove overlapping subjects in master sets;
data a4removeduplicates1;
	set a4stacked1;
		IF ID=4 THEN delete;
		IF ID=5 THEN delete;
run;
*create updated set with merged subjects lines;
data a4combinedstack1;
	update a4removeduplicates1 a4mer1;
	by ID;
run;
proc print data=a4combinedstack1;
run;

*Part c, add new variable, modify existing values;
data a4adddata1;
	input ID $ answer $ gender $ eye_color $ height_cm hair_color $ age birth_month $;
	datalines;
	1 . . . . . . january
	2 . . . . . 22 march
	3 . . . . . 29 april
	4 . . . . . . august
	5 . . . . . . november
	6 . . . . . . december
	7 . . . . . . october
	8 . . . . . . june
	;
*Update master set with the new data;
data a4combinedstacknew1;
	update a4combinedstack1 a4adddata1;
	by ID;
run;
proc print data=a4combinedstacknew1;
run;
