*&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& final collapse 
clear
use "C:\Users\ENSAE04_A_FABBI00\Documents\2019\cleaned_2019_2.dta"

append using "C:\Users\ENSAE04_A_FABBI00\Documents\2019\cleaned_2019_1.dta"

bysort SIREN: gen N = _N
tab N 
drop if N<1000


generate SIRET = substr(SIREN, 1, 6)
destring SIRET, gen( SIRET2)
* generate proxy for productivity with number of hours worked
bysort SIREN: egen productivity = total( NBHEUR )



*collapse
*need to elaborate collapse for toher variables
collapse (mean) AGE CHEF_overall female_CHEF female_MANAGER female_leader_overall PCS2_1 PCS2_2 PCS2_3 PCS2_4 PCS2_5 PCS2_6 PCS2_7 CHEF female AGE_GROUP AGE_GROUP_1 AGE_GROUP_2 AGE_GROUP_3 AGE_GROUP_4 AGE_GROUP_5 AGE_GROUP_6 AGE_GROUP_7 TYP_EMPLOI_encode_1 TYP_EMPLOI_encode_2 TYP_EMPLOI_encode_3 TYP_EMPLOI_encode_4 CPFD_encode_1 CPFD_encode_2 CPFD_encode_3 A17_encode_1 A17_encode_2 A17_encode_3 A17_encode_4 A17_encode_5 A17_encode_6 A17_encode_7 A17_encode_8 A17_encode_9 A17_encode_10 A17_encode_11 A17_encode_12 A17_encode_13 A17_encode_14 A17_encode_15 A17_encode_16 A17_encode_17 A6_encode A17_encode CPFD_encode DEPT_encode TYP_EMPLOI_encode year CONTRAT_TRAVAIL_1 CONTRAT_TRAVAIL_2 CONTRAT_TRAVAIL_3 CONTRAT_TRAVAIL_4 CONTRAT_TRAVAIL_5 CONTRAT_TRAVAIL_6 CONTRAT_TRAVAIL_8 CONTRAT_TRAVAIL_9 CONTRAT_TRAVAIL_10 CONTRAT_TRAVAIL_11 CONTRAT_TRAVAIL_12 REGT SIRET2 N productivity, by(SIREN)


merge 1:1 SIREN using "C:\Users\ENSAE04_A_FABBI00\Documents\2019\quantile_2019outcome.dta"


save "C:\Users\ENSAE04_A_FABBI00\Documents\2019\final2019.dta", replace