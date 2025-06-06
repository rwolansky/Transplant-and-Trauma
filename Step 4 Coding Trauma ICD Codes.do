*********************************I10_DX1******************************
clear
use "Y:\Rachel Wolansky\Transplant and Trauma\HCUP\Data Out\Step 2 Append Years 2019-2021.dta"

rename I10_DX1 icddiagnosiscode

merge m:1 icddiagnosiscode using "Z:\Total Data April 4 2018\Onetomap Databases\NTDB_TQIP Dataset\TQIP_USF_V2\PUF AY 2022\STATA\PUF_ICDDIAGNOSIS_LOOKUP.dta" 

keep if _merge == 3 
drop _merge 

rename icddiagnosiscode icddiagnosiscode_1
rename icddiagnosiscode_desc icddiagnosiscode_desc_1

keep KEY_NIS icddiagnosiscode_1 icddiagnosiscode_desc_1

codebook KEY_NIS

save "Y:\Rachel Wolansky\Transplant and Trauma\HCUP\Data Out\Trauma Codes I10_DX1.dta", replace

*********************************I10_DX2******************************
clear
use "Y:\Rachel Wolansky\Transplant and Trauma\HCUP\Data Out\Step 2 Append Years 2019-2021.dta"

rename I10_DX2 icddiagnosiscode

merge m:1 icddiagnosiscode using "Z:\Total Data April 4 2018\Onetomap Databases\NTDB_TQIP Dataset\TQIP_USF_V2\PUF AY 2022\STATA\PUF_ICDDIAGNOSIS_LOOKUP.dta" 

keep if _merge == 3 
drop _merge 

rename icddiagnosiscode icddiagnosiscode_2
rename icddiagnosiscode_desc icddiagnosiscode_desc_2


keep KEY_NIS icddiagnosiscode_2 icddiagnosiscode_desc_2

save "Y:\Rachel Wolansky\Transplant and Trauma\HCUP\Data Out\Trauma Codes I10_DX2.dta", replace
*********************************I10_DX3******************************
clear
use "Y:\Rachel Wolansky\Transplant and Trauma\HCUP\Data Out\Step 2 Append Years 2019-2021.dta"

rename I10_DX3 icddiagnosiscode

merge m:1 icddiagnosiscode using "Z:\Total Data April 4 2018\Onetomap Databases\NTDB_TQIP Dataset\TQIP_USF_V2\PUF AY 2022\STATA\PUF_ICDDIAGNOSIS_LOOKUP.dta" 

keep if _merge == 3 
drop _merge 

rename icddiagnosiscode icddiagnosiscode_3
rename icddiagnosiscode_desc icddiagnosiscode_desc_3


keep KEY_NIS icddiagnosiscode_3 icddiagnosiscode_desc_3

save "Y:\Rachel Wolansky\Transplant and Trauma\HCUP\Data Out\Trauma Codes I10_DX3.dta", replace
*********************************I10_DX4******************************
clear
use "Y:\Rachel Wolansky\Transplant and Trauma\HCUP\Data Out\Step 2 Append Years 2019-2021.dta"

rename I10_DX4 icddiagnosiscode

merge m:1 icddiagnosiscode using "Z:\Total Data April 4 2018\Onetomap Databases\NTDB_TQIP Dataset\TQIP_USF_V2\PUF AY 2022\STATA\PUF_ICDDIAGNOSIS_LOOKUP.dta" 

keep if _merge == 3 
drop _merge 

rename icddiagnosiscode icddiagnosiscode_4
rename icddiagnosiscode_desc icddiagnosiscode_desc_4

keep KEY_NIS icddiagnosiscode_4 icddiagnosiscode_desc_4

save "Y:\Rachel Wolansky\Transplant and Trauma\HCUP\Data Out\Trauma Codes I10_DX4.dta", replace

*********************************I10_DX5******************************
clear
use "Y:\Rachel Wolansky\Transplant and Trauma\HCUP\Data Out\Step 2 Append Years 2019-2021.dta"

rename I10_DX5 icddiagnosiscode

merge m:1 icddiagnosiscode using "Z:\Total Data April 4 2018\Onetomap Databases\NTDB_TQIP Dataset\TQIP_USF_V2\PUF AY 2022\STATA\PUF_ICDDIAGNOSIS_LOOKUP.dta" 

keep if _merge == 3 
drop _merge 

rename icddiagnosiscode icddiagnosiscode_5
rename icddiagnosiscode_desc icddiagnosiscode_desc_5

keep KEY_NIS icddiagnosiscode_5 icddiagnosiscode_desc_5

