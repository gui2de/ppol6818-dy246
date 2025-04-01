/////Experimental Design STATA 3 
//// Marh 30, 2025
/// Daija Yisrael

clear 
*=====================================
*PART 1: SAMPLING NOISE IN A FIXED POP
*=====================================
*Q2
*tempfile gui2dePS3
*save `gui2dePS3', emptyok 
set seed 1 
set obs 10000

gen person_id = _n 

gen studytime = rnormal(8,3)

gen error = rnormal(0,2)

gen satscore = 1000 + 20*studytime + error

save "guide2_stata_ps3.dta" 




*Q3
capture program drop sample_regression
program define sample_regression, rclass 
clear 
syntax, n(integer)

*sample `obs_num', count

use "guide2_stata_ps3.dta", clear 
sample `n', count 
regress satscore studytime 

*return scalar coef = results[1,1]
*return scalar pval = results [4,1]
	
return scalar N = e(N)
return scalar beta_studytime = _b[studytime]  // beta coefficient for studytime
return scalar sem_studytime = _se[studytime]  // standard error for studytime
return scalar pval_studytime = 2 * ttail(e(df_r), abs(_b[studytime] / _se[studytime])) 
return scalar ci_lo = _b[studytime] - invttail(e(df_r), 0.025) * _se[studytime]  // Lower 95% CI
return scalar ci_hi = _b[studytime] + invttail(e(df_r), 0.025) * _se[studytime]  // Upper 95% CI
  // number of observations in sample
 
end 



*Q4 /// getting an error: x: Error occurred when simulate executed sample_regression

simulate N= r(N) beta_studytime=r(beta_studytime) sem_studytime=r(sem_studytime) pval_studytime=r(pval_studytime) ci_lo=r(ci_lo) ci_hi=r(ci_hi) , reps(500) seed(1): sample_regression, n(10)

save "gui2dePS3_sim1.dta"



simulate N= r(N) beta_studytime=r(beta_studytime) sem_studytime=r(sem_studytime) pval_studytime=r(pval_studytime) ci_lo=r(ci_lo) ci_hi=r(ci_hi) , reps(500) seed(2): sample_regression, n(100)
save "gui2dePS3_sim2.dta"


simulate N= r(N) beta_studytime=r(beta_studytime) sem_studytime=r(sem_studytime) pval_studytime=r(pval_studytime) ci_lo=r(ci_lo) ci_hi=r(ci_hi) , reps(500) seed(3): sample_regression, n(1000)
save "gui2dePS3_sim3.dta"



simulate  N= r(N) beta_studytime=r(beta_studytime) sem_studytime=r(sem_studytime) pval_studytime=r(pval_studytime) ci_lo=r(ci_lo) ci_hi=r(ci_hi), reps(500) seed(4): sample_regression, n(10000)

save "gui2dePS3_sim4.dta"


*Combine all results 

use "gui2dePS3_sim1.dta", clear 
append using "gui2dePS3_sim2.dta"
append using "gui2dePS3_sim3.dta"
append using "gui2dePS3_sim4.dta"
save "gui2dePS3_simtot.dta"

use gui2dePS3_sim1.dta 


*Q5: Create a visual and table  

//Meheria's Visuals
use "gui2dePS3_simtot.dta", clear
twoway ///
    (kdensity beta if N==10, lcolor(blue)) ///
    (kdensity beta if N==100, lcolor(purple)) ///
    (kdensity beta if N==1000, lcolor(green)) ///
    (kdensity beta if N==10000, lcolor(pink)), ///
    title("Variation in Coefficients by Sample") ///
    legend(label(1 "N = 10") label(2 "N = 100") label(3 "N = 1000") label(4 "N = 10000")) ///
    ytitle("Density") xtitle("Study Time Coefficient") ///
    xline(3, lcolor(black) lpattern(dash))

	
table N, statistic(mean beta) statistic(sd beta) ///
         statistic(mean sem) statistic(mean ci_lo) statistic(mean ci_hi)

		 
		 
graph box beta, over(N, label(angle(0))) ///
    yline(3, lpattern(dash) lcolor(pink)) ///
    title("Distribution of Beta Estimates by Sample Size") ///
    ytitle("Estimated Slope ") ///
   


*Q6: Fully describe your results in a README file, including figures and tables as appropraite (upload to github)


*===================================================
*PART 2:SAMPLING NOISE IN AN INFINITE SUPERPOPULATION 
*===================================================
clear 
set seed 1 
set obs 3000000

gen person_id = _n 

gen studytime = rnormal(8,3)

gen error = rnormal(0,2)

gen satscore = 1000 + 20*studytime + error
save "guide2_stata_ps3_pt2.dta"


capture program drop sample_regression_suppop
program define sample_regression_suppop, rclass 
clear 
syntax, n(integer)

*sample `obs_num', count

