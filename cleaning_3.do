clear 

use "C:\Users\ENSAE04_A_FABBI00\Documents\2019\cleaned_2019_2.dta"

append using "C:\Users\ENSAE04_A_FABBI00\Documents\2019\cleaned_2019_1.dta"

bysort SIREN: gen N = _N
tab N 
drop if N<1000

generate SIRET = substr(SIREN, 1, 6)



collapse (mean) salaire_hour year REGT  (p10) p10=salaire_hour (p90) p90=salaire_hour (p25) p25=salaire_hour (p75) p75=salaire_hour (median) med_inc=salaire_hour (sum) hours=NBHEUR   , by(SIREN )

 
save "C:\Users\ENSAE04_A_FABBI00\Documents\2019\quantile_2019nogender.dta", replace

clear
use "C:\Users\ENSAE04_A_FABBI00\Documents\2019\final2019.dta"

drop _merge

merge 1:1 SIREN using "C:\Users\ENSAE04_A_FABBI00\Documents\2019\quantile_2019nogender.dta"
drop _merge
merge 1:1 SIREN using "C:\Users\ENSAE04_A_FABBI00\Documents\2019\expereince_final.dta"
drop if _merge==2
save "C:\Users\ENSAE04_A_FABBI00\Documents\2019\quantile_2019nogender.dta" , replace