clear
use "Y:\Rachel Wolansky\Transplant and Trauma\HCUP\Data Out\Step 5 Merged ICD Descriptions.dta"

*These are redudant, dropping
drop I10_DX1-I10_DX40
*Not going to use these variables, dropping
drop AGE_NEONATE AMONTH DISCWT DQTR I10_BIRTH I10_DELIVERY I10_SERVICELINE NIS_STRATUM MDC_NoPOA MDC

***Only want to keep people that have a traumatic ICD10 code somewhere in their diagnosis list
***Traumatic ICD10 codes start with the letter "S"
forvalues i = 1/40 {
    gen trauma_`i' = substr(icddiagnosiscode_`i', 1, 1)=="S"
}
egen any_trauma = rowmax(trauma_*)
keep if any_trauma == 1
drop trauma_* any_trauma

fre kidneytxp
fre livertxp

fre PAY1
drop if PAY1 == .

fre DISPUNIFORM
gen nonhomedisch = 0
replace nonhomedisch = 1 if DISPUNIFORM == 2 | DISPUNIFORM == 5
fre nonhomedisch

fre APRDRG

fre nonhomedisch

gen DVT_PE = 0
forvalues i = 1/40 {
   replace DVT_PE = 1 if icddiagnosiscode_`i' == "I8240" | icddiagnosiscode_`i' == "I82401" | ///
                           icddiagnosiscode_`i' == "I82402" | icddiagnosiscode_`i' == "I82409" | ///
                           icddiagnosiscode_`i' == "I82403" | icddiagnosiscode_`i' == "I2609" | ///
                           icddiagnosiscode_`i' == "I2699" | icddiagnosiscode_`i' == "I2693"
}

fre DVT_PE
count if kidneytxp == 1 & DVT_PE == 1
count if livertxp == 1 & DVT_PE == 1

keep AGE DIED nonhomedisch SEX RACE CMR_AIDS CMR_ALCOHOL CMR_CANCER_LEUK CMR_CANCER_LYMPH CMR_CANCER_METS CMR_CANCER_NSITU CMR_CANCER_SOLID CMR_DEMENTIA CMR_DEPRESS CMR_DIAB_CX CMR_DIAB_UNCX CMR_DRUG_ABUSE CMR_HTN_CX CMR_HTN_UNCX CMR_LUNG_CHRONIC CMR_OBESE CMR_PERIVASC CMR_THYROID_HYPO CMR_THYROID_OTH CMR_CKD HOSP_BEDSIZE HOSP_LOCTEACH HOSP_REGION H_CONTRL livertxp kidneytxp sepsis pna respfailure CMR_CKD renalfailure liverfailure DVT_PE LOS PAY1

save "Y:\Rachel Wolansky\Transplant and Trauma\HCUP\Data Out\Step 6 Ensuring Trauma Codes.dta", replace

keep if kidneytxp == 1 | livertxp != 1

save "Y:\Rachel Wolansky\Transplant and Trauma\HCUP\Data Out\Step 6 Ensuring Trauma Codes, Kidneys Only.dta", replace

table1_mc, by(kidneytxp) vars (AGE conts \ RACE cat \ SEX cat \ DIED cat \ nonhomedisch cat \ LOS conts \ PAY1 cat \ CMR_AIDS cat \ CMR_ALCOHOL cat \ CMR_CANCER_LEUK cat \ CMR_CANCER_LYMPH cat \ CMR_CANCER_METS cat \ CMR_CANCER_NSITU cat \ CMR_CANCER_SOLID cat \ CMR_DEMENTIA cat \ CMR_DEPRESS cat \ CMR_DIAB_CX cat \ CMR_DIAB_UNCX cat \ CMR_DRUG_ABUSE cat \ CMR_HTN_CX cat \ CMR_HTN_UNCX cat \ CMR_LUNG_CHRONIC cat \ CMR_OBESE cat \ CMR_PERIVASC cat \ CMR_THYROID_HYPO cat \ CMR_THYROID_OTH cat \ CMR_CKD cat \ HOSP_BEDSIZE cat \ HOSP_LOCTEACH cat \ HOSP_REGION cat \ H_CONTRL cat \ sepsis cat \ pna cat \ respfailure cat \ renalfailure cat \ liverfailure cat \ DVT_PE cat) saving ("TABLE Kidney Txps.xlsx", replace)

export delimited "Y:\Rachel Wolansky\Transplant and Trauma\HCUP\Data Out\Step 6 Ensuring Trauma Codes, Kidneys Only.csv", replace

clear
use "Y:\Rachel Wolansky\Transplant and Trauma\HCUP\Data Out\Step 6 Ensuring Trauma Codes.dta"

keep if livertxp == 1 | kidneytxp != 1

table1_mc, by(livertxp) vars (AGE conts \ RACE cat \ SEX cat \ DIED cat \ nonhomedisch cat \ LOS conts \ PAY1 cat \ CMR_AIDS cat \ CMR_ALCOHOL cat \ CMR_CANCER_LEUK cat \ CMR_CANCER_LYMPH cat \ CMR_CANCER_METS cat \ CMR_CANCER_NSITU cat \ CMR_CANCER_SOLID cat \ CMR_DEMENTIA cat \ CMR_DEPRESS cat \ CMR_DIAB_CX cat \ CMR_DIAB_UNCX cat \ CMR_DRUG_ABUSE cat \ CMR_HTN_CX cat \ CMR_HTN_UNCX cat \ CMR_LUNG_CHRONIC cat \ CMR_OBESE cat \ CMR_PERIVASC cat \ CMR_THYROID_HYPO cat \ CMR_THYROID_OTH cat \ CMR_CKD cat \ HOSP_BEDSIZE cat \ HOSP_LOCTEACH cat \ HOSP_REGION cat \ H_CONTRL cat \ sepsis cat \ pna cat \ respfailure cat \ renalfailure cat \ liverfailure cat \ DVT_PE cat) saving ("TABLE 1 Liver Txps.xlsx", replace)

save "Y:\Rachel Wolansky\Transplant and Trauma\HCUP\Data Out\Step 6 Ensuring Trauma Codes, Livers Only.dta", replace

export delimited "Y:\Rachel Wolansky\Transplant and Trauma\HCUP\Data Out\Step 6 Ensuring Trauma Codes, Livers Only.csv", replace