* HETEROGENEITY 
*&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
*&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&


clear

use "C:\Users\ENSAE04_A_FABBI00\Documents\2018\quantile_2018nogender.dta"

append using "C:\Users\ENSAE04_A_FABBI00\Documents\2019\quantile_2019nogender.dta"

append using  "C:\Users\ENSAE04_A_FABBI00\Documents\2017\quantile_2017nogender.dta"

append using "C:\Users\ENSAE04_A_FABBI00\Documents\2016\quantile_2016nogender.dta"

append using "C:\Users\ENSAE04_A_FABBI00\Documents\2015\quantile_2015nogender.dta"

destring SIREN, replace



xtset SIREN year
 drop if female<0.75



xtdescribe
bysort SIREN: gen siren_year = _N
drop if siren_year!=5

foreach var of varlist  p10_female p10_male p25_female p25_male
mean_female mean_male med_female med_male p75_female p75_male  p90_female p90_male {

	
	xtreg `var' female_leader_overall AGE female  AGE_GROUP AGE_GROUP_1 AGE_GROUP_2 AGE_GROUP_3 AGE_GROUP_4 AGE_GROUP_5 AGE_GROUP_6 AGE_GROUP_7 TYP_EMPLOI_encode_1 TYP_EMPLOI_encode_2 TYP_EMPLOI_encode_3 TYP_EMPLOI_encode_4 CPFD_encode_1 CPFD_encode_2 CPFD_encode_3 TYP_EMPLOI_encode CONTRAT_TRAVAIL_1 CONTRAT_TRAVAIL_2 CONTRAT_TRAVAIL_3 CONTRAT_TRAVAIL_4 CONTRAT_TRAVAIL_5 CONTRAT_TRAVAIL_6 CONTRAT_TRAVAIL_8 CONTRAT_TRAVAIL_9 CONTRAT_TRAVAIL_10 CONTRAT_TRAVAIL_11 productivity  REGT i.year, fe 
}


*drop if female >0.25
*drop if female <0.25 | female>0.5
 *drop if female>0.75 | female<0.5
	
*using A6 	
clear

use "C:\Users\ENSAE04_A_FABBI00\Documents\2018\quantile_2018nogender.dta"

append using "C:\Users\ENSAE04_A_FABBI00\Documents\2019\quantile_2019nogender.dta"

append using  "C:\Users\ENSAE04_A_FABBI00\Documents\2017\quantile_2017nogender.dta"

append using "C:\Users\ENSAE04_A_FABBI00\Documents\2016\quantile_2016nogender.dta"

append using "C:\Users\ENSAE04_A_FABBI00\Documents\2015\quantile_2015nogender.dta"

destring SIREN, replace



xtset SIREN year


drop if A6_encode!=6

xtdescribe
bysort SIREN: gen siren_year = _N
drop if siren_year!=5