save "Y:\Rachel Wolansky\Transplant and Trauma\HCUP\Data Out\Trauma Codes I10_DX5.dta", replace

*********************************I10_DX6******************************
clear
use "Y:\Rachel Wolansky\Transplant and Trauma\HCUP\Data Out\Step 2 Append Years 2019-2021.dta"

rename I10_DX6 icddiagnosiscode

merge m:1 icddiagnosiscode using "Z:\Total Data April 4 2018\Onetomap Databases\NTDB_TQIP Dataset\TQIP_USF_V2\PUF AY 2022\STATA\PUF_ICDDIAGNOSIS_LOOKUP.dta" 

keep if _merge == 3 
drop _merge 

rename icddiagnosiscode icddiagnosiscode_6
rename icddiagnosiscode_desc icddiagnosiscode_desc_6

keep KEY_NIS icddiagnosiscode_6 icddiagnosiscode_desc_6

save "Y:\Rachel Wolansky\Transplant and Trauma\HCUP\Data Out\Trauma Codes I10_DX6.dta", replace

*********************************I10_DX7******************************
clear
use "Y:\Rachel Wolansky\Transplant and Trauma\HCUP\Data Out\Step 2 Append Years 2019-2021.dta"

rename I10_DX7 icddiagnosiscode

merge m:1 icddiagnosiscode using "Z:\Total Data April 4 2018\Onetomap Databases\NTDB_TQIP Dataset\TQIP_USF_V2\PUF AY 2022\STATA\PUF_ICDDIAGNOSIS_LOOKUP.dta" 

keep if _merge == 3 
drop _merge 

rename icddiagnosiscode icddiagnosiscode_7
rename icddiagnosiscode_desc icddiagnosiscode_desc_7

keep KEY_NIS icddiagnosiscode_7 icddiagnosiscode_desc_7

save "Y:\Rachel Wolansky\Transplant and Trauma\HCUP\Data Out\Trauma Codes I10_DX7.dta", replace

*********************************I10_DX8******************************
clear
use "Y:\Rachel Wolansky\Transplant and Trauma\HCUP\Data Out\Step 2 Append Years 2019-2021.dta"

rename I10_DX8 icddiagnosiscode

merge m:1 icddiagnosiscode using "Z:\Total Data April 4 2018\Onetomap Databases\NTDB_TQIP Dataset\TQIP_USF_V2\PUF AY 2022\STATA\PUF_ICDDIAGNOSIS_LOOKUP.dta" 

keep if _merge == 3 
drop _merge 

rename icddiagnosiscode icddiagnosiscode_8
rename icddiagnosiscode_desc icddiagnosiscode_desc_8

keep KEY_NIS icddiagnosiscode_8 icddiagnosiscode_desc_8

save "Y:\Rachel Wolansky\Transplant and Trauma\HCUP\Data Out\Trauma Codes I10_DX8.dta", replace

*********************************I10_DX9******************************
clear
use "Y:\Rachel Wolansky\Transplant and Trauma\HCUP\Data Out\Step 2 Append Years 2019-2021.dta"
rename I10_DX9 icddiagnosiscode

merge m:1 icddiagnosiscode using "Z:\Total Data April 4 2018\Onetomap Databases\NTDB_TQIP Dataset\TQIP_USF_V2\PUF AY 2022\STATA\PUF_ICDDIAGNOSIS_LOOKUP.dta" 

keep if _merge == 3 
drop _merge 

rename icddiagnosiscode icddiagnosiscode_9
rename icddiagnosiscode_desc icddiagnosiscode_desc_9

keep KEY_NIS icddiagnosiscode_9 icddiagnosiscode_desc_9

save "Y:\Rachel Wolansky\Transplant and Trauma\HCUP\Data Out\Trauma Codes I10_DX9.dta", replace

*********************************I10_DX10******************************
clear
use "Y:\Rachel Wolansky\Transplant and Trauma\HCUP\Data Out\Step 2 Append Years 2019-2021.dta"
rename I10_DX10 icddiagnosiscode
merge m:1 icddiagnosiscode using "Z:\Total Data April 4 2018\Onetomap Databases\NTDB_TQIP Dataset\TQIP_USF_V2\PUF AY 2022\STATA\PUF_ICDDIAGNOSIS_LOOKUP.dta" 
keep if _merge == 3 
drop _merge 
rename icddiagnosiscode icddiagnosiscode_10
rename icddiagnosiscode_desc icddiagnosiscode_desc_10
keep KEY_NIS icddiagnosiscode_10 icddiagnosiscode_desc_10
save "Y:\Rachel Wolansky\Transplant and Trauma\HCUP\Data Out\Trauma Codes I10_DX10.dta", replace

