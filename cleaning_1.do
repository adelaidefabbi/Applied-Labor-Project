*CLEANING FILE

*Cleaning salaries
clear
ssc install egenmore
use "C:\Users\ENSAE04_A_FABBI00\Documents\2019\temp_2019_1.dta"

*generate variable year

gen year=2019

*drop useless variable
drop SIRET SIREN_EMPL CATJUR DECAL_PAIE_DECL NBHEUR_TOT S_BRUT_TOT APEN APET


*&&&&&&&&&&&&&&&&&&&&&&&&&&&&& DROP, ENCODE, DESTRING &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
*drop missing value
foreach var of varlist SIREN NBHEUR DUREE IDENT_S A6 SEXE S_BRUT {
	drop if missing( `var')
}

*destring 

foreach var of varlist CONTRAT_TRAVAIL CONV_COLL DOMEMPL_EMPL NIC_EMPL SEXE TREFFECT REGT REGR ZEMPT {
	destring `var', replace
}

*encode
foreach var of varlist A6 A17  CPFD DEPT TYP_EMPLOI  {
	encode `var', gen(`var'_encode)
	drop `var'
}


*generate dummy for values
foreach var of varlist  CONTRAT_TRAVAIL A17_encode CPFD_encode TYP_EMPLOI_encode {
	tab `var', generate(`var'_)
}

*&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& DROP VALUES &&&&&&&&&&&&&&&&&&&&&&&&&
*drop too small firms 
forvalues i = 0/8 {
	
	drop if TREFFECT==`i'
}


*drop typos and data not needed	
*drop region outside of france
forvalues i = 1/6 {
	
	drop if REGT==`i'
}


drop if AGE<15 | AGE>74
drop if DUREE<30 | DUREE>360
drop if NBHEUR<=150  
*150 is an indicative number as the linimum we want is a part time for more than a month so 5*30
drop if S_BRUT<=0 


*&&&&&&&&&&&&&&&&&&&&&&&&&& GENERATE NEW VARIABLES &&&&&&&&&&&&&&&&&&&&&&&&&
generate AGE_GROUP= floor(AGE/10)
tab AGE_GROUP, generate(AGE_GROUP_)


 

*dummy variable for sex
gen female=0
replace female=1 if SEXE==2
drop SEXE 

*generate variable CEO manager

generate PCS2 = substr(PCS, 1, 2)
destring PCS2, gen(PCS2_destr)
generate CHEF = 0
replace CHEF=1  if PCS2_destr==23
drop PCS2
generate PCS2 = substr(PCS, 1, 1)
tab PCS2, gen(PCS2_) 
drop PCS PCS2 PCS2_destr
*chef will identify the ceo, while all the pcs2_3 identify the managers


gen CHEF_overall=0
replace CHEF_overall = 1 if CHEF==1 | PCS2_3==1

*female leader

generate female_CHEF= CHEF*female
generate female_MANAGER = PCS2_3*female
generate female_leader_overall = CHEF_overall*female


*cleaning wages
gen salaire_hour = S_BRUT/ NBHEUR
drop if salaire_hour<11
*11 is the minimum wage 

*log wages 
gen lnS_salaire = ln(salaire_hour )
drop salaire_hour 
rename lnS_salaire salaire_hour 


*generate WAGES
 bysort SIREN female:  egen median_wage = median(salaire_hour)
 gen median_male=median_wage if female==0
 bysort SIREN : replace median_male=median_male[1] if missing(median_male)
 gen median_female= median_wage if female==1
 gsort  -female
 replace median_female = median_female[_n-1] if missing(median_female)


save "C:\Users\ENSAE04_A_FABBI00\Documents\2019\cleaned_2019_1.dta", replace
*the process is repeated on all the dataset exported by CASD
