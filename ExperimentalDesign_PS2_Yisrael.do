//Experimental Design PS2//
//DAIJA YISRAEL 
//March 16,2025 

cd "C:\Users\jacob\OneDrive\Desktop\PPOL_6818\week_05\03_assignment\01_data\"

use "q1_psle_student_raw.dta", clear

order schoolcode, b(s)

*SPLIT STRING BY ROW/OBSERVATIONS


*gen postition_table = strpos(s, "CAND. NO") // 3411 

**removing part of the string that is before the candidate column
gen new_string = substr(s,strpos(s, "CAND. NO"), .) 


display new_string[1]
split new_string, pars("</TD></TR>")
drop new_string1 s new_string


gen i = _n 
reshape long new_string, i(i) j(j)

split new_string, pars("</TD>")


split new_string4, pars(">")
drop new_string41
drop new_string42
drop new_string43

//Now I want to drop the last 6 characters 
gen name = substr(new_string44, 1, length(new_string44) - 6)
drop new_string44
drop new_string4

*create subjects column


split new_string5, pars(">")
drop new_string51
drop new_string52
drop new_string53

* split subjects to create kiswahili grade column  

split new_string54, pars(",")
split new_string541, pars("-")
rename new_string5412 Kiswahili
drop new_string5411

* split subjects to create english grade column  

split new_string542, pars("-")
rename new_string5422 English
drop new_string5421

* split subjects to create maarifa grade column  

split new_string543, pars("-")
rename new_string5432 Maarifa
drop new_string5431

* split subjects to create hisabati grade column  

split new_string544, pars("-")
rename new_string5442 Hisabati
drop new_string5441

* split subjects to create science grade column  

split new_string545, pars("-")
rename new_string5452 Science
drop new_string5451

* split subjects to create uraia grade column  

split new_string546, pars("-")
rename new_string5462 Uraia
drop new_string5461

* split subjects to create average grade column  

split new_string547, pars("-")
gen AverageGrade = substr(new_string5472, 1, length(new_string5472) - 6)
drop new_string5471
drop new_string5472
drop new_string54
drop new_string541
drop new_string542
drop new_string543
drop new_string544
drop new_string545
drop new_string546
drop new_string547

drop new_string5

*create gender column 
split new_string3, pars(">")
drop new_string31
drop new_string32
drop new_string33

split new_string34, pars("<")
drop new_string34
drop new_string342

rename new_string341 gender

drop new_string3

*create prem_number column 

split new_string2, pars(">")
drop new_string21
drop new_string22
drop new_string23
gen prem_number = substr(new_string24, 1, length(new_string24) - 6)
drop new_string24
drop new_string2


*create cand_id column 
split new_string1, pars(">")
drop new_string11
drop new_string12
drop new_string13
drop new_string14
gen cand_id = substr(new_string15, 1, length(new_string15) - 6)
drop new_string15

drop i j new_string new_string1

*organize data

order prem_number, a(schoolcode)
order cand_id, a(prem_number)
order gender, a(name)


*organize data

order cand_id, a(prem_number)
order gender, a(name)

replace prem_number="." if prem_number==""
replace cand_id ="." if cand_id ==""
replace name ="." if name ==""
replace gender ="." if gender ==""
replace Kiswahili ="." if Kiswahili ==""
replace English ="." if English ==""
replace Maarifa ="." if Maarifa ==""
replace Hisabati ="." if Hisabati =="" 
replace Science ="." if Science ==""
replace Uraia ="." if Uraia ==""
replace AverageGrade ="." if AverageGrade ==""

drop if AverageGrade == "."


******************************************************************************
*Q2: Côte d'Ivoire, Merge department-level density data from the excel sheet (CIV_populationdensity.xlsx) into the household data (CIV_Section_O.dta) 
******************************************************************************

clear 

global wd "\Users\jacob\OneDrive\Desktop\PPOL_6818\week_05\03_assignment\01_data\"

clear
global excel_cdi_popdens"$wd\\week_05\03_assignment\01_data\q2_CIV_populationdensity.xlsx"

import excel "$excel_cdi_popdens", sheet(Population density)

*reshape wide C, i(A)j(B)
drop if regexm(A, "DISTRICT")
drop if regexm(A, "DEPARTEMENT")