*********************************I10_DX11******************************
clear
use "Y:\Rachel Wolansky\Transplant and Trauma\HCUP\Data Out\Step 2 Append Years 2019-2021.dta"
rename I10_DX11 icddiagnosiscode
merge m:1 icddiagnosiscode using "Z:\Total Data April 4 2018\Onetomap Databases\NTDB_TQIP Dataset\TQIP_USF_V2\PUF AY 2022\STATA\PUF_ICDDIAGNOSIS_LOOKUP.dta" 
keep if _merge == 3 
drop _merge 
rename icddiagnosiscode icddiagnosiscode_11
rename icddiagnosiscode_desc icddiagnosiscode_desc_11
keep KEY_NIS icddiagnosiscode_11 icddiagnosiscode_desc_11
save "Y:\Rachel Wolansky\Transplant and Trauma\HCUP\Data Out\Trauma Codes I10_DX11.dta", replace

*********************************I10_DX12******************************
clear
use "Y:\Rachel Wolansky\Transplant and Trauma\HCUP\Data Out\Step 2 Append Years 2019-2021.dta"
rename I10_DX12 icddiagnosiscode
merge m:1 icddiagnosiscode using "Z:\Total Data April 4 2018\Onetomap Databases\NTDB_TQIP Dataset\TQIP_USF_V2\PUF AY 2022\STATA\PUF_ICDDIAGNOSIS_LOOKUP.dta" 
keep if _merge == 3 
drop _merge 
rename icddiagnosiscode icddiagnosiscode_12
rename icddiagnosiscode_desc icddiagnosiscode_desc_12
keep KEY_NIS icddiagnosiscode_12 icddiagnosiscode_desc_12
save "Y:\Rachel Wolansky\Transplant and Trauma\HCUP\Data Out\Trauma Codes I10_DX12.dta", replace

*********************************I10_DX13******************************
clear
use "Y:\Rachel Wolansky\Transplant and Trauma\HCUP\Data Out\Step 2 Append Years 2019-2021.dta"
rename I10_DX13 icddiagnosiscode
merge m:1 icddiagnosiscode using "Z:\Total Data April 4 2018\Onetomap Databases\NTDB_TQIP Dataset\TQIP_USF_V2\PUF AY 2022\STATA\PUF_ICDDIAGNOSIS_LOOKUP.dta" 
keep if _merge == 3 
drop _merge 
rename icddiagnosiscode icddiagnosiscode_13
rename icddiagnosiscode_desc icddiagnosiscode_desc_13
keep KEY_NIS icddiagnosiscode_13 icddiagnosiscode_desc_13
save "Y:\Rachel Wolansky\Transplant and Trauma\HCUP\Data Out\Trauma Codes I10_DX13.dta", replace

*********************************I10_DX14******************************
clear
use "Y:\Rachel Wolansky\Transplant and Trauma\HCUP\Data Out\Step 2 Append Years 2019-2021.dta"
rename I10_DX14 icddiagnosiscode
merge m:1 icddiagnosiscode using "Z:\Total Data April 4 2018\Onetomap Databases\NTDB_TQIP Dataset\TQIP_USF_V2\PUF AY 2022\STATA\PUF_ICDDIAGNOSIS_LOOKUP.dta" 
keep if _merge == 3 
drop _merge 
rename icddiagnosiscode icddiagnosiscode_14
rename icddiagnosiscode_desc icddiagnosiscode_desc_14
keep KEY_NIS icddiagnosiscode_14 icddiagnosiscode_desc_14
save "Y:\Rachel Wolansky\Transplant and Trauma\HCUP\Data Out\Trauma Codes I10_DX14.dta", replace

*********************************I10_DX15******************************
clear
use "Y:\Rachel Wolansky\Transplant and Trauma\HCUP\Data Out\Step 2 Append Years 2019-2021.dta"
rename I10_DX15 icddiagnosiscode
merge m:1 icddiagnosiscode using "Z:\Total Data April 4 2018\Onetomap Databases\NTDB_TQIP Dataset\TQIP_USF_V2\PUF AY 2022\STATA\PUF_ICDDIAGNOSIS_LOOKUP.dta" 
keep if _merge == 3 
drop _merge 
rename icddiagnosiscode icddiagnosiscode_15
rename icddiagnosiscode_desc icddiagnosiscode_desc_15
keep KEY_NIS icddiagnosiscode_15 icddiagnosiscode_desc_15
save "Y:\Rachel Wolansky\Transplant and Trauma\HCUP\Data Out\Trauma Codes I10_DX15.dta", replace

