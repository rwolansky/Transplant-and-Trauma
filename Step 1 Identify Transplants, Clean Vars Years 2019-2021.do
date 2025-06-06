clear 
use "Z:\Total Data April 4 2018\Onetomap Databases\HCUP Dataset\NIS_USF_2022\NIS_2019\NIS_2019.dta"

/* keeping only blunt trauma mechanisms
EXT003 - Fall
EXT007 - MVT
EXT008 - motor vehicle (not traffic... whatever that means), pedal cyclist
EXT009 - motor vehicle (not traffic), pedestrian
EXT010 - motor vehicle (not traffic), other transport type
EXT016 - struck by/against
*/

***1 = triggered by only the principal diagnosis code. 3 = triggered by only secondary diagnosis code
keep if DXCCSR_EXT003 == 1 | DXCCSR_EXT007 == 1 | DXCCSR_EXT008 == 1 | DXCCSR_EXT009 == 1 | DXCCSR_EXT010 == 1 | DXCCSR_EXT016 == 1  | DXCCSR_EXT003 == 3 | DXCCSR_EXT007 == 3 | DXCCSR_EXT008 == 3 | DXCCSR_EXT009 == 3 | DXCCSR_EXT010 == 3 | DXCCSR_EXT016 == 3

***trauma isn't elective
keep if ELECTIVE == 0

