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

## D. Phase 24 post-hoc training-horizon sensitivity — rerun pending

The original Phase 24 training script is not available. The version in
`scripts/reconstructed_phase24_training_horizon.R` is explicitly reconstructed
from the corrected Phase 19 script. It excludes historical training records whose
target starts more than 14 days after that *training record's origin*, while
retaining identical 20 final evaluation origins and 15 industries.

From the GitHub repository root, run:

```r
source("scripts/reconstructed_phase24_training_horizon.R")
source("scripts/validate_reconstructed_phase24.R")
```

If the two scripts have instead been individually downloaded into your local
`AI PREDICTION` folder, use:

```r
setwd("C:/Users/peter/Downloads/AI PREDICTION")
source("reconstructed_phase24_training_horizon.R")
source("validate_reconstructed_phase24.R")
```

The reconstruction checks both corrected data paths:
`data/processed/btos_sector_panel_corrected_release_dates.csv`, and
`Phase19_Methodology_Audit/btos_sector_panel_corrected_release_dates.csv`.
It never falls back to uncorrected BTOS data.

The validator reads the archived prediction evidence from `results/verified_phase19/`,
or downloads those two CSVs from this public GitHub repository if absent locally.
It compares evaluation keys, targets, and every prediction (tolerance 1e-5 pp),
as well as the RF and ridge sensitivity gains.

Expected *archived* values: restricted RF MAE approximately **1.154348 pp**,
ridge **1.785210 pp**, persistence **1.277333 pp**. Incremental RF advantage
of restriction over corrected primary run: **0.010166569 pp**, with exploratory
origin-bootstrap interval **[−0.009048, +0.029418]** reported in the existing
archive. The validator **does not independently rerun the bootstrap**.

Outputs will be in `Phase24_Horizon_Sensitivity_Reconstructed/` and
`reproducibility_checks/`. The script creates **no figures or manuscripts**.

Do not call Phase 24 reproduced until the validator prints `PASS` and
the corresponding outputs have been inspected.
