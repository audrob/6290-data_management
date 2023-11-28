*input data given;
DATA OWED;
INPUT ID $3. AMOUNTOWED DOLLAR9.;
DATALINES;
001 $3,209
002 $29
002 $34.95
003 2,012
003 312.45
003 34.23
004 2,312
004 $3.92
005 .98
;
run;
*add observation columnn and add observation number by id;
data OWED2;
	input #1 @1 (OBS) ($1.)
				@ 3 (ID) ($3.)
					@7 (OBS_NUM)($1.)
						@9 (AMOUNTOWED)(DOLLAR9.) @;
datalines;
1 001 1 $3,209 
2 002 1 $29    
3 002 2 $34.95 
4 003 1 2,012  
5 003 2 312.45 
6 003 3 34.23  
7 004 1 2,312  
8 004 2 $3.92  
9 005 1 .98    
;
run;
*transpose data to use one line per ID and create 3 amount categories;
proc transpose data=OWED2 out=OWEDnew prefix=AMT;
	by ID;
	id OBS_NUM;
	var AMOUNTOWED;
run;
*create new set without _NAME_ and with new var "TOTAL";
*format "TOTAL" as USD;
data OWEDnew2;
	set OWEDnew;
	drop _NAME_;
		IF AMT3=. AND AMT2=. THEN TOTAL=AMT1;
		ELSE IF AMT3=. THEN TOTAL=AMT1+AMT2;
		ELSE TOTAL=AMT1+AMT2+AMT3;
	format TOTAL DOLLAR10.2;
run;
*Print dataset;
proc print data=OWEDnew2;
	title1 Audrey_Robertson;
run;
	


