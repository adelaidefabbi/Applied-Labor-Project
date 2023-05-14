clear 

*clear
*append all the cleaned dataset of the year 
use "C:\Users\ENSAE04_A_FABBI00\Documents\2019\cleaned_2019_2.dta"

append using "C:\Users\ENSAE04_A_FABBI00\Documents\2019\cleaned_2019_1.dta"

bysort SIREN: gen N = _N
tab N 
drop if N<1000

collapse (mean) salaire_hour year (p10) p10=salaire_hour (p90) p90=salaire_hour (p25) p25=salaire_hour (p75) p75=salaire_hour (median) med_inc=salaire_hour , by(SIREN female)

gen p25_female = p25 if female==1
gen p25_male= p25 if female==0


gen p75_female = p75 if female==1
gen p75_male= p75 if female==0

gen p10_female = p10 if female==1
gen p10_male= p10 if female==0

gen p90_female = p90 if female==1
gen p90_male= p90 if female==0



gen mean_female = salaire_hour if female==1
gen mean_male= salaire_hour if female==0

gen med_female = med_inc if female==1
gen med_male= med_inc if female==0

foreach var of varlist  p25_male  p75_male p90_male p10_male  mean_male med_male{
	
	bysort SIREN : replace `var'=`var'[1] if missing(`var')

}


foreach var of varlist  p25_female  p75_female  p90_female p10_female  mean_female med_female{
	gsort -female 
	 replace `var' = `var'[_n-1] if missing(`var')

}
collapse p25_female p25_male p75_female p75_male p90_female p90_male p10_female p10_male mean_female mean_male med_female med_male year, by(SIREN)
 
save "C:\Users\ENSAE04_A_FABBI00\Documents\2019\quantile_2019outcome.dta", replace