*********************************I10_DX16******************************
clear
use "Y:\Rachel Wolansky\Transplant and Trauma\HCUP\Data Out\Step 2 Append Years 2019-2021.dta"
rename I10_DX16 icddiagnosiscode
merge m:1 icddiagnosiscode using "Z:\Total Data April 4 2018\Onetomap Databases\NTDB_TQIP Dataset\TQIP_USF_V2\PUF AY 2022\STATA\PUF_ICDDIAGNOSIS_LOOKUP.dta" 
keep if _merge == 3 
drop _merge 
rename icddiagnosiscode icddiagnosiscode_16
rename icddiagnosiscode_desc icddiagnosiscode_desc_16
keep KEY_NIS icddiagnosiscode_16 icddiagnosiscode_desc_16
save "Y:\Rachel Wolansky\Transplant and Trauma\HCUP\Data Out\Trauma Codes I10_DX16.dta", replace

*********************************I10_DX17******************************
clear
use "Y:\Rachel Wolansky\Transplant and Trauma\HCUP\Data Out\Step 2 Append Years 2019-2021.dta"
rename I10_DX17 icddiagnosiscode
merge m:1 icddiagnosiscode using "Z:\Total Data April 4 2018\Onetomap Databases\NTDB_TQIP Dataset\TQIP_USF_V2\PUF AY 2022\STATA\PUF_ICDDIAGNOSIS_LOOKUP.dta" 
keep if _merge == 3 
drop _merge 
rename icddiagnosiscode icddiagnosiscode_17
rename icddiagnosiscode_desc icddiagnosiscode_desc_17
keep KEY_NIS icddiagnosiscode_17 icddiagnosiscode_desc_17
save "Y:\Rachel Wolansky\Transplant and Trauma\HCUP\Data Out\Trauma Codes I10_DX17.dta", replace

*********************************I10_DX18******************************
clear
use "Y:\Rachel Wolansky\Transplant and Trauma\HCUP\Data Out\Step 2 Append Years 2019-2021.dta"
rename I10_DX18 icddiagnosiscode
merge m:1 icddiagnosiscode using "Z:\Total Data April 4 2018\Onetomap Databases\NTDB_TQIP Dataset\TQIP_USF_V2\PUF AY 2022\STATA\PUF_ICDDIAGNOSIS_LOOKUP.dta" 
keep if _merge == 3 
drop _merge 
rename icddiagnosiscode icddiagnosiscode_18
rename icddiagnosiscode_desc icddiagnosiscode_desc_18
keep KEY_NIS icddiagnosiscode_18 icddiagnosiscode_desc_18
save "Y:\Rachel Wolansky\Transplant and Trauma\HCUP\Data Out\Trauma Codes I10_DX18.dta", replace

*********************************I10_DX19******************************
clear
use "Y:\Rachel Wolansky\Transplant and Trauma\HCUP\Data Out\Step 2 Append Years 2019-2021.dta"
rename I10_DX19 icddiagnosiscode
merge m:1 icddiagnosiscode using "Z:\Total Data April 4 2018\Onetomap Databases\NTDB_TQIP Dataset\TQIP_USF_V2\PUF AY 2022\STATA\PUF_ICDDIAGNOSIS_LOOKUP.dta" 
keep if _merge == 3 
drop _merge 
rename icddiagnosiscode icddiagnosiscode_19
rename icddiagnosiscode_desc icddiagnosiscode_desc_19
keep KEY_NIS icddiagnosiscode_19 icddiagnosiscode_desc_19
save "Y:\Rachel Wolansky\Transplant and Trauma\HCUP\Data Out\Trauma Codes I10_DX19.dta", replace

*********************************I10_DX20******************************
clear
use "Y:\Rachel Wolansky\Transplant and Trauma\HCUP\Data Out\Step 2 Append Years 2019-2021.dta"
rename I10_DX20 icddiagnosiscode
merge m:1 icddiagnosiscode using "Z:\Total Data April 4 2018\Onetomap Databases\NTDB_TQIP Dataset\TQIP_USF_V2\PUF AY 2022\STATA\PUF_ICDDIAGNOSIS_LOOKUP.dta" 
keep if _merge == 3 
drop _merge 
rename icddiagnosiscode icddiagnosiscode_20
rename icddiagnosiscode_desc icddiagnosiscode_desc_20
keep KEY_NIS icddiagnosiscode_20 icddiagnosiscode_desc_20
save "Y:\Rachel Wolansky\Transplant and Trauma\HCUP\Data Out\Trauma Codes I10_DX20.dta", replace

