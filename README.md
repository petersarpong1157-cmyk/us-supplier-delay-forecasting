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

- `manuscript/`: readable **text extraction** of the working manuscript. The editable DOCX is not yet uploaded.
- `data/processed/`: archived BTOS-derived CSV panel with the period 202520 release date corrected to November 20, 2025.
- `scripts/`: corrected forecasting and archived Phase 16 scripts.
- `results/tables/`: eight main exhibit-source CSVs.
- `results/audits/`: six provenance, correction and sensitivity CSVs.
- `results/figures/`: **pending binary upload**, not included at present.

**Upload status:** CSVs, R scripts, and manuscript text are committed; manuscript DOCX and PNG figures still require a separate binary-file upload. See [UPLOAD_STATUS.md](UPLOAD_STATUS.md).

## Historical corrections and sensitivity

Period 202520 was initially assigned the scheduled October 9, 2025 date; the actual release was November 20, 2025. Periods 202521–202523 have unavailable survey outcomes.

A separate sensitivity excluded extended-horizon historical *training* records. Random forest MAE was 1.1543 (compared with 1.1645 in the corrected main run); its additional gain of 0.0102 percentage points had exploratory bootstrap interval −0.0090 to 0.0294. The main corrected model remains the primary specification.

## Reproducibility and limitations

- Original-release historical data vintages have not been independently verified for every observation.
- The 15-industry cohort was selected retrospectively.
- The same historical test set was examined repeatedly, so intervals are exploratory rather than confirmatory.
- Survey questionnaire and business population coverage changed during the study window.
- A complete independent end-to-end rerun of data acquisition, transformation, and econometric estimation is **not** yet established.
- Source tables and figures alone do not constitute a complete replication package.

See [REPRODUCIBILITY_STATUS.md](REPRODUCIBILITY_STATUS.md) for details.

## Declarations

**Funding:** No financial support was received for this research, authorship, or publication.

**Competing interests:** The author declares no competing financial or non-financial interests.

## Data source

[U.S. Census Bureau Business Trends and Outlook Survey](https://www.census.gov/programs-surveys/btos.html)

## License

No license is assigned to this repository at present. Third-party material remains subject to applicable source terms.
