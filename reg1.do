clear

use "C:\Users\ENSAE04_A_FABBI00\Documents\2018\final2018.dta"

append using "C:\Users\ENSAE04_A_FABBI00\Documents\2019\final2019.dta"

append using  "C:\Users\ENSAE04_A_FABBI00\Documents\2017\final2017.dta"

append using "C:\Users\ENSAE04_A_FABBI00\Documents\2016\final2016.dta"

append using "C:\Users\ENSAE04_A_FABBI00\Documents\2015\final2015.dta"

destring SIREN, replace

xtset SIREN year

xtdescribe

*&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
*balanced panel regression
bysort SIREN: gen siren_year = _N
drop if siren_year!=5
*main regression
foreach var of varlist  p10_female p10_female p10_male p25_female p25_male
mean_female mean_male med_female med_male p75_female p75_male  p90_female p90_male  {
	
	xtreg `var' female_leader_overall AGE  female AGE_GROUP AGE_GROUP_1 AGE_GROUP_2 AGE_GROUP_3 AGE_GROUP_4 AGE_GROUP_5 AGE_GROUP_6 AGE_GROUP_7 TYP_EMPLOI_encode_1 TYP_EMPLOI_encode_2 TYP_EMPLOI_encode_3 TYP_EMPLOI_encode_4 CPFD_encode_1 CPFD_encode_2 CPFD_encode_3 A17_encode_1 A17_encode_2 A17_encode_3 A17_encode_4 A17_encode_5 A17_encode_6 A17_encode_7 A17_encode_8 A17_encode_9 A17_encode_10 A17_encode_11 A17_encode_12 A17_encode_13 A17_encode_14 A17_encode_15 A17_encode_16 A17_encode_17 A6_encode A17_encode CPFD_encode DEPT_encode TYP_EMPLOI_encode year CONTRAT_TRAVAIL_1 CONTRAT_TRAVAIL_2 CONTRAT_TRAVAIL_3 CONTRAT_TRAVAIL_4 CONTRAT_TRAVAIL_5 CONTRAT_TRAVAIL_6 CONTRAT_TRAVAIL_8 CONTRAT_TRAVAIL_9 CONTRAT_TRAVAIL_10 CONTRAT_TRAVAIL_11  REGT i.year, fe cluster(SIREN)
	
}




*ROBUSTENSS
*different type of CEO
foreach var of varlist p10_female p10_female p10_male p25_female p25_male
mean_female mean_male med_female med_male p75_female p75_male  p90_female p90_male  {
	
	xtreg `var' AGE female_CHEF female_MANAGER female AGE_GROUP AGE_GROUP_1 AGE_GROUP_2 AGE_GROUP_3 AGE_GROUP_4 AGE_GROUP_5 AGE_GROUP_6 AGE_GROUP_7 TYP_EMPLOI_encode_1 TYP_EMPLOI_encode_2 TYP_EMPLOI_encode_3 TYP_EMPLOI_encode_4 CPFD_encode_1 CPFD_encode_2 CPFD_encode_3 A17_encode_1 A17_encode_2 A17_encode_3 A17_encode_4 A17_encode_5 A17_encode_6 A17_encode_7 A17_encode_8 A17_encode_9 A17_encode_10 A17_encode_11 A17_encode_12 A17_encode_13 A17_encode_14 A17_encode_15 A17_encode_16 A17_encode_17 A6_encode A17_encode CPFD_encode DEPT_encode TYP_EMPLOI_encode year CONTRAT_TRAVAIL_1 CONTRAT_TRAVAIL_2 CONTRAT_TRAVAIL_3 CONTRAT_TRAVAIL_4 CONTRAT_TRAVAIL_5 CONTRAT_TRAVAIL_6 CONTRAT_TRAVAIL_8 CONTRAT_TRAVAIL_9 CONTRAT_TRAVAIL_10 CONTRAT_TRAVAIL_11  REGT i.year, fe cluster(SIREN)
	gen b_FEMALECHEF_`var' = _b[female_CHEF] 
	*gen se_FEMALECHEF_`var' = _se[female_CHEF]
	gen b_FEMALEmanager_`var' = _b[female_MANAGER]
	*gen se_FEMALEmanager_`var' _se[female_MANAGER]
}

*&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& RANDOM EFFECT &&&&&&&&&&&&&&&&&&&&&&&
foreach var of varlist p10_female p10_female p10_male p25_female p25_male
mean_female mean_male med_female med_male p75_female p75_male  p90_female p90_male  {
xtreg `var' AGE female_leader_overall female AGE_GROUP AGE_GROUP_1 AGE_GROUP_2 AGE_GROUP_3 AGE_GROUP_4 AGE_GROUP_5 AGE_GROUP_6 AGE_GROUP_7 TYP_EMPLOI_encode_1 TYP_EMPLOI_encode_2 TYP_EMPLOI_encode_3 TYP_EMPLOI_encode_4 CPFD_encode_1 CPFD_encode_2 CPFD_encode_3 A17_encode_1 A17_encode_2 A17_encode_3 A17_encode_4 A17_encode_5 A17_encode_6 A17_encode_7 A17_encode_8 A17_encode_9 A17_encode_10 A17_encode_11 A17_encode_12 A17_encode_13 A17_encode_14 A17_encode_15 A17_encode_16 A17_encode_17 A6_encode A17_encode CPFD_encode DEPT_encode TYP_EMPLOI_encode year CONTRAT_TRAVAIL_1 CONTRAT_TRAVAIL_2 CONTRAT_TRAVAIL_3 CONTRAT_TRAVAIL_4 CONTRAT_TRAVAIL_5 CONTRAT_TRAVAIL_6 CONTRAT_TRAVAIL_8 CONTRAT_TRAVAIL_9 CONTRAT_TRAVAIL_10 CONTRAT_TRAVAIL_11  REGT
}


*CONTROL EXPERIENCE 1111111111111111111111111111111111111111111111111
drop if year==2015

foreach var of varlist p10_female p10_female p10_male p25_female p25_male
mean_female mean_male med_female med_male p75_female p75_male  p90_female p90_male  {
		xtreg `var' female_leader_overall xp75_female xp10_female xp25_female medxp_female xp90_female   AGE female  AGE_GROUP AGE_GROUP_1 AGE_GROUP_2 AGE_GROUP_3 AGE_GROUP_4 AGE_GROUP_5 AGE_GROUP_6 AGE_GROUP_7 TYP_EMPLOI_encode_1 TYP_EMPLOI_encode_2 TYP_EMPLOI_encode_3 TYP_EMPLOI_encode_4 CPFD_encode_1 CPFD_encode_2 CPFD_encode_3 TYP_EMPLOI_encode CONTRAT_TRAVAIL_1 CONTRAT_TRAVAIL_2 CONTRAT_TRAVAIL_3 CONTRAT_TRAVAIL_4 CONTRAT_TRAVAIL_5 CONTRAT_TRAVAIL_6 CONTRAT_TRAVAIL_8 CONTRAT_TRAVAIL_9 CONTRAT_TRAVAIL_10 CONTRAT_TRAVAIL_11  REGT i.year, fe 
}
