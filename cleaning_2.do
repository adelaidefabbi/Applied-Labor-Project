clear
use "C:\Users\Public\Documents\Fabbi-Noyer\temp_2019_tout1.dta"

bysort SIR: gen N = _N
tab N 
drop if N<1000
rename SIR SIREN

destring SX, replace
gen female=0
replace female=1 if SX==0
drop SX 

drop AGE  REGT NIC4 APEN APET CATJUR

save "C:\Users\ENSAE04_A_FABBI00\Documents\2019\expereince_1.dta", replace