# Predicting Supplier Delivery-Time Disruptions Across U.S. Industries

**Author:** Peter Sarpong · Independent Researcher · Gaithersburg, Maryland, USA  
**Contact:** peter.sarpong1157@gmail.com

## Overview

This exploratory study analyzes U.S. Census Bureau Business Trends and Outlook Survey (BTOS) industry-level observations from 2023–2026. It examines historical associations between input-price pressure and reported supplier delivery-time increases, and evaluates publication-date-restricted forecasts across 15 industries.

The BTOS measures the **percentage of reporting businesses indicating an increase** in supplier delivery times or prices paid; it does not measure days delayed or the magnitude of price changes. It is not an SME-only sample.

## Principal results: corrected historical evaluation

| Model | MAE (percentage points) | RMSE (percentage points) |
|---|---:|---:|
| Random forest | 1.1645 | 1.5221 |
| Persistence | 1.2773 | 1.6300 |
| Ridge (fixed lambda = 5) | 1.7944 | 2.4383 |

Random forest improved MAE relative to persistence by **0.1128 percentage points (8.83%)** across 300 matched predictions over 20 historical forecast origins and 15 industries. The exploratory origin-bootstrap 95% interval for the absolute improvement was **0.0121–0.2044 percentage points**.

The random forest advantage was **not established** among the 35 outcomes where the realized reported supplier-delay increase rate was at least 15%. This is a retrospective, outcome-defined diagnostic, not an evaluated real-time warning system.

The distributed-lag fixed-effects analysis found a positive cumulative *association* between input-price increases and subsequent supplier-delay increases, **not a causal effect**.

## Research archive

- `data/processed/`: archived BTOS-derived CSV panel with the period 202520 release date corrected to November 20, 2025.
- `scripts/`: corrected forecasting, archived Phase 16 scripts, and newly reconstructed Phase 15 sample-preparation and fixed-effects scripts (not the original missing scripts).
- `results/tables/`: eight main exhibit-source CSVs.
- `results/audits/`: six provenance, correction and sensitivity CSVs.
- `results/verified_phase15/`: reconstructed econometric samples, model tables, and coefficient verification.
- `results/verified_phase19/`: corrected primary predictions and distinct post-hoc training-horizon sensitivity predictions, with numerical audit and provenance notes.

**Repository scope:** Research data, R scripts, exhibit-source CSV tables, and audit records only. Manuscripts and figures are intentionally excluded at the author's request. See [UPLOAD_STATUS.md](UPLOAD_STATUS.md).

## Historical corrections and sensitivity

Period 202520 was initially assigned the scheduled October 9, 2025 date; the actual release was November 20, 2025. Periods 202521–202523 have unavailable survey outcomes.

A separate sensitivity excluded extended-horizon historical *training* records. Random forest MAE was 1.1543 (compared with 1.1645 in the corrected main run); its additional gain of 0.0102 percentage points had exploratory bootstrap interval −0.0090 to 0.0294. The main corrected model remains the primary specification.

## Reproducibility and limitations

- Original-release historical data vintages have not been independently verified for every observation.
- The 15-industry cohort was selected retrospectively.
- The same historical test set was examined repeatedly, so intervals are exploratory rather than confirmatory.
- Survey questionnaire and business population coverage changed during the study window.
- The reconstructed Phase 15 models were successfully rerun locally by the author and their output files inspected; the original Census-download-to-result pipeline is **not** independently reproduced.
- The corrected Phase 19 forecasting script and numerical audit were **successfully rerun locally by the author**; archived accuracy metrics matched to floating-point precision. The rerun predictions and audit CSV have been archived and inspected; the reconstructed Phase 24 sensitivity script was successfully rerun by the author, with exact agreement across all 900 archived predictions; this is not an independent original-data or prospective validation.
- Archived source tables alone do not constitute a complete replication package; manuscripts and figures are intentionally excluded.

A [data-rights and historical Git-content review](DATA_RIGHTS_AND_HISTORY_REVIEW.md) documents unresolved publication risks. The [v4.1.0 release notes](RELEASE_NOTES_v4.1.0.md) are prepared on the current branch. They do **not** constitute a published GitHub release or DOI. The earlier v1.0.0-rc1 draft is superseded. For step-by-step local replication see [RUN_INSTRUCTIONS.md](RUN_INSTRUCTIONS.md). For verified versus pending outputs see [REPRODUCIBILITY_STATUS.md](REPRODUCIBILITY_STATUS.md).

## Declarations

**Funding:** No financial support was received for this research, authorship, or publication.

**Competing interests:** The author declares no competing financial or non-financial interests.

## Data source

[U.S. Census Bureau Business Trends and Outlook Survey](https://www.census.gov/programs-surveys/btos.html)

## License

The original research software and author-created software documentation are licensed under the [MIT License](LICENSE), copyright © 2026 Peter Sarpong. **This grant does not extend to third-party data, Census-derived aggregates, external macroeconomic series, or other material for which the author does not hold the necessary rights.** Those materials retain their own applicable source and redistribution terms; see [DATA_SOURCES.md](DATA_SOURCES.md).
