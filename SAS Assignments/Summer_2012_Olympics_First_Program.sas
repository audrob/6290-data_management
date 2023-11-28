*data steps: names and input vals;

data Summer_2012_Olympics;
input Country_Name $ Abbr_Name $ Gold Silver Bronze;
datalines;
	United_States USA 46 28 29
	China CHN 38 28 22
	Great_Britain GBR 29 17 19
	Russia RUS 24 25 32
	South_Korea KOR 13 8 7
	Germany GER 11 19 14
	France FRA 11 11 12
	Italy ITA 8 9 11
	Hungary HUN 8 4 6
	Australia AUS 7 16 12
;
data Summer_2012_Olympics;
	set Summer_2012_Olympics;
	Total_Medal=sum(Gold, Silver, Bronze);
*proc steps- to table;

proc print data=Summer_2012_Olympics;
	title1 'Summer 2012 Olympics Medal Table';
	title2 'Top 10 Countries';

proc means data=Summer_2012_Olympics maxdec=2;
	var gold silver bronze;
	title 'Mean Number of Medals Among Top 10 Countries';
run;
