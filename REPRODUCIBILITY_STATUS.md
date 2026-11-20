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

## Uploaded Phase 15 local-run outputs — 2026-11-20

The author supplied four files produced by the reconstructed R scripts. They have
been deposited under `results/verified_phase15/`:
`phase15_reconstructed_sample.csv` (1110 rows, 53 columns),
`phase15_reconstructed_coefficients.csv`,
`phase15_reconstructed_cumulative.csv`, and
`phase15_reconstructed_regressions.txt`.

Independent checks of the supplied files confirmed 15 industries, 74 model
periods, unique sector-period keys, and no missing model lag fields.
The four reported coefficients match the archived estimates; cumulative
coefficient **0.1286766** and clustered SE **0.02806728** also match.

**CI interpretation:** The uploaded `phase15_reconstructed_cumulative.csv`
contains a 1.96×SE *normal approximation* interval, rather than a
finite-cluster t-based interval. Use the interval convention specified in
the manuscript; do not conflate these two intervals.

The scripts have been rerun by the author and the generated outputs inspected,
but an independent execution from original Census source files has not
been completed. Manuscripts and figures are deliberately not included.


## One-lag reconstruction — added 2026-11-20

The reconstructed `scripts/reconstructed_phase15_one_lag_models.R` was added
to rebuild the 1,170-observation one-lag sample on the uncompressed 83-period
calendar and estimate separate industry FE and industry + period FE specifications.

Target archived coefficient values:
- Industry FE: delay lag **0.5232891711**; price lag **0.0560284569**.
- Industry + period FE: delay lag **0.4117829330**; price lag **0.0881916928**.

The script validates the expected 1,170 records and writes a coefficient/SE
comparison CSV. **Execution by the author and verification of those new outputs
are pending**. No claim of successful one-lag reproduction is made yet.


## Author-reported one-lag RStudio verification — 2026-11-20

The author ran `source("reconstructed_phase15_one_lag_models.R")`
successfully and supplied the console output. The script generated a
**1,170-record, 15-industry, 78-period** sample. Both industry FE and industry +
period FE specifications exactly recovered the archived point estimates and
two-way clustered standard errors to numerical precision:

| Specification | Variable | Coefficient | SE |
|---|---|---:|---:|
| Industry FE | delay_lag | 0.52328917 | 0.05650001 |
| Industry FE | prices_lag | 0.05602846 | 0.02060616 |
| Industry + Period FE | delay_lag | 0.41178293 | 0.08538190 |
| Industry + Period FE | prices_lag | 0.08819169 | 0.02328116 |

Author-provided estimate and SE differences were approximately 10^-16.
The generated `phase15_one_lag_archive_comparison.csv` and other new files
have **not yet been uploaded or independently inspected** here.
This demonstrates a successful author-reported local model reconstruction,
not a full end-to-end replication from the original Census data downloads.


## One-lag output files received and archived — 2026-11-20

The author supplied and the repository now contains:

- `results/verified_phase15/phase15_one_lag_sample.csv` (1,170 records, 51 columns).
- `results/verified_phase15/phase15_one_lag_coefficients.csv` (four coefficient rows).
- `results/verified_phase15/phase15_one_lag_archive_comparison.csv` (four comparison rows).
- `results/verified_phase15/phase15_one_lag_regressions.txt` (formatted R `fixest` estimates).

Independent file inspections confirmed **15 industries, 78 distinct periods, no
duplicate industry-period keys, and no missing outcome or model lag variables**
in the reconstructed sample. All four archived coefficient and standard-error
comparisons differ from the newly generated values by less than 4e-16.

Some source columns carry missing values by design; the complete 51-column
panel was **not** asserted to have no missing data.

The one-lag output files are now inspected and archived, superseding the
earlier note that their upload was pending. Manuscripts and figures remain
excluded. Independent original-source end-to-end reproduction is not established.

## Phase 27 final pipeline audit — 2026-11-20

**Current status superseding earlier interim “not yet verified” notes:**
The reconstructed Phase 15 1,110-observation distributed-lag and 1,170-observation
one-lag models were **run locally by the author** and their four result files
for each specification were examined and committed. Their archived coefficient
and standard-error values matched to numerical precision.

The initial Phase 16 paired-validation script reads the **uncorrected**
`Phase16_R_Results/` location; it must not be used to verify the corrected
primary run. A dedicated `scripts/validate_corrected_phase19_forecast.R`
was added with strict three-model pairing, forecast-origin/target checks, and
comparison against `results/tables/table5_corrected_accuracy.csv`.
It has **not yet been executed or verified** in RStudio.

Instructions: [RUN_INSTRUCTIONS.md](RUN_INSTRUCTIONS.md).

Outstanding checks:
1. The corrected Phase 19 forecast must be rerun and its metrics compared
   to the archived Table 5 numbers.
2. Historical original-release BTOS values and all survey frame comparability
   assumptions are not independently verified.
3. No complete acquisition-to-results reproduction from original Census files.
4. The extra historical training-horizon restriction (Phase 24) has no
   independently verified rerunnable script in this GitHub release candidate.

No release/Zenodo DOI has been created and manuscripts and figures remain
outside the repository.


## Phase 19 corrected historical forecasting — author-reported RStudio rerun (2026-11-20)

The author successfully reran `phase19_corrected_forecasting.R` using
`Phase19_Methodology_Audit/btos_sector_panel_corrected_release_dates.csv`
and then executed `validate_corrected_phase19_forecast.R`.

The validator reported 20 forecast origins, 15 industries, 300 matched
predictions for each of three models, and the following metrics:

| Model | MAE (pp) | RMSE (pp) | Bias (pp) |
|---|---:|---:|---:|
| Random forest | 1.164515 | 1.522084 | -0.179438 |
| Persistence | 1.277333 | 1.629990 | -0.073333 |
| Ridge (fixed lambda=5) | 1.794405 | 2.438261 | -0.412915 |

The author's pasted validation console output confirmed absolute differences
from archived MAE/RMSE/bias ranging from approximately 1e-17 to 5e-15.
The validation script printed:

```text
PASS: corrected forecast metrics matched archived results; RF MAE 1.164515 pp, persistence MAE 1.277333 pp, gain 8.8323%.
```

**Status:** Corrected Phase 19 historical forecast *numerical metrics* are
author-rerun verified. The produced audit CSV and per-record predictions
have not yet been uploaded or independently compared here.
This does not establish historical original-release BTOS vintage fidelity,
live prospective accuracy, independent data acquisition, or unexamined
forecast generalization. The current work should not be characterized as
independently end-to-end reproduced.

This update supersedes earlier statements in this document that the Phase 19
RStudio validation is still pending. Manuscripts and figures remain excluded.


## Submitted Phase 19 and Phase 24 evidence inspected and archived — 2026-11-20

The author uploaded the primary corrected prediction CSV, the post-hoc
restricted-horizon prediction CSV, and the corrected primary accuracy audit.
These are now committed at `results/verified_phase19/`.

- **Corrected primary** (`phase19_corrected_primary_predictions.csv`):
  300 matched predictions for each model across 20 origins and 15 sectors;
  random forest MAE 1.164515, persistence 1.277333, ridge 1.794405.
- **Training-horizon sensitivity** (`phase24_restricted_horizon_predictions.csv`):
  same evaluation targets; random forest MAE 1.154348, persistence 1.277333,
  ridge 1.785210. Not a prospective model-selection result.
- **Audit** (`phase19_corrected_accuracy_audit.csv`):
  difference in archived and rerun corrected metrics on the order of 1e-15.

The two 900-row prediction files are **not interchangeable**. Their source
filenames were deceptively similar; the GitHub names explicitly distinguish
primary from sensitivity. All 900 evaluation lead times are 11 days.
See [results/verified_phase19/README.md](results/verified_phase19/README.md).

The numerical prediction files are now inspected and archived, replacing
the earlier statement that their upload remained pending. However, the Phase 24
restricted-horizon *training script* has not been independently rerun here.
A complete original-Census-acquisition and real-time data-vintage reproduction
remains outstanding. Manuscripts and figures remain excluded.
