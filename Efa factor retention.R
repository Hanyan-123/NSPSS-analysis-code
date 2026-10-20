# =====================================================================
# NSPSS - Factor-retention criteria for the exploratory factor analysis
# EFA subsample (subsample = 1), n = 277
# R 4.6.0; psych 2.6.5; GPArotation 2026.8-2
# =====================================================================

library(psych)
library(GPArotation)
library(haven)

# Participant-level data cannot be shared (see Availability of data and materials)
d <- zap_labels(read_sav(file.choose()))

items <- c("Q15_1", "Q15_2", "Q16_1", "Q16_2", "Q17_1", "Q17_2",
           "Q18_1", "Q18_2", "Q19_1", "Q19_2")
efa <- as.data.frame(subset(d, subsample == 1)[, items])

# 1. Parallel analysis
#    Principal component eigenvalues; 1000 random normal datasets;
#    components retained while actual eigenvalue > random 95th percentile
set.seed(20260923)
sim <- replicate(1000, eigen(cor(matrix(rnorm(nrow(efa) * 10), nrow(efa), 10)))$values)
thr95 <- apply(sim, 1, quantile, 0.95)
ev <- eigen(cor(efa))$values
data.frame(component = 1:10, actual = round(ev, 3),
           random_mean = round(rowMeans(sim), 3), random_95th = round(thr95, 3))
which(!(ev > thr95))[1] - 1   # number of components retained

# 2. Velicer's MAP test (Pearson and polychoric correlations)
vss(efa, n = 4, fm = "pa", cor = "cor",  plot = FALSE)$map
vss(efa, n = 4, fm = "pa", cor = "poly", plot = FALSE)$map
