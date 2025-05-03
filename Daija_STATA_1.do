//Experimental Design PS1// FOR SUBMISSION///
//DAIJA YISRAEL 
//Feb 14,2025

cd "C:\Users\jacob\OneDrive\Desktop\PPOL_6818\week_03\04_assignment\01_data\"


********************************************************************************
//Q1


use "q1_data/student.dta", clear


rename primary teacher

merge m:1 teacher using "q1_data/teacher.dta"
rename _merge mergestudentteacher

merge m:1 school using "q1_data/school.dta" 
rename _merge mergestdntteachschool 
** we want to reduce our master to only tested for b* If school == high and school == tested
 
merge m:1 subject using "q1_data/subject.dta"

  


*Q1a) 
 sum attendance if loc == "South" // 177.46
 
*Q1b) 
count if level=="High" & tested==1
count if level == "High"
display 610/1379

*Q1c: What is the mean gpa of all students in the district? --> student level analsyis
sum subject_gpa

*Qd: What is the mean attendnace of each middle school? --> school level analysis 
bysort school : egen level_mean = mean(attendance)


********************************************************************************
//Q2 

use "q2_village_pixel.dta", clear 

*a) 

bysort pixel : tab payout

bysort pixel: egen payout_max = max(payout)

bysort pixel: egen payout_min = min(payout)

gen pixel_consistent = 1 if payout_max == payout_min 
replace pixel_consistent = 0 if pixel_consistent == .

*b) 


bysort village: tab hhid


encode pixel, gen(pixel_num)

bysort village: egen min_vill_pixel_num= min(pixel_num)
bysort village: egen max_vill_pixel_num= max(pixel_num)

gen pixel_village = 0 if min_vill_pixel_num == max_vill_pixel_num
replace pixel_village = 1 if min_vill_pixel_num != max_vill_pixel_num

sort village pixel_village

*c) 



 gen diff_vill_same_pay = hhid if pixel_village == 0 & pixel_consistent == 1
 
bysort village: egen min_vill_payout= min(payout)
bysort village: egen max_vill_payout= max(payout)

gen vill_consistent =1 if min_vill_payout==max_vill_payout
replace vill_consistent=0 if vill_consistent==.
 
gen vill_pay_pixel_status = 1 if pixel_village == 0
replace vill_pay_pixel_status = 2 if pixel_village == 1 & vill_consistent == 1
replace vill_pay_pixel_status = 3 if pixel_village == 1 & vill_consistent == 0 
 

 
********************************************************************************
//Q3 
use "q3_proposal_review.dta", clear 
**Rename reviewers and scores to something consistent and better 
rename Rewiewer1 Reviewer1

rename Review1Score score1

rename Reviewer2Score score2

rename Reviewer3Score score3

reshape long Reviewer score, i(proposal_id)
sort Reviewer
bysort Reviewer: egen ReviewerMean = mean(score)
bysort Reviewer: egen ReviewerSD = sd(score)
gen ReviewerNormScore = (score - ReviewerMean)/ReviewerSD

reshape wide Reviewer score ReviewerMean  ReviewerSD ReviewerNormScore, i(proposal_id) j(_j)

rename ReviewerNormScore1 stand_r1
rename ReviewerNormScore2 stand_r2
rename ReviewerNormScore3 stand_r3



gen average_stand_score = (stand_r1 + stand_r2 + stand_r3)/3
gsort -average_stand_score

gen rank = _n
sort proposal_id
order rank, a(proposal_id)


********************************************************************************
//Q4 
global wd "C:\Users\jacob\OneDrive\Desktop\PPOL_6818"

*update the wd global so that it refers to the Box folder filepath on your machine

global excel_t21 "$wd//week_03/04_assignment/01_data/q4_Pakistan_district_table21.xlsx"

global q1_school "$wd\week_03\04_assignment\01_data\q1_data\school.dta"


clear

*setting up an empty tempfile
tempfile table21
save `table21', replace emptyok


*Run a loop through all the excel sheets (135) this will take 1-5 mins because it has to import all 135 sheets, one by one
forvalues i=1/135 {
	import excel "$excel_t21", sheet("Table 1") firstrow clear allstring //import
	display as error `i' //display the loop number
	drop B D F H J L N P R T V X Z
	
	
	keep if regexm(TABLE21PAKISTANICITIZEN1, "18 AND" )==1 //keep only those rows that have "18 AND"
	
	*I'm using regex because the following code won't work if there are any trailing/leading blanks
	*keep if TABLE21PAKISTANICITIZEN1== "18 AND" 
	

	
	keep in 1 //there are 3 of them, but we want the first one

	rename TABLE21PAKISTANICITIZEN1 table21

	
	
	
	gen table=`i' //to keep track of the sheet we imported the data from
	
	append using `table21' 
	

	save `table21', replace //saving the tempfile so that we don't lose any data
}
use `table21', clear

rename table21 age_group
rename C mf_totalpop
rename E mf_CNI_card_yes
rename G mf_CNI_card_no
rename I m_totalpop
rename K m_CNI_card_yes
rename M m_CNI_card_no
rename O f_totalpop
rename Q f_CNI_card_yes
rename S f_CNI_card_no
rename U trans_totalpop
rename W trans_CNI_card_yes
rename Y trans_CNI_card_no
gsort table


	
********************************************************************************
//Q5 

use "q5_Tz_student_roster_html.dta", clear

*see what's going on* 
summarize
codebook s 

**copy info from cell one, 

display s[1]

gen position = strpos(s,"MADARAJA YA UFAULU WA UJUMLA")


gen new_string = substr(s,1, 730)

display new_string 


split new_string, pars("<br>") 

display new_string1[1]

display new_string2[1]


split new_string1, pars(":")

gen newvar1 = subinstr(subinstr(new_string12,"`=char(10)'"," ",.),"`=char(13)'"," ",.)
drop new_string11 new_string12


split new_string2, pars(":")
gen newvar2 = subinstr(subinstr(new_string22,"`=char(10)'"," ",.),"`=char(13)'"," ",.)
drop new_string21 new_string22

split new_string3, pars(":")
gen newvar3 = subinstr(subinstr(new_string32,"`=char(10)'"," ",.),"`=char(13)'"," ",.)
drop new_string31 new_string32


split new_string4, pars(":")
gen newvar4 = subinstr(subinstr(new_string42,"`=char(10)'"," ",.),"`=char(13)'"," ",.)
drop new_string41 new_string42

split new_string5, pars(":")
gen newvar5 = subinstr(subinstr(new_string52,"`=char(10)'"," ",.),"`=char(13)'"," ",.)
drop new_string51 new_string52

split new_string6, pars(":")
gen newvar6 = subinstr(subinstr(new_string62,"`=char(10)'"," ",.),"`=char(13)'"," ",.)
drop new_string61 new_string62


// sucessfully got the number of interest to display in the cell//

rename newvar1 column1
rename newvar2 column2
rename newvar3 column3
rename newvar4 column4 
rename newvar5 column5 
rename newvar6 column6 

order column2, after(column1)
order column3, after(column2)
order column4, after(column3)
order column5, after(column4)
order column6, after(column5)

keep column1 column2 column3 column4 column5 column6

rename column1 Number_of_Students_Taking_Test
rename column2 School_Avg
rename column3 Student_Group
rename column4 School_Ranking
rename column5 School_Ranking_Regional
rename column6 School_Ranking_National




 