*********************************I10_DX21******************************
clear
use "Y:\Rachel Wolansky\Transplant and Trauma\HCUP\Data Out\Step 2 Append Years 2019-2021.dta"
rename I10_DX21 icddiagnosiscode
merge m:1 icddiagnosiscode using "Z:\Total Data April 4 2018\Onetomap Databases\NTDB_TQIP Dataset\TQIP_USF_V2\PUF AY 2022\STATA\PUF_ICDDIAGNOSIS_LOOKUP.dta" 
keep if _merge == 3 
drop _merge 
rename icddiagnosiscode icddiagnosiscode_21
rename icddiagnosiscode_desc icddiagnosiscode_desc_21
keep KEY_NIS icddiagnosiscode_21 icddiagnosiscode_desc_21
save "Y:\Rachel Wolansky\Transplant and Trauma\HCUP\Data Out\Trauma Codes I10_DX21.dta", replace

*********************************I10_DX22******************************
clear
use "Y:\Rachel Wolansky\Transplant and Trauma\HCUP\Data Out\Step 2 Append Years 2019-2021.dta"
rename I10_DX22 icddiagnosiscode
merge m:1 icddiagnosiscode using "Z:\Total Data April 4 2018\Onetomap Databases\NTDB_TQIP Dataset\TQIP_USF_V2\PUF AY 2022\STATA\PUF_ICDDIAGNOSIS_LOOKUP.dta" 
keep if _merge == 3 
drop _merge 
rename icddiagnosiscode icddiagnosiscode_22
rename icddiagnosiscode_desc icddiagnosiscode_desc_22
keep KEY_NIS icddiagnosiscode_22 icddiagnosiscode_desc_22
save "Y:\Rachel Wolansky\Transplant and Trauma\HCUP\Data Out\Trauma Codes I10_DX22.dta", replace

*********************************I10_DX23******************************
clear
use "Y:\Rachel Wolansky\Transplant and Trauma\HCUP\Data Out\Step 2 Append Years 2019-2021.dta"
rename I10_DX23 icddiagnosiscode
merge m:1 icddiagnosiscode using "Z:\Total Data April 4 2018\Onetomap Databases\NTDB_TQIP Dataset\TQIP_USF_V2\PUF AY 2022\STATA\PUF_ICDDIAGNOSIS_LOOKUP.dta" 
keep if _merge == 3 
drop _merge 
rename icddiagnosiscode icddiagnosiscode_23
rename icddiagnosiscode_desc icddiagnosiscode_desc_23
keep KEY_NIS icddiagnosiscode_23 icddiagnosiscode_desc_23
save "Y:\Rachel Wolansky\Transplant and Trauma\HCUP\Data Out\Trauma Codes I10_DX23.dta", replace

*********************************I10_DX24******************************
clear
use "Y:\Rachel Wolansky\Transplant and Trauma\HCUP\Data Out\Step 2 Append Years 2019-2021.dta"
rename I10_DX24 icddiagnosiscode
merge m:1 icddiagnosiscode using "Z:\Total Data April 4 2018\Onetomap Databases\NTDB_TQIP Dataset\TQIP_USF_V2\PUF AY 2022\STATA\PUF_ICDDIAGNOSIS_LOOKUP.dta" 
keep if _merge == 3 
drop _merge 
rename icddiagnosiscode icddiagnosiscode_24
rename icddiagnosiscode_desc icddiagnosiscode_desc_24
keep KEY_NIS icddiagnosiscode_24 icddiagnosiscode_desc_24
save "Y:\Rachel Wolansky\Transplant and Trauma\HCUP\Data Out\Trauma Codes I10_DX24.dta", replace

*********************************I10_DX25******************************
clear
use "Y:\Rachel Wolansky\Transplant and Trauma\HCUP\Data Out\Step 2 Append Years 2019-2021.dta"
rename I10_DX25 icddiagnosiscode
merge m:1 icddiagnosiscode using "Z:\Total Data April 4 2018\Onetomap Databases\NTDB_TQIP Dataset\TQIP_USF_V2\PUF AY 2022\STATA\PUF_ICDDIAGNOSIS_LOOKUP.dta" 
keep if _merge == 3 
drop _merge 
rename icddiagnosiscode icddiagnosiscode_25
rename icddiagnosiscode_desc icddiagnosiscode_desc_25
keep KEY_NIS icddiagnosiscode_25 icddiagnosiscode_desc_25
save "Y:\Rachel Wolansky\Transplant and Trauma\HCUP\Data Out\Trauma Codes I10_DX25.dta", replace

*********************************I10_DX26******************************
clear
use "Y:\Rachel Wolansky\Transplant and Trauma\HCUP\Data Out\Step 2 Append Years 2019-2021.dta"
rename I10_DX26 icddiagnosiscode
merge m:1 icddiagnosiscode using "Z:\Total Data April 4 2018\Onetomap Databases\NTDB_TQIP Dataset\TQIP_USF_V2\PUF AY 2022\STATA\PUF_ICDDIAGNOSIS_LOOKUP.dta" 
keep if _merge == 3 
drop _merge 
rename icddiagnosiscode icddiagnosiscode_26
rename icddiagnosiscode_desc icddiagnosiscode_desc_26
keep KEY_NIS icddiagnosiscode_26 icddiagnosiscode_desc_26
save "Y:\Rachel Wolansky\Transplant and Trauma\HCUP\Data Out\Trauma Codes I10_DX26.dta", replace

*********************************I10_DX27******************************
clear
use "Y:\Rachel Wolansky\Transplant and Trauma\HCUP\Data Out\Step 2 Append Years 2019-2021.dta"
rename I10_DX27 icddiagnosiscode
merge m:1 icddiagnosiscode using "Z:\Total Data April 4 2018\Onetomap Databases\NTDB_TQIP Dataset\TQIP_USF_V2\PUF AY 2022\STATA\PUF_ICDDIAGNOSIS_LOOKUP.dta" 
keep if _merge == 3 
drop _merge 
rename icddiagnosiscode icddiagnosiscode_27
rename icddiagnosiscode_desc icddiagnosiscode_desc_27
keep KEY_NIS icddiagnosiscode_27 icddiagnosiscode_desc_27
save "Y:\Rachel Wolansky\Transplant and Trauma\HCUP\Data Out\Trauma Codes I10_DX27.dta", replace

*********************************I10_DX28******************************
clear
use "Y:\Rachel Wolansky\Transplant and Trauma\HCUP\Data Out\Step 2 Append Years 2019-2021.dta"
rename I10_DX28 icddiagnosiscode
merge m:1 icddiagnosiscode using "Z:\Total Data April 4 2018\Onetomap Databases\NTDB_TQIP Dataset\TQIP_USF_V2\PUF AY 2022\STATA\PUF_ICDDIAGNOSIS_LOOKUP.dta" 
keep if _merge == 3 
drop _merge 
rename icddiagnosiscode icddiagnosiscode_28
rename icddiagnosiscode_desc icddiagnosiscode_desc_28
keep KEY_NIS icddiagnosiscode_28 icddiagnosiscode_desc_28
save "Y:\Rachel Wolansky\Transplant and Trauma\HCUP\Data Out\Trauma Codes I10_DX28.dta", replace

*********************************I10_DX29******************************
clear
use "Y:\Rachel Wolansky\Transplant and Trauma\HCUP\Data Out\Step 2 Append Years 2019-2021.dta"
rename I10_DX29 icddiagnosiscode
merge m:1 icddiagnosiscode using "Z:\Total Data April 4 2018\Onetomap Databases\NTDB_TQIP Dataset\TQIP_USF_V2\PUF AY 2022\STATA\PUF_ICDDIAGNOSIS_LOOKUP.dta" 
keep if _merge == 3 
drop _merge 
rename icddiagnosiscode icddiagnosiscode_29
rename icddiagnosiscode_desc icddiagnosiscode_desc_29
keep KEY_NIS icddiagnosiscode_29 icddiagnosiscode_desc_29
save "Y:\Rachel Wolansky\Transplant and Trauma\HCUP\Data Out\Trauma Codes I10_DX29.dta", replace

*********************************I10_DX30******************************
clear
use "Y:\Rachel Wolansky\Transplant and Trauma\HCUP\Data Out\Step 2 Append Years 2019-2021.dta"
rename I10_DX30 icddiagnosiscode
merge m:1 icddiagnosiscode using "Z:\Total Data April 4 2018\Onetomap Databases\NTDB_TQIP Dataset\TQIP_USF_V2\PUF AY 2022\STATA\PUF_ICDDIAGNOSIS_LOOKUP.dta" 
keep if _merge == 3 
drop _merge 
rename icddiagnosiscode icddiagnosiscode_30
rename icddiagnosiscode_desc icddiagnosiscode_desc_30
keep KEY_NIS icddiagnosiscode_30 icddiagnosiscode_desc_30
save "Y:\Rachel Wolansky\Transplant and Trauma\HCUP\Data Out\Trauma Codes I10_DX30.dta", replace

