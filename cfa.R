# =====================================================================
# NSPSS - Confirmatory factor analysis: four model specifications
# and scaled chi-square difference test
# CFA subsample (subsample = 2), n = 260
# R 4.6.0; lavaan 0.6.21
# =====================================================================

library(lavaan)
library(haven)

# Participant-level data cannot be shared (see Availability of data and materials)
d <- zap_labels(read_sav(file.choose()))

items <- c("Q15_1", "Q16_1", "Q17_1", "Q18_1", "Q19_1",
           "Q15_2", "Q16_2", "Q17_2", "Q18_2", "Q19_2")
cfa_data <- as.data.frame(subset(d, subsample == 2)[, items])

# ---- Model specifications ----
one  <- "F =~ Q15_1 + Q16_1 + Q17_1 + Q18_1 + Q19_1 + Q15_2 + Q16_2 + Q17_2 + Q18_2 + Q19_2"
acad <- "Academic =~ Q15_1 + Q16_1 + Q17_1 + Q18_1 + Q19_1"
clin <- "Clinical =~ Q15_2 + Q16_2 + Q17_2 + Q18_2 + Q19_2"
cu   <- "
  Q15_1 ~~ Q15_2
  Q16_1 ~~ Q16_2
  Q17_1 ~~ Q17_2
  Q18_1 ~~ Q18_2
  Q19_1 ~~ Q19_2"

m1 <- one                                # Model 1: one factor
m2 <- paste(one, cu)                     # Model 2: one factor + residual covariances
m3 <- paste(acad, clin, sep = "\n")      # Model 3: two correlated factors
m4 <- paste(acad, clin, cu, sep = "\n")  # Model 4: two correlated factors + residual covariances

# ---- Estimation: robust maximum likelihood (MLR) ----
fit1 <- cfa(m1, data = cfa_data, estimator = "MLR")
fit2 <- cfa(m2, data = cfa_data, estimator = "MLR")
fit3 <- cfa(m3, data = cfa_data, estimator = "MLR")
fit4 <- cfa(m4, data = cfa_data, estimator = "MLR")

# ---- Scaled chi-square difference test, Model 3 vs Model 4 ----
lavTestLRT(fit3, fit4, method = "satorra.bentler.2001")
