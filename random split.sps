* =====================================================================.
* NSPSS - Random allocation of the analytical sample (N = 537)
* to non-overlapping EFA and CFA subsamples.
* IBM SPSS Statistics V31.0.2.0.
* Cases are in the order of the analytical data file.
* =====================================================================.

SET RNG=MT MTINDEX=20260923.

COMPUTE random_u = RV.UNIFORM(0,1).
IF (random_u < 0.50) subsample = 1.
IF (random_u >= 0.50) subsample = 2.
VALUE LABELS subsample 1 'EFA subsample' 2 'CFA subsample'.
EXECUTE.

* Expected: EFA subsample n = 277; CFA subsample n = 260.
FREQUENCIES VARIABLES=subsample.
