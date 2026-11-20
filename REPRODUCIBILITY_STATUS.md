# Reproducibility status

## Previously checked

- Archived tables and figures were copied with matching checksums.
- The econometric sample included 1,110 matched observations; 5,550 source-field lag/outcome comparisons matched the archived panel.
- Forecasting metrics were independently recalculated from stored predictions.
- Historical predictor timestamps were checked against **recorded** release dates.

## Not independently established

- End-to-end data acquisition and transformation from original Census downloads.
- Complete estimation-script coverage for every Phase 15 econometric specification.
- Historical *original-release* vintage equivalence for all BTOS values.
- Across-cycle equivalence of survey weighting, denominators, and business-population composition.

## Model results

Corrected main experiment: random forest MAE **1.164515**, persistence MAE **1.277333**, an **8.832345%** reduction. Restricted-training-horizon sensitivity: random forest MAE **1.154348**, or **9.628267%** below persistence. The additional MAE gain from restricting training was **0.010167 percentage points** (exploratory 95% origin-bootstrap interval **−0.009048 to 0.029418**). The restricted variant is not a selected prospective winner.

All estimates are exploratory historical analyses, not independently validated real-time forecasts.


## Reconstructed Phase 15 scripts — 2026-11-20

Two scripts were newly authored from the archived corrected dataset and earlier
Phase 15 sample and regression outputs:

- `scripts/reconstructed_phase15_prepare_sample.R`
- `scripts/reconstructed_phase15_econometrics.R`

**Verification performed outside R:** Using the corrected archived sector panel,
the reconstruction reproduced exactly the 1,110 observation keys (15 industries,
74 periods) and every archived value of `delay_l1`, `prices_l1`,
`prices_l2`, and `prices_l3`. An independent Python/OLS cross-check with
industry and period indicators recovered the archived long-lag coefficients to
their reported numerical precision.

**Not yet verified:** The uploaded reconstruction scripts have not been executed
in an R environment with `fixest`. In particular, the archived standard errors,
small-sample corrections, and complete end-to-end pipeline still require an R
rerun. The archived 1,170-observation simpler model is not included in this
reconstruction. Neither script is claimed to be the missing original.


## Author-reported RStudio rerun — 2026-11-20

The author executed the reconstructed Phase 15 preparation and econometric
scripts in RStudio from the `AI PREDICTION` working directory.

Reported console output:
```text
Reconstructed 1110 observations across 15 sectors and 74 periods.
Verified: model point estimates reproduce archived coefficients within 1e-4.
Cumulative estimate: 0.1286766  SE: 0.02806728
Note: separate 1170-record one-lag model is not reconstructed here.
Historical coefficients verified; original production script not recovered.
```

This confirms a successful **author-reported local R execution** of the
reconstructed main model, including its cumulative clustered standard error.
The generated output files have not been independently inspected or committed,
and this result is not a full end-to-end reproduction of the original analysis.
The separate 1,170-row one-lag model remains unreconstructed.
