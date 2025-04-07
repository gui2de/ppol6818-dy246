{\rtf1\ansi\ansicpg1252\cocoartf2580
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\froman\fcharset0 Times-Bold;\f1\froman\fcharset0 Times-Roman;}
{\colortbl;\red255\green255\blue255;\red0\green0\blue0;}
{\*\expandedcolortbl;;\cssrgb\c0\c0\c0;}
{\*\listtable{\list\listtemplateid1\listhybrid{\listlevel\levelnfc23\levelnfcn23\leveljc0\leveljcn0\levelfollow0\levelstartat1\levelspace360\levelindent0{\*\levelmarker \{disc\}}{\leveltext\leveltemplateid1\'01\uc0\u8226 ;}{\levelnumbers;}\fi-360\li720\lin720 }{\listname ;}\listid1}
{\list\listtemplateid2\listhybrid{\listlevel\levelnfc23\levelnfcn23\leveljc0\leveljcn0\levelfollow0\levelstartat1\levelspace360\levelindent0{\*\levelmarker \{disc\}}{\leveltext\leveltemplateid101\'01\uc0\u8226 ;}{\levelnumbers;}\fi-360\li720\lin720 }{\listname ;}\listid2}
{\list\listtemplateid3\listhybrid{\listlevel\levelnfc0\levelnfcn0\leveljc0\leveljcn0\levelfollow0\levelstartat1\levelspace360\levelindent0{\*\levelmarker \{decimal\}.}{\leveltext\leveltemplateid201\'02\'00.;}{\levelnumbers\'01;}\fi-360\li720\lin720 }{\listname ;}\listid3}}
{\*\listoverridetable{\listoverride\listid1\listoverridecount0\ls1}{\listoverride\listid2\listoverridecount0\ls2}{\listoverride\listid3\listoverridecount0\ls3}}
\margl1440\margr1440\vieww18420\viewh15160\viewkind0
\deftab720
\pard\pardeftab720\sa321\partightenfactor0

\f0\b\fs48 \cf2 \expnd0\expndtw0\kerning0
#STATA_4\
##Part 3: De-biasing a parameter estimate results. \
\pard\pardeftab720\sa240\partightenfactor0

\f1\b0\fs24 \cf2 The simulation study explores how sample size affects the estimation of treatment effects in a stratified setting with various covariates. The graphs provide visual representations of two key aspects of the analysis:  \
\pard\pardeftab720\sa298\partightenfactor0

\f0\b\fs36 \cf2 ##3Standard Error by Sample Size. \
\pard\pardeftab720\sa240\partightenfactor0

\f1\b0\fs24 \cf2 The first graph shows how the standard error of the treatment effect estimate changes with increasing sample size. As expected, we observe a clear pattern of decreasing standard errors as the sample size increases following an approximate inverse square root relationship. This demonstrates the fundamental statistical principle that precision improves with larger samples.  \
  \
![boxpt1](STATA_4_results/Part3_table.png)\\\
\
Key observations:  \
\pard\tx220\tx720\pardeftab720\li720\fi-720\partightenfactor0
\ls1\ilvl0\cf2 \kerning1\expnd0\expndtw0 {\listtext	\uc0\u8226 	}\expnd0\expndtw0\kerning0
The standard error decreases sharply between the smallest sample sizes (100-500). \
\ls1\ilvl0\kerning1\expnd0\expndtw0 {\listtext	\uc0\u8226 	}\expnd0\expndtw0\kerning0
The rate of improvement slows at larger sample sizes (1000+)  \
\ls1\ilvl0\kerning1\expnd0\expndtw0 {\listtext	\uc0\u8226 	}\expnd0\expndtw0\kerning0
This diminishing returns pattern suggests that beyond a certain sample size, additional observations provide less substantial gains in precision. \
\pard\tx720\pardeftab720\partightenfactor0
\cf2   \
\pard\pardeftab720\sa298\partightenfactor0

\f0\b\fs36 \cf2 ###Treatment Effect Estimates by Sample Size. \
\pard\pardeftab720\sa240\partightenfactor0

\f1\b0\fs24 \cf2 The second graph shows the point estimates of the treatment effect across different sample sizes, along with their 95% confidence intervals, compared against the true effect (0.5) used in the data generating process.  \
\
![boxpt1](STATA_4_results/Part3_graph2.png)\\\
Key observations:  \
\pard\tx220\tx720\pardeftab720\li720\fi-720\partightenfactor0
\ls2\ilvl0\cf2 \kerning1\expnd0\expndtw0 {\listtext	\uc0\u8226 	}\expnd0\expndtw0\kerning0
At small sample sizes, the confidence intervals are wider, reflecting greater uncertainty. \
\ls2\ilvl0\kerning1\expnd0\expndtw0 {\listtext	\uc0\u8226 	}\expnd0\expndtw0\kerning0
As sample size increases, confidence intervals narrow consistently. \
\ls2\ilvl0\kerning1\expnd0\expndtw0 {\listtext	\uc0\u8226 	}\expnd0\expndtw0\kerning0
Point estimates converge toward the true effect as sample size increases. \
\ls2\ilvl0\kerning1\expnd0\expndtw0 {\listtext	\uc0\u8226 	}\expnd0\expndtw0\kerning0
At the largest sample sizes, we see very narrow confidence intervals centered near the true effect. \
\pard\tx720\pardeftab720\partightenfactor0
\cf2 \
\pard\pardeftab720\sa298\partightenfactor0

\f0\b\fs36 \cf2 ###Regression Model Comparisons. \
\pard\pardeftab720\sa240\partightenfactor0

\f1\b0\fs24 \cf2 ![boxpt1](STATA_4_results//Part3_table.pgn)\\ \
The regression results table provides insights into how different model specifications affect the treatment effect estimates:  \
\pard\tx220\tx720\pardeftab720\li720\fi-720\partightenfactor0
\ls3\ilvl0\cf2 \kerning1\expnd0\expndtw0 {\listtext	1.	}\expnd0\expndtw0\kerning0
The naive model (without controls) likely shows biased estimates due to confounding. \
\ls3\ilvl0\kerning1\expnd0\expndtw0 {\listtext	2.	}\expnd0\expndtw0\kerning0
Adding the confounder (x1) substantially improves estimate accuracy. \
\ls3\ilvl0\kerning1\expnd0\expndtw0 {\listtext	3.	}\expnd0\expndtw0\kerning0
Including the outcome-relevant covariate (x2) further increases precision. \
\ls3\ilvl0\kerning1\expnd0\expndtw0 {\listtext	4.	}\expnd0\expndtw0\kerning0
Adding strata fixed effects accounts for the stratified design, reducing bias. \
\ls3\ilvl0\kerning1\expnd0\expndtw0 {\listtext	5.	}\expnd0\expndtw0\kerning0
The full model with all variables demonstrates that including irrelevant covariates (x3, x4) doesn't harm estimation but may not provide additional benefits. \
\pard\tx720\pardeftab720\partightenfactor0
\cf2 \
\pard\pardeftab720\sa240\partightenfactor0
\cf2 The results highlight the importance of controlling for confounders and outcome-relevant covariates in obtaining accurate treatment effect estimates. They also illustrate the benefits of stratification in experimental design, as accounting for strata in the analysis improves precision.  \
This simulation demonstrates that while larger sample sizes generally lead to more precise estimates, appropriate model specification can be equally important for obtaining accurate results.   The optimal research design would balance sample size considerations with careful selection of covariates based on their relationship to treatment assignment and outcomes.  \
}