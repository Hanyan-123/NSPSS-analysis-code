# NSPSS-analysis-code

SPSS and R syntax for the paper "Measuring Positive Stress Appraisal Among Nursing Students: Development and Initial Psychometric Evaluation of the Nursing Student Positive Stress Scale (NSPSS)".

Files:

- random split.sps: splits the 537 cases into the EFA (n = 277) and CFA (n = 260) subsamples. SPSS 31.0.2.0.
- efa factor retention.R: parallel analysis and MAP test, EFA subsample. R 4.6.0, psych 2.6.5, GPArotation 2026.8-2.
- cfa.R: the four CFA models and the scaled chi-square difference test (Model 3 vs Model 4), CFA subsample. R 4.6.0, lavaan 0.6.21.
- reliability bootstrap.R: alpha and omega with bootstrap confidence intervals, full sample. R 4.6.0, psych 2.6.5.

The data are not included. Under the conditions of our ethics approval, participant-level data cannot be shared.

Variable names:
Q15_1 to Q19_1 are the NSPSS academic items and Q15_2 to Q19_2 the clinical items.
Q14_1 to Q14_10 are the PSS-10 items; Q14_4R, Q14_5R, Q14_7R and Q14_8R are the reverse-scored items.
subsample is 1 for the EFA subsample and 2 for the CFA subsample.