gen livertxp = .
forval i = 1/40{
replace livertxp = 1 if (I10_DX`i' == "Z4823" |I10_DX`i' == "Z944")
}

gen kidneytxp = .
forval i = 1/40{
replace kidneytxp = 1 if (I10_DX`i' == "Z4822" |I10_DX`i' == "Z940")
}
replace kidneytxp = 0 if kidneytxp == .
replace livertxp = 0 if livertxp == .

count if kidneytxp == 1 & livertxp == 1 
drop if kidneytxp == 1 & livertxp == 1 

fre kidneytxp
fre livertxp

fre AGE
drop if AGE <18 | AGE == .

fre DIED
drop if DIED == .

fre DISPUNIFORM
drop if DISPUNIFORM == 99

fre RACE
drop if RACE == .

fre FEMALE
drop if FEMALE == .
**Male 0, female 1
rename FEMALE SEX, replace

fre LOS
drop if LOS == .

fre HOSP_BEDSIZE
fre HOSP_LOCTEACH
fre H_CONTRL
fre HOSP_REGION

fre APRDRG_Severity
drop if APRDRG_Severity == 0

fre APRDRG_Risk_Mortality

**CMR ARTH is only present in 2019
fre CMR_AIDS CMR_ALCOHOL CMR_ARTH CMR_CANCER_LEUK CMR_CANCER_LYMPH CMR_CANCER_METS CMR_CANCER_NSITU CMR_CANCER_SOLID CMR_DEMENTIA CMR_DEPRESS CMR_DIAB_CX CMR_DIAB_UNCX CMR_DRUG_ABUSE CMR_HTN_CX CMR_HTN_UNCX CMR_LUNG_CHRONIC CMR_OBESE CMR_PERIVASC CMR_THYROID_HYPO CMR_THYROID_OTH

gen sepsis = 0
replace sepsis = 1 if DXCCSR_INF002 == 3
count if sepsis == 1 & kidneytxp == 1
count if sepsis == 1 & livertxp == 1

gen pna = 0
replace pna = 1 if DXCCSR_RSP002 == 3
count if pna == 1 & kidneytxp == 1
count if pna == 1 & livertxp == 1

gen respfailure = 0
replace respfailure = 1 if DXCCSR_RSP012 == 3
count if respfailure == 1 & kidneytxp == 1
count if respfailure == 1 & livertxp == 1

gen CMR_CKD = 0
replace CMR_CKD = 1 if DXCCSR_GEN003 == 3

gen renalfailure = 0
replace renalfailure = 1 if DXCCSR_GEN002 == 3
count if renalfailure == 1 & kidneytxp == 1
count if renalfailure == 1 & livertxp == 1

gen liverfailure = 0
forvalues i = 1/40 {
   replace liverfailure = 1 if I10_DX`i' == "K7200" | I10_DX`i' == "K7201"
}
count if liverfailure == 1 & kidneytxp == 1
count if liverfailure == 1 & livertxp == 1


save "Y:\Rachel Wolansky\Transplant and Trauma\HCUP\Data Out\Step 1 Identify Transplants, Clean Vars 2019.dta", replace


**# Bookmark #1
********2020
clear 
use "Z:\Total Data April 4 2018\Onetomap Databases\hcup18 21\NIS\NIS_2020\NIS 2020 Master.dta"

keep if DXCCSR_EXT003 == 1 | DXCCSR_EXT007 == 1 | DXCCSR_EXT008 == 1 | DXCCSR_EXT009 == 1 | DXCCSR_EXT010 == 1 | DXCCSR_EXT016 == 1  | DXCCSR_EXT003 == 3 | DXCCSR_EXT007 == 3 | DXCCSR_EXT008 == 3 | DXCCSR_EXT009 == 3 | DXCCSR_EXT010 == 3 | DXCCSR_EXT016 == 3

keep if ELECTIVE == 0

gen livertxp = .
forval i = 1/40{
replace livertxp = 1 if (I10_DX`i' == "Z4823" |I10_DX`i' == "Z944")
}

gen kidneytxp = .
forval i = 1/40{
replace kidneytxp = 1 if (I10_DX`i' == "Z4822" |I10_DX`i' == "Z940")
}
replace kidneytxp = 0 if kidneytxp == .
replace livertxp = 0 if livertxp == .

count if kidneytxp == 1 & livertxp == 1 
drop if kidneytxp == 1 & livertxp == 1 

fre kidneytxp
fre livertxp

fre AGE
drop if AGE <18 | AGE == .

fre DIED
drop if DIED == .

fre DISPUNIFORM
drop if DISPUNIFORM == 99

fre RACE
drop if RACE == .

fre FEMALE
drop if FEMALE == .
**Male 0, female 1
rename FEMALE SEX, replace

fre LOS
drop if LOS == .

fre HOSP_BEDSIZE
fre HOSP_LOCTEACH
fre H_CONTRL
fre HOSP_REGION

fre APRDRG_Severity
drop if APRDRG_Severity == 0

fre APRDRG_Risk_Mortality

fre CMR_AIDS CMR_ALCOHOL CMR_CANCER_LEUK CMR_CANCER_LYMPH CMR_CANCER_METS CMR_CANCER_NSITU CMR_CANCER_SOLID CMR_DEMENTIA CMR_DEPRESS CMR_DIAB_CX CMR_DIAB_UNCX CMR_DRUG_ABUSE CMR_HTN_CX CMR_HTN_UNCX CMR_LUNG_CHRONIC CMR_OBESE CMR_PERIVASC CMR_THYROID_HYPO CMR_THYROID_OTH

gen sepsis = 0
replace sepsis = 1 if DXCCSR_INF002 == 3
count if sepsis == 1 & kidneytxp == 1
count if sepsis == 1 & livertxp == 1

gen pna = 0
replace pna = 1 if DXCCSR_RSP002 == 3
count if pna == 1 & kidneytxp == 1
count if pna == 1 & livertxp == 1

gen respfailure = 0
replace respfailure = 1 if DXCCSR_RSP012 == 3
count if respfailure == 1 & kidneytxp == 1
count if respfailure == 1 & livertxp == 1

gen CMR_CKD = 0
replace CMR_CKD = 1 if DXCCSR_GEN003 == 3

gen renalfailure = 0
replace renalfailure = 1 if DXCCSR_GEN002 == 3
count if renalfailure == 1 & kidneytxp == 1
count if renalfailure == 1 & livertxp == 1

gen liverfailure = 0
forvalues i = 1/40 {
   replace liverfailure = 1 if I10_DX`i' == "K7200" | I10_DX`i' == "K7201"
}
count if liverfailure == 1 & kidneytxp == 1
count if liverfailure == 1 & livertxp == 1

save "Y:\Rachel Wolansky\Transplant and Trauma\HCUP\Data Out\Step 1 Identify Transplants, Clean Vars 2020.dta", replace

**# Bookmark #2
*****2021
clear 
use "Z:\Total Data April 4 2018\Onetomap Databases\hcup18 21\NIS\NIS_2021\NIS 2021 Master.dta"

keep if DXCCSR_EXT003 == 1 | DXCCSR_EXT007 == 1 | DXCCSR_EXT008 == 1 | DXCCSR_EXT009 == 1 | DXCCSR_EXT010 == 1 | DXCCSR_EXT016 == 1  | DXCCSR_EXT003 == 3 | DXCCSR_EXT007 == 3 | DXCCSR_EXT008 == 3 | DXCCSR_EXT009 == 3 | DXCCSR_EXT010 == 3 | DXCCSR_EXT016 == 3

keep if ELECTIVE == 0

gen livertxp = .
forval i = 1/40{
replace livertxp = 1 if (I10_DX`i' == "Z4823" |I10_DX`i' == "Z944")
}

gen kidneytxp = .
forval i = 1/40{
replace kidneytxp = 1 if (I10_DX`i' == "Z4822" |I10_DX`i' == "Z940")
}
replace kidneytxp = 0 if kidneytxp == .
replace livertxp = 0 if livertxp == .

count if kidneytxp == 1 & livertxp == 1 
drop if kidneytxp == 1 & livertxp == 1 

fre kidneytxp
fre livertxp

fre AGE
drop if AGE <18 | AGE == .

fre DIED
drop if DIED == .

fre DISPUNIFORM
drop if DISPUNIFORM == 99

fre RACE
drop if RACE == .

fre FEMALE
drop if FEMALE == .
**Male 0, female 1
rename FEMALE SEX, replace

fre LOS
drop if LOS == .

fre HOSP_BEDSIZE
fre HOSP_LOCTEACH
fre H_CONTRL
fre HOSP_REGION

fre APRDRG_Severity
drop if APRDRG_Severity == 0

fre APRDRG_Risk_Mortality

fre CMR_AIDS CMR_ALCOHOL CMR_CANCER_LEUK CMR_CANCER_LYMPH CMR_CANCER_METS CMR_CANCER_NSITU CMR_CANCER_SOLID CMR_DEMENTIA CMR_DEPRESS CMR_DIAB_CX CMR_DIAB_UNCX CMR_DRUG_ABUSE CMR_HTN_CX CMR_HTN_UNCX CMR_LUNG_CHRONIC CMR_OBESE CMR_PERIVASC CMR_THYROID_HYPO CMR_THYROID_OTH

gen sepsis = 0
replace sepsis = 1 if DXCCSR_INF002 == 3
count if sepsis == 1 & kidneytxp == 1
count if sepsis == 1 & livertxp == 1

gen pna = 0
replace pna = 1 if DXCCSR_RSP002 == 3
count if pna == 1 & kidneytxp == 1
count if pna == 1 & livertxp == 1

gen respfailure = 0
replace respfailure = 1 if DXCCSR_RSP012 == 3
count if respfailure == 1 & kidneytxp == 1
count if respfailure == 1 & livertxp == 1

gen CMR_CKD = 0
replace CMR_CKD = 1 if DXCCSR_GEN003 == 3

gen renalfailure = 0
replace renalfailure = 1 if DXCCSR_GEN002 == 3
count if renalfailure == 1 & kidneytxp == 1
count if renalfailure == 1 & livertxp == 1

gen liverfailure = 0
forvalues i = 1/40 {
   replace liverfailure = 1 if I10_DX`i' == "K7200" | I10_DX`i' == "K7201"
}
count if liverfailure == 1 & kidneytxp == 1
count if liverfailure == 1 & livertxp == 1

save "Y:\Rachel Wolansky\Transplant and Trauma\HCUP\Data Out\Step 1 Identify Transplants, Clean Vars 2021.dta", replace