*********************************I10_DX31******************************
clear
use "Y:\Rachel Wolansky\Transplant and Trauma\HCUP\Data Out\Step 2 Append Years 2019-2021.dta"
rename I10_DX31 icddiagnosiscode
merge m:1 icddiagnosiscode using "Z:\Total Data April 4 2018\Onetomap Databases\NTDB_TQIP Dataset\TQIP_USF_V2\PUF AY 2022\STATA\PUF_ICDDIAGNOSIS_LOOKUP.dta" 
keep if _merge == 3 
drop _merge 
rename icddiagnosiscode icddiagnosiscode_31
rename icddiagnosiscode_desc icddiagnosiscode_desc_31
keep KEY_NIS icddiagnosiscode_31 icddiagnosiscode_desc_31
save "Y:\Rachel Wolansky\Transplant and Trauma\HCUP\Data Out\Trauma Codes I10_DX31.dta", replace

*********************************I10_DX32******************************
clear
use "Y:\Rachel Wolansky\Transplant and Trauma\HCUP\Data Out\Step 2 Append Years 2019-2021.dta"
rename I10_DX32 icddiagnosiscode
merge m:1 icddiagnosiscode using "Z:\Total Data April 4 2018\Onetomap Databases\NTDB_TQIP Dataset\TQIP_USF_V2\PUF AY 2022\STATA\PUF_ICDDIAGNOSIS_LOOKUP.dta" 
keep if _merge == 3 
drop _merge 
rename icddiagnosiscode icddiagnosiscode_32
rename icddiagnosiscode_desc icddiagnosiscode_desc_32
keep KEY_NIS icddiagnosiscode_32 icddiagnosiscode_desc_32
save "Y:\Rachel Wolansky\Transplant and Trauma\HCUP\Data Out\Trauma Codes I10_DX32.dta", replace

*********************************I10_DX33******************************
clear
use "Y:\Rachel Wolansky\Transplant and Trauma\HCUP\Data Out\Step 2 Append Years 2019-2021.dta"
rename I10_DX33 icddiagnosiscode
merge m:1 icddiagnosiscode using "Z:\Total Data April 4 2018\Onetomap Databases\NTDB_TQIP Dataset\TQIP_USF_V2\PUF AY 2022\STATA\PUF_ICDDIAGNOSIS_LOOKUP.dta" 
keep if _merge == 3 
drop _merge 
rename icddiagnosiscode icddiagnosiscode_33
rename icddiagnosiscode_desc icddiagnosiscode_desc_33
keep KEY_NIS icddiagnosiscode_33 icddiagnosiscode_desc_33
save "Y:\Rachel Wolansky\Transplant and Trauma\HCUP\Data Out\Trauma Codes I10_DX33.dta", replace

*********************************I10_DX34******************************
clear
use "Y:\Rachel Wolansky\Transplant and Trauma\HCUP\Data Out\Step 2 Append Years 2019-2021.dta"
rename I10_DX34 icddiagnosiscode
merge m:1 icddiagnosiscode using "Z:\Total Data April 4 2018\Onetomap Databases\NTDB_TQIP Dataset\TQIP_USF_V2\PUF AY 2022\STATA\PUF_ICDDIAGNOSIS_LOOKUP.dta" 
keep if _merge == 3 
drop _merge 
rename icddiagnosiscode icddiagnosiscode_34
rename icddiagnosiscode_desc icddiagnosiscode_desc_34
keep KEY_NIS icddiagnosiscode_34 icddiagnosiscode_desc_34
save "Y:\Rachel Wolansky\Transplant and Trauma\HCUP\Data Out\Trauma Codes I10_DX34.dta", replace

*********************************I10_DX35******************************
clear
use "Y:\Rachel Wolansky\Transplant and Trauma\HCUP\Data Out\Step 2 Append Years 2019-2021.dta"
rename I10_DX35 icddiagnosiscode
merge m:1 icddiagnosiscode using "Z:\Total Data April 4 2018\Onetomap Databases\NTDB_TQIP Dataset\TQIP_USF_V2\PUF AY 2022\STATA\PUF_ICDDIAGNOSIS_LOOKUP.dta" 
keep if _merge == 3 
drop _merge 
rename icddiagnosiscode icddiagnosiscode_35
rename icddiagnosiscode_desc icddiagnosiscode_desc_35
keep KEY_NIS icddiagnosiscode_35 icddiagnosiscode_desc_35
save "Y:\Rachel Wolansky\Transplant and Trauma\HCUP\Data Out\Trauma Codes I10_DX35.dta", replace

*********************************I10_DX36******************************
clear
use "Y:\Rachel Wolansky\Transplant and Trauma\HCUP\Data Out\Step 2 Append Years 2019-2021.dta"
rename I10_DX36 icddiagnosiscode
merge m:1 icddiagnosiscode using "Z:\Total Data April 4 2018\Onetomap Databases\NTDB_TQIP Dataset\TQIP_USF_V2\PUF AY 2022\STATA\PUF_ICDDIAGNOSIS_LOOKUP.dta" 
keep if _merge == 3 
drop _merge 
rename icddiagnosiscode icddiagnosiscode_36
rename icddiagnosiscode_desc icddiagnosiscode_desc_36
keep KEY_NIS icddiagnosiscode_36 icddiagnosiscode_desc_36
save "Y:\Rachel Wolansky\Transplant and Trauma\HCUP\Data Out\Trauma Codes I10_DX36.dta", replace

*********************************I10_DX37******************************
clear
use "Y:\Rachel Wolansky\Transplant and Trauma\HCUP\Data Out\Step 2 Append Years 2019-2021.dta"
rename I10_DX37 icddiagnosiscode
merge m:1 icddiagnosiscode using "Z:\Total Data April 4 2018\Onetomap Databases\NTDB_TQIP Dataset\TQIP_USF_V2\PUF AY 2022\STATA\PUF_ICDDIAGNOSIS_LOOKUP.dta" 
keep if _merge == 3 
drop _merge 
rename icddiagnosiscode icddiagnosiscode_37
rename icddiagnosiscode_desc icddiagnosiscode_desc_37
keep KEY_NIS icddiagnosiscode_37 icddiagnosiscode_desc_37
save "Y:\Rachel Wolansky\Transplant and Trauma\HCUP\Data Out\Trauma Codes I10_DX37.dta", replace

*********************************I10_DX38******************************
clear
use "Y:\Rachel Wolansky\Transplant and Trauma\HCUP\Data Out\Step 2 Append Years 2019-2021.dta"
rename I10_DX38 icddiagnosiscode
merge m:1 icddiagnosiscode using "Z:\Total Data April 4 2018\Onetomap Databases\NTDB_TQIP Dataset\TQIP_USF_V2\PUF AY 2022\STATA\PUF_ICDDIAGNOSIS_LOOKUP.dta" 
keep if _merge == 3 
drop _merge 
rename icddiagnosiscode icddiagnosiscode_38
rename icddiagnosiscode_desc icddiagnosiscode_desc_38
keep KEY_NIS icddiagnosiscode_38 icddiagnosiscode_desc_38
save "Y:\Rachel Wolansky\Transplant and Trauma\HCUP\Data Out\Trauma Codes I10_DX38.dta", replace

*********************************I10_DX39******************************
clear
use "Y:\Rachel Wolansky\Transplant and Trauma\HCUP\Data Out\Step 2 Append Years 2019-2021.dta"
rename I10_DX39 icddiagnosiscode
merge m:1 icddiagnosiscode using "Z:\Total Data April 4 2018\Onetomap Databases\NTDB_TQIP Dataset\TQIP_USF_V2\PUF AY 2022\STATA\PUF_ICDDIAGNOSIS_LOOKUP.dta" 
keep if _merge == 3 
drop _merge 
rename icddiagnosiscode icddiagnosiscode_39
rename icddiagnosiscode_desc icddiagnosiscode_desc_39
keep KEY_NIS icddiagnosiscode_39 icddiagnosiscode_desc_39
save "Y:\Rachel Wolansky\Transplant and Trauma\HCUP\Data Out\Trauma Codes I10_DX39.dta", replace

*********************************I10_DX40******************************
clear
use "Y:\Rachel Wolansky\Transplant and Trauma\HCUP\Data Out\Step 2 Append Years 2019-2021.dta"
rename I10_DX40 icddiagnosiscode
merge m:1 icddiagnosiscode using "Z:\Total Data April 4 2018\Onetomap Databases\NTDB_TQIP Dataset\TQIP_USF_V2\PUF AY 2022\STATA\PUF_ICDDIAGNOSIS_LOOKUP.dta" 
keep if _merge == 3 
drop _merge 
rename icddiagnosiscode icddiagnosiscode_40
rename icddiagnosiscode_desc icddiagnosiscode_desc_40
keep KEY_NIS icddiagnosiscode_40 icddiagnosiscode_desc_40
save "Y:\Rachel Wolansky\Transplant and Trauma\HCUP\Data Out\Trauma Codes I10_DX40.dta", replace