/* Creating a library tsa */
options validvarname=v7;
libname tsa '/home/u63900847/ECRB94/data';

/* Reading the data */
proc import datafile='/home/u63900847/ECRB94/data/TSAClaims2002_2017.csv' dbms=csv out=tsa.claims_import replace;
	guessingrows=max;
run;

/* Removing duplicates */
proc sort data=tsa.claims_import out=tsa.claims_import_sort nodupkey dupout=tsa.dupdata;
	by Claim_Number;
run;

/*Cleaning and preparing data*/
data tsa.claims_clean;
	set tsa.claims_import_sort;
	label Claim_Number='Claim Number' Date_Received='Date Received'
		  Incident_Date='Incident Date' Airport_Code='Airport Code'
		  Airport_name='Airport Name' Claim_Type='Claim Type'
		  Claim_Site='Claim Site' Item_Category='Item Category'
		  Close_Amount='Close Amount';
	if Claim_Type ='' or Claim_Type = '-' then Claim_Type='Unknown';
	if Claim_Site ='' or Claim_Site = '-' then Claim_Site='Unknown';
	if Disposition ='' or Disposition = '-' then Disposition='Unknown';
	Claim_Type=scan(Claim_Type,1,'/');
	if Disposition = 'Closed: Canceled' then Disposition=Compress(Disposition);
	if Disposition = 'losed: Contractor Claim' then Disposition = 'Closed:Contractor Claim';
	StateName=propcase(StateName);
	State=upcase(State);
	if Incident_Date=. or Date_Received=. then Date_Issues='Needs Review';
	if Year(Incident_date)<2002 or Year(Incident_date)>2017 then Date_Issues='Needs Review';
	if Year(Date_Received)<2002 or Year(Date_received)>2017 then Date_Issues='Needs Review';
	if Incident_Date>Date_Received then Date_Issues='Needs Review';
	format Incident_date Date_received date9. Close_Amount dollar10.2;
	drop County City;
run;

proc freq data=tsa.claims_clean;
	tables Claim_type Claim_Site Disposition Date_Issues;
run;

proc sort data=tsa.claims_clean out=tsa.claims_clean_sort;
	by Incident_Date;
run;


/*Analyzing data*/
ods graphics on;
ods pdf file='/home/u63900847/ECRB94/data/output/tsa.pdf' pdftoc=1;

ods proclabel "Count of Date Issues in Overall Data";
title "Count of Date Issues in Overall Data";

/* 1. How many date issues are in the overall data*/
proc freq data=tsa.claims_clean_sort;
	tables Date_Issues;
run;

/*Excluse rows with date issues*/
data tsa.claim_clean_noissues;
	set tsa.claims_clean_sort;
	Incident_year=year(Incident_date);
	where Date_Issues ^= 'Needs Review';
run;

/*How many claims per year of Incident_Date are in the overall data? Be sure to include a plot*/
ods proclabel "Count of Claims per year of Incident Date";
title "Count of Claims per year of Incident Date";

proc freq data=tsa.claim_clean_noissues;
	tables Incident_year / nocum nopercent plots=freqplot;
run;

/*3. Lastly, a user should be able to dynamically input a specific state value and answer the following:
a. What are the frequency values for Claim_Type for the selected state?
b. What are the frequency values for Claim_Site for the selected state?
c. What are the frequency values for Disposition for the selected state?
d. What is the mean, minimum, maximum, and sum of Close_Amount for the selected state? 
The statistics should be rounded to the nearest integer.*/

%let statename=California;
ods proclabel "Claim Type, Claim Site, Disposition Frequency Reports for &statename";
title "Claim Type, Claim Site, Disposition Frequency Reports for &statename";

proc freq data=tsa.claim_clean_noissues;
	tables Claim_Type Claim_Site Disposition;
	where StateName="&statename";
run;

ods proclabel "Statistics Report for &statename Close Amount";
title "Statistics Report for &statename Close Amount";

proc means data=tsa.claim_clean_noissues mean min max sum maxdec=0;
	var Close_Amount;
	where StateName="&statename";
run;

ods pdf close;