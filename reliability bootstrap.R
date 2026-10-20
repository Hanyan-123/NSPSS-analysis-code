# =====================================================================
# NSPSS - Internal consistency with bootstrap 95% confidence intervals
# Full analytical sample, N = 537
# Cronbach's alpha (psych::alpha) and omega total (psych::omega, nfactors = 1,
# minimum residual, Pearson correlations)
# 1000 bootstrap resamples, percentile method
# R 4.6.0; psych 2.6.5
# =====================================================================

library(psych)
library(haven)

# Participant-level data cannot be shared (see Availability of data and materials)
d <- zap_labels(read_sav(file.choose()))

scales <- list(
  "NSPSS total" = c("Q15_1", "Q15_2", "Q16_1", "Q16_2", "Q17_1", "Q17_2",
                    "Q18_1", "Q18_2", "Q19_1", "Q19_2"),
  "Academic"    = c("Q15_1", "Q16_1", "Q17_1", "Q18_1", "Q19_1"),
  "Clinical"    = c("Q15_2", "Q16_2", "Q17_2", "Q18_2", "Q19_2"),
  # PSS-10: items 4, 5, 7 and 8 reverse scored (suffix R)
  "PSS-10"      = c("Q14_1", "Q14_2", "Q14_3", "Q14_4R", "Q14_5R",
                    "Q14_6", "Q14_7R", "Q14_8R", "Q14_9", "Q14_10")
)

omega_tot <- function(x) suppressWarnings(suppressMessages(
  omega(x, nfactors = 1, plot = FALSE)))$omega.tot
alpha_raw <- function(x) suppressWarnings(suppressMessages(
  psych::alpha(x)))$total$raw_alpha

set.seed(20260923)
for (sc in names(scales)) {
  x <- as.data.frame(d[, scales[[sc]]])
  a <- alpha_raw(x); o <- omega_tot(x)
  boot <- replicate(1000, {
    i <- sample(nrow(x), replace = TRUE)
    c(alpha_raw(x[i, ]), omega_tot(x[i, ]))
  })
  ci <- apply(boot, 1, quantile, c(.025, .975), na.rm = TRUE)
  cat(sprintf("%-12s alpha = %.3f [%.3f, %.3f]   omega total = %.3f [%.3f, %.3f]\n",
              sc, a, ci[1, 1], ci[2, 1], o, ci[1, 2], ci[2, 2]))
}
