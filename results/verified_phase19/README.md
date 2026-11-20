# Archived forecasting prediction evidence

These files were supplied by the author on 2026-11-20 and independently checked for row counts, keys, and summary metrics before being committed.

| File | Experiment | Matched rows | Random forest MAE (pp) | Persistence MAE (pp) | Ridge MAE (pp) |
|---|---|---:|---:|---:|---:|
| `phase19_corrected_primary_predictions.csv` | Corrected **primary** historical evaluation | 900 | 1.164515 | 1.277333 | 1.794405 |
| `phase24_restricted_horizon_predictions.csv` | Post-hoc **restricted-training-horizon** sensitivity | 900 | 1.154348 | 1.277333 | 1.785210 |

The 900 rows represent 300 matched industry-origin target observations evaluated under three models (20 origins, 15 industries). All evaluation lead times are 11 days.

The experiments share the same outcome targets and persistence predictions but differ in the random-forest and ridge predictions (300 of each changed). The restricted-horizon results must **not** replace the corrected primary results or be reported as an independently selected prospective forecast improvement.

`phase19_corrected_accuracy_audit.csv` compares the corrected primary predictions with archived Table 5. All absolute MAE/RMSE/bias differences are on the order of 1e-15.

**Provenance:** The author's uploaded filenames were `phase16_rolling_predictions (1).csv` for the corrected primary evaluation and `phase16_rolling_predictions(1).csv` for the restricted-horizon sensitivity. They were renamed on GitHub to avoid ambiguity; their numerical entries were retained.

**Scope:** This audit verifies the submitted historical prediction files and their calculated metrics. The Phase 24 sensitivity script has not been independently rerun in this repository. Original-release BTOS data vintages and live prospective forecasting accuracy have not been independently verified.

No manuscripts or figures are included.
