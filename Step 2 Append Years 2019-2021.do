clear
use "Y:\Rachel Wolansky\Transplant and Trauma\HCUP\Data Out\Step 1 Identify Transplants, Clean Vars 2021.dta"

append using "Y:\Rachel Wolansky\Transplant and Trauma\HCUP\Data Out\Step 1 Identify Transplants, Clean Vars 2020.dta"

append using "Y:\Rachel Wolansky\Transplant and Trauma\HCUP\Data Out\Step 1 Identify Transplants, Clean Vars 2019.dta"

save "Y:\Rachel Wolansky\Transplant and Trauma\HCUP\Data Out\Step 2 Append Years 2019-2021.dta", replace