rename A nom_circ_souspref
rename B superficie_km2
rename C population
rename D densitie_km_carre

*split nom_circonscription, pars ("REGION DU")
*rename nom_circonscription2 region

*split nom_circonscription1, pars("DEPARTEMENT") 

*split nom_circonscription1, pars("DISTRICT")

*rename nom_circonscription1
*rename nom_circonscription11  nom_dept_souspref


drop if nom_circ_souspref == "NOM CIRCONSCRIPTION"
drop if superficie_km2 == "SUPERFICIE KM2"
drop if population == "POPULATION"
drop if densitie_km_carre == "DENSITE AU KM²"

replace nom_circonscription = strlower(nom_circonscription)


drop superficie_km2
drop densitie_km_carre

tempfile cdi_popdens
save `cdi_popdens', replace emptyok



use "$wd\\week_05\03_assignment\01_data\q2_CIV_Section_0.dta", clear
rename b07_souspref nom_circ_souspref
rename b05_region region

*merge 1:1 nom_circ_souspref using `cdi_popdens'



******************************************************************************
*Q3: Enumberator Assignment based on GPS 
******************************************************************************

cd "C:\Users\jacob\OneDrive\Desktop\PPOL_6818\week_05\03_assignment\01_data\q3_GPS Data.dta", clear


* Sort households by their GPS coordinates (latitude, longitude)
sort latitude longitude


* Create an enumerator ID variable
gen enumerator_id = .


* Loop through households and assign enumerators in groups of 6
local enumerator 1 //start with first enumerator
local max_per_enumerator 6 // each has a max of 6 houses
local amt 0 // amt of houses assigned to enumerator

* Assign enumerator ID to each household
gen i= _n

forvalues i=1/111 {
	 replace enumerator_id = `enumerator' in `i' 
	 local counter = `counter' + 1
	 if `counter'== `max_per_enumerator' {
	 	local enumerator = `enumerator' + 1
		local counter = 0 
	 }	
}
    * Assign current enumerator
   

drop i 


******************************************************************************
*Q4: 2010 Tanzania Election Data cleaning 
******************************************************************************
clear
global wd "\Users\jacob\OneDrive\Desktop\PPOL_6818\week_05\03_assignment\01_data\"

global excel_2010_tza_election"$wd\\q4_Tz_election_2010_raw.xls"

tempfile 2010_tza_election
save `2010_tza_election', replace emptyok

import excel "$excel_2010_tza_election", sheet(Sheet1)

*get rid of unnecessary space
drop if E==""
drop if E=="CANDIDATE NAME"
drop K

*rename variables
rename A region 
rename B district
rename C constituency 
rename D ward 
rename E candidate_name 
rename F male 
rename G female
rename H political_party
rename I ttl_votes
rename J elected_candidate 

*populate missing information to empty celss
foreach var in region district constituency ward {
    replace `var' = `var'[_n-1] if `var' == ""
}

*gen ward_id = _n  

egen ward_id = group(region district ward)

encode ward, gen(ward_name)
destring ttl_votes, replace 
replace ttl_votes = trim(ttl_votes)
replace ttl_votes = "" if ttl_votes == "UN OPPOSSED"


replace ward = trim(ward)


*keep region district constituency ward ttl_votes elected_candidate  ward_id
*duplicates drop
*tempfile extras
*save `others'

*reshape wide ttl_votes, i(ward_id) j(political_party)string
*merge 1:1 id using `others'




******************************************************************************
*Q5: Tanzania PSLE data 
******************************************************************************
clear
global wd "\Users\jacob\OneDrive\Desktop\PPOL_6818\week_05\03_assignment\01_data\"


**Loading the school location dataset in Stata
 use "$wd\q5_school_location", clear
 
*Preparing location info to merge
 keep School Ward Region SN
 rename School school 
* rename SN serial
 rename Ward ward 
 encode SN, gen(serial)
 rename Region region
 tempfile tza_school_lo
 order ward, a(SN)
 save `tza_school_lo', replace 


*Loading PSLE dataset
use "$wd\q5_psle_2020_data.dta", clear
*renaming schoolname var so that it matches in both datasets
  rename schoolname school 
  rename region_name region
*order school, a(serial)
  
merge 1:1 serial  using `tza_school_lo'
order ward, a(district_name)
drop if _merge ==2






