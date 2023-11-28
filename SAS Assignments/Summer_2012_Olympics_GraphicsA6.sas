*data steps: input data lines from given dataset;
data Summer_2012_Olympics;
input Country_Name $ Continent $ Abbr_Name $ Gold Silver Bronze;

datalines;
United_States N_America USA 46 28 29
China Asia CHN 38 28 22
Great_Britain Europe GBR 29 17 19
Russia Europe RUS 24 25 32
South_Korea Asia KOR 13 8 7
Germany Europe GER 11 19 14
France Europe FRA 11 11 12
Italy Europe ITA 8 9 11
Hungary Europe HUN 8 4 6
Australia Oceania AUS 7 16 12
;
*keep vars needed;
keep Country_Name Gold Silver Bronze;
run;
*sort data to prepare for transpose;
proc sort data=Summer_2012_Olympics;
	by descending Country_Name Gold Silver Bronze;
	run;
*transpose to create Column of Medal type and a column of their frequencies;
proc transpose out=oly2012(rename=(COL1=Freq)) Name=Medal data=Summer_2012_Olympics;
	by descending Country_Name;
	run;
*Sort to prepare for ranking;
proc sort data=oly2012;
	by Medal Country_Name;
	run;
*Rank data from high frequency to low for each level of Medal;
	*Output data to new set 'rank' with new column to display rank values;
proc rank data=oly2012 out=rank descending;
	by Medal;
	var Freq;
	ranks rank;
	run;
*plot data as a bar chart using vbar;
	*Display clusters of countries for each level of medal;
	*Put medal frequency in descending order labelled with their respective country;
proc sgplot data=rank;
vbar Medal / freq=Freq group=Country_Name 
	categoryorder=respdesc grouporder=descending 
	groupdisplay=cluster;
*adjust label of x-vaxis;
xaxis label='Top 3 Countries Grouped by Medal Type';
*Show top 3 ranked country for each level of Medal and put in descending order;
where rank =1 OR rank =1.5 OR rank =2 OR rank =3;
title1 Audrey Robertson;
run;
 quit;
