{\rtf1\ansi\ansicpg1252\cocoartf2580
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;\f1\fnil\fcharset0 HelveticaNeue;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\margl1440\margr1440\vieww28600\viewh15240\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0

\f0\fs24 \cf0 \
\pard\pardeftab560\slleading20\partightenfactor0

\f1\fs26 \cf0 #STATA_4\
##Part3: De-biasing a parameter estimate results\
\
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0

\f0\fs24 \cf0 The simulation study explore how sample size affects the estimate of treatment effects in a stratified setting with various covariates. The graphs provide visual representations of two key aspects of the analysis: 
\f1\fs26 \
\pard\pardeftab560\slleading20\partightenfactor0
\cf0 \
The first graph shows how the standard error of the treatment effect estimate changes with increasing sample size. As expected, we observe a clear patter of decreasing standard errors as the sample size increases following an approximate inverse square root relationship. This demonstrates the fundamental statistical principle that precision improve with larger samples. \
\pard\pardeftab560\slleading20\pardirnatural\partightenfactor0
\cf0 \
\pard\pardeftab560\slleading20\partightenfactor0
\cf0 * The standard error decreases sharply between the smallest samples sizes, 100 -500. \
* The rate of improvement slows at larger sample sizes (1000+) \
* This diminishing returns patten suggests that beyond a certain sample size, additional observations provide less substantial gains in precision.\
\pard\pardeftab560\slleading20\pardirnatural\partightenfactor0
\cf0 \
\pard\pardeftab560\slleading20\partightenfactor0
\cf0 The second graph shows the point estimates of the treatment effect across different sample sizes, along with their 95% confidence intervals, compared against the (0.5) used in the DGP. \
\pard\pardeftab560\slleading20\pardirnatural\partightenfactor0
\cf0 \
\pard\pardeftab560\slleading20\partightenfactor0
\cf0 * At small sample sizes, the confidence intervals are wider, reflecting greater uncertainty. \
* As sample size increases, confidence intervals narrow consistency.  \
* Point estimates converge toward the true effect as sample size increases. \
* At the largest sample sizes, we see very narrow confidence intervals centered near the true effect.\
\
##Regression results table - insights into how different model specifications affect the treatment effect estimates.  \
}