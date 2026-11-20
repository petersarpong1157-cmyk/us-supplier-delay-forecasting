# Running the reproducibility checks

This repository intentionally contains **no manuscripts or figure images**.

## Prerequisites

Install R packages:

```r
install.packages(c("dplyr", "fixest", "glmnet", "ranger", "ggplot2"))
```

Download the repository with **Code → Download ZIP**, extract it, and run RStudio in the extracted repository root (where `data/`, `scripts/`, and `results/` are visible).

Alternatively, save `data/processed/`, `scripts/`, and `results/tables/table5_corrected_accuracy.csv` into your existing project folder while retaining their relative paths.

## A. Phase 15 econometric models — locally verified by author

```r
source("scripts/reconstructed_phase15_prepare_sample.R")
source("scripts/reconstructed_phase15_econometrics.R")
source("scripts/reconstructed_phase15_one_lag_models.R")
```

The author's RStudio rerun matched archived coefficients and clustered standard errors for both the 1,110-row distributed-lag and 1,170-row one-lag models. The reconstructed scripts are **not** the missing original scripts.

## B. Phase 19 corrected forecast — independent rerun outstanding

```r
source("scripts/phase19_corrected_forecasting.R")
source("scripts/validate_corrected_phase19_forecast.R")
```

The validation checks 20 evaluation origins, 15 industries, and 300 predictions per model. It compares MAE, RMSE, and bias to the exact archived corrected Table 5 values. The expected primary random-forest MAE is **1.164515 percentage points**, versus **1.277333** for persistence.

**Important:** Never substitute `Phase16_R_Results/phase16_rolling_predictions.csv` for the corrected `Phase19_Corrected_Forecast_Results` output. The Phase 16 validation script targets the earlier, pre-correction pipeline. A historical rerun from already assembled data does not establish original-release-vintage fidelity.

The Phase 19 forecasting script generates a diagnostic PNG image **locally**. It is not part of the GitHub repository and should not be committed, consistent with the author's request to exclude figures.

## C. Interpreting a failure

If any check stops, preserve its console output and the generated audit CSV. Do not weaken acceptance thresholds or silently select another model or data vintage to force a pass.

## Status

- Phase 15 reconstructed models: author-rerun outputs inspected and archived.
- Phase 19 corrected forecast: strict verification script is available; rerun and output verification are **pending**.
- Full raw-Census acquisition-to-results workflow and historical original-release vintages: **not independently reproduced**.