use "guide2_stata_ps3_pt2.dta", clear 
sample `n', count 
regress satscore studytime 

	
return scalar N = e(N)
return scalar beta_studytime = _b[studytime]  // beta coefficient for studytime
return scalar sem_studytime = _se[studytime]  // standard error for studytime
return scalar pval_studytime = 2 * ttail(e(df_r), abs(_b[studytime] / _se[studytime])) 
return scalar ci_lo = _b[studytime] - invttail(e(df_r), 0.025) * _se[studytime]  // Lower 95% CI
return scalar ci_hi = _b[studytime] + invttail(e(df_r), 0.025) * _se[studytime]  // Upper 95% CI
  // number of observations in sample
 
end 



simulate N= r(N) beta_studytime=r(beta_studytime) sem_studytime=r(sem_studytime) pval_studytime=r(pval_studytime) ci_lo=r(ci_lo) ci_hi=r(ci_hi) , reps(500) seed(1): sample_regression_suppop, n(10)
save "gui2dePS3_supersim1.dta"



simulate N= r(N) beta_studytime=r(beta_studytime) sem_studytime=r(sem_studytime) pval_studytime=r(pval_studytime) ci_lo=r(ci_lo) ci_hi=r(ci_hi) , reps(500) seed(2): sample_regression_suppop, n(100)
save "gui2dePS3_supersim2.dta"


simulate N= r(N) beta_studytime=r(beta_studytime) sem_studytime=r(sem_studytime) pval_studytime=r(pval_studytime) ci_lo=r(ci_lo) ci_hi=r(ci_hi) , reps(500) seed(3): sample_regression_suppop, n(1000)
save "gui2dePS3_supersim3.dta"



simulate  N= r(N) beta_studytime=r(beta_studytime) sem_studytime=r(sem_studytime) pval_studytime=r(pval_studytime) ci_lo=r(ci_lo) ci_hi=r(ci_hi), reps(500) seed(4): sample_regression_suppop, n(10000)
save "gui2dePS3_supersim4.dta"

/// to answer the power question, i need a program or loop that replaces n in each interation of the simulation with 2^(2 + _n - 1)

simulate  N= r(N) beta_studytime=r(beta_studytime) sem_studytime=r(sem_studytime) pval_studytime=r(pval_studytime) ci_lo=r(ci_lo) ci_hi=r(ci_hi), reps(500) seed(4): sample_regression_suppop, n(4)
save "gui2dePS3_supersim5.dta"

simulate  N= r(N) beta_studytime=r(beta_studytime) sem_studytime=r(sem_studytime) pval_studytime=r(pval_studytime) ci_lo=r(ci_lo) ci_hi=r(ci_hi), reps(500) seed(4): sample_regression_suppop, n(8)
save "gui2dePS3_supersim6.dta"

simulate  N= r(N) beta_studytime=r(beta_studytime) sem_studytime=r(sem_studytime) pval_studytime=r(pval_studytime) ci_lo=r(ci_lo) ci_hi=r(ci_hi), reps(500) seed(4): sample_regression_suppop, n(16)
save "gui2dePS3_supersim7.dta"

simulate  N= r(N) beta_studytime=r(beta_studytime) sem_studytime=r(sem_studytime) pval_studytime=r(pval_studytime) ci_lo=r(ci_lo) ci_hi=r(ci_hi), reps(500) seed(4): sample_regression_suppop, n(32)
save "gui2dePS3_supersim8.dta"

simulate  N= r(N) beta_studytime=r(beta_studytime) sem_studytime=r(sem_studytime) pval_studytime=r(pval_studytime) ci_lo=r(ci_lo) ci_hi=r(ci_hi), reps(500) seed(4): sample_regression_suppop, n(64)
save "gui2dePS3_supersim9.dta"

simulate  N= r(N) beta_studytime=r(beta_studytime) sem_studytime=r(sem_studytime) pval_studytime=r(pval_studytime) ci_lo=r(ci_lo) ci_hi=r(ci_hi), reps(500) seed(4): sample_regression_suppop, n(128)
save "gui2dePS3_supersim10.dta"

simulate  N= r(N) beta_studytime=r(beta_studytime) sem_studytime=r(sem_studytime) pval_studytime=r(pval_studytime) ci_lo=r(ci_lo) ci_hi=r(ci_hi), reps(500) seed(4): sample_regression_suppop, n(256)
save "gui2dePS3_supersim11.dta"

simulate  N= r(N) beta_studytime=r(beta_studytime) sem_studytime=r(sem_studytime) pval_studytime=r(pval_studytime) ci_lo=r(ci_lo) ci_hi=r(ci_hi), reps(500) seed(4):sample_regression_suppop, n(512)
save "gui2dePS3_supersim12.dta"

simulate  N= r(N) beta_studytime=r(beta_studytime) sem_studytime=r(sem_studytime) pval_studytime=r(pval_studytime) ci_lo=r(ci_lo) ci_hi=r(ci_hi), reps(500) seed(4): sample_regression_suppop, n(1024)
save "gui2dePS3_supersim13.dta"

simulate  N= r(N) beta_studytime=r(beta_studytime) sem_studytime=r(sem_studytime) pval_studytime=r(pval_studytime) ci_lo=r(ci_lo) ci_hi=r(ci_hi), reps(500) seed(4): sample_regression_suppop, n(2048)
save "gui2dePS3_supersim14.dta"

simulate  N= r(N) beta_studytime=r(beta_studytime) sem_studytime=r(sem_studytime) pval_studytime=r(pval_studytime) ci_lo=r(ci_lo) ci_hi=r(ci_hi), reps(500) seed(4): sample_regression_suppop, n(4096)
save "gui2dePS3_supersim15.dta"

simulate  N= r(N) beta_studytime=r(beta_studytime) sem_studytime=r(sem_studytime) pval_studytime=r(pval_studytime) ci_lo=r(ci_lo) ci_hi=r(ci_hi), reps(500) seed(4): sample_regression_suppop, n(8192)
save "gui2dePS3_supersim16.dta"

simulate  N= r(N) beta_studytime=r(beta_studytime) sem_studytime=r(sem_studytime) pval_studytime=r(pval_studytime) ci_lo=r(ci_lo) ci_hi=r(ci_hi), reps(500) seed(4): sample_regression_suppop, n(16384)
save "gui2dePS3_supersim17.dta"

simulate  N= r(N) beta_studytime=r(beta_studytime) sem_studytime=r(sem_studytime) pval_studytime=r(pval_studytime) ci_lo=r(ci_lo) ci_hi=r(ci_hi), reps(500) seed(4): sample_regression_suppop, n(32768)
save "gui2dePS3_supersim18.dta"

simulate  N= r(N) beta_studytime=r(beta_studytime) sem_studytime=r(sem_studytime) pval_studytime=r(pval_studytime) ci_lo=r(ci_lo) ci_hi=r(ci_hi), reps(500) seed(4): sample_regression_suppop, n(65536)
save "gui2dePS3_supersim19.dta"

simulate  N= r(N) beta_studytime=r(beta_studytime) sem_studytime=r(sem_studytime) pval_studytime=r(pval_studytime) ci_lo=r(ci_lo) ci_hi=r(ci_hi), reps(500) seed(4): sample_regression_suppop, n(131072)
save "gui2dePS3_supersim20.dta"

simulate  N= r(N) beta_studytime=r(beta_studytime) sem_studytime=r(sem_studytime) pval_studytime=r(pval_studytime) ci_lo=r(ci_lo) ci_hi=r(ci_hi), reps(500) seed(4): sample_regression_suppop, n(262144)
save "gui2dePS3_supersim21.dta"

simulate  N= r(N) beta_studytime=r(beta_studytime) sem_studytime=r(sem_studytime) pval_studytime=r(pval_studytime) ci_lo=r(ci_lo) ci_hi=r(ci_hi), reps(500) seed(4): sample_regression_suppop, n(524288)
save "gui2dePS3_supersim22.dta"

simulate  N= r(N) beta_studytime=r(beta_studytime) sem_studytime=r(sem_studytime) pval_studytime=r(pval_studytime) ci_lo=r(ci_lo) ci_hi=r(ci_hi), reps(500) seed(4): sample_regression_suppop, n(1048576)
save "gui2dePS3_supersim23.dta"

simulate  N= r(N) beta_studytime=r(beta_studytime) sem_studytime=r(sem_studytime) pval_studytime=r(pval_studytime) ci_lo=r(ci_lo) ci_hi=r(ci_hi), reps(500) seed(4): sample_regression_suppop, n(2097152)
save "gui2dePS3_supersim24.dta"

simulate  N= r(N) beta_studytime=r(beta_studytime) sem_studytime=r(sem_studytime) pval_studytime=r(pval_studytime) ci_lo=r(ci_lo) ci_hi=r(ci_hi), reps(500) seed(4): sample_regression_suppop, n(100000)
save "gui2dePS3_supersim25.dta"

simulate  N= r(N) beta_studytime=r(beta_studytime) sem_studytime=r(sem_studytime) pval_studytime=r(pval_studytime) ci_lo=r(ci_lo) ci_hi=r(ci_hi), reps(500) seed(4): sample_regression_suppop, n(1000000)
save "gui2dePS3_supersim26.dta"

*Combine all results 

use "gui2dePS3_supersim1.dta", clear 
append using "gui2dePS3_supersim2.dta"
append using "gui2dePS3_supersim3.dta"
append using "gui2dePS3_supersim4.dta" 
append using "gui2dePS3_supersim5.dta" 
append using "gui2dePS3_supersim6.dta" 
append using "gui2dePS3_supersim7.dta" 
append using "gui2dePS3_supersim8.dta" 
append using "gui2dePS3_supersim9.dta" 
append using "gui2dePS3_supersim10.dta" 
append using "gui2dePS3_supersim11.dta" 
append using "gui2dePS3_supersim12.dta" 
append using "gui2dePS3_supersim13.dta" 
append using "gui2dePS3_supersim14.dta" 
append using "gui2dePS3_supersim15.dta" 
append using "gui2dePS3_supersim16.dta" 
append using "gui2dePS3_supersim17.dta" 
append using "gui2dePS3_supersim18.dta" 
append using "gui2dePS3_supersim19.dta" 
append using "gui2dePS3_supersim20.dta" 
append using "gui2dePS3_supersim21.dta" 
append using "gui2dePS3_supersim22.dta" 
append using "gui2dePS3_supersim23.dta" 
append using "gui2dePS3_supersim24.dta" 
append using "gui2dePS3_supersim25.dta" 
append using "gui2dePS3_supersim26.dta" 

save "gui2dePS3_supersimtot.dta"

use gui2dePS3_supersimtot.dta, clear
twoway ///
    (kdensity beta if N==10, lcolor(blue)) ///
    (kdensity beta if N==100, lcolor(purple)) ///
    (kdensity beta if N==1000, lcolor(green)) ///
    (kdensity beta if N==10000, lcolor(pink)) ///
	(kdensity beta if N==100000, lcolor(red)), ///
    title("Variation in Coefficients by Sample") ///
    legend(label(1 "N = 10") label(2 "N = 100") label(3 "N = 1000") label(4 "N = 10000") label(5 "N=100000")) ///
    ytitle("Density") xtitle("Study Time Coefficient") ///
    xline(3, lcolor(black) lpattern(dash))
	
table N, statistic(mean beta) statistic(sd beta) ///
         statistic(mean sem) statistic(mean ci_lo) statistic(mean ci_hi) 

		 		 
graph box beta, over(N, label(angle(0))) ///
    yline(3, lpattern(dash) lcolor(pink)) ///
    title("Distribution of Beta Estimates by Sample Size") ///
    ytitle("Estimated Slope ") ///

