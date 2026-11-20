> **Superseded draft:** The proposed release version has changed to [v4.1.0](RELEASE_NOTES_v4.1.0.md). This v4.0.9 document is retained as historical preparation notes, not the current release instructions.

# Research Code and Reproducibility Archive — v4.0.9

**Repository:** https://github.com/petersarpong1157-cmyk/us-supplier-delay-forecasting  
**Research:** Predicting Supplier Delivery-Time Disruptions Across U.S. Industries  
**Author:** Peter Sarpong (Independent Researcher)  
**Release preparation date:** November 20, 2026  
**Status:** Prepared on the `main` branch. **Not a published GitHub release or assigned Zenodo DOI.**

## Description

This version packages the research scripts, derived industry-level U.S. Census Business Trends and Outlook Survey (BTOS) panel, econometric results, corrected retrospective forecasts, sensitivity analyses, package environment records and verification checks.

### Confirmed numerical reproduction

- **Phase 15 one-lag fixed-effects models:** 1,170 observations; 15 industries; 78 periods; all archived model coefficients and two-way clustered standard errors reproduced to floating-point precision.
- **Phase 15 distributed-lag fixed-effects model:** 1,110 observations; 15 industries; 74 periods; cumulative input-price lag coefficient **0.1286766**, clustered SE **0.02806728**.
- **Phase 19 primary corrected retrospective forecast:** 300 matched outcomes across 20 forecast origins and 15 industries. Random forest **MAE 1.164515 pp**, persistence **1.277333 pp**, ridge **1.794405 pp**. Random forest achieved **8.83% lower historical MAE** than persistence.
- **Phase 24 training-horizon sensitivity (post hoc):** 900 prediction rows reproduced exactly. Restricted-window random forest **MAE 1.154348 pp**, additional gain over Phase 19 **0.010166569 pp**; the exploratory origin-bootstrap interval for that gain includes zero. Do not reinterpret this sensitivity as a prospective winner.

### Contents

- `data/processed/`: corrected, derived BTOS industry panel
- `scripts/`: R econometric and forecasting scripts, reconstruction scripts, validation scripts and session capture
- `results/tables/`, `results/audits/`: numerical exhibits and historical checks
- `results/verified_phase15/`, `results/verified_phase19/`: inspected output files and model predictions
- `results/environment/`: R 4.5.2 Windows 11 session, package versions and MD5 manifest
- `RUN_INSTRUCTIONS.md`, `DATA_SOURCES.md`, `REPRODUCIBILITY_STATUS.md`: methodology, provenance, verification boundaries

### Limitations and source attribution

The BTOS variables measure percentages of businesses reporting **increases** in input prices or supplier delivery times, not days of delay or price-change magnitudes. The selected 15-industry cohort is retrospective, not SME-only. The three unavailable 2025 survey periods are missing rather than zero.

Successful numerical reruns are based on the archived corrected processed panel. **The full original Census-download-to-processed-panel pipeline, original-release vintages, survey-frame comparability and independent prospective accuracy have not been established.** Some reconstruction scripts are newly authored and are not recovered original production scripts.

Data source: U.S. Census Bureau, [Business Trends and Outlook Survey](https://www.census.gov/programs-surveys/btos.html). The processed panel also contains non-Census macroeconomic fields. See [DATA_SOURCES.md](DATA_SOURCES.md) and [DATA_RIGHTS_AND_HISTORY_REVIEW.md](DATA_RIGHTS_AND_HISTORY_REVIEW.md) for attribution and unresolved third-party data-redistribution questions. **License:** Original author-created research software and its associated documentation are released under the [MIT License](LICENSE), copyright © 2026 Peter Sarpong. This grant does **not** relicense third-party data or code, including Census-derived and non-Census macroeconomic fields. Their source-specific terms and redistribution review remain applicable.

**Repository scope:** Current-branch archive intentionally excludes manuscripts and figure images. A previously deleted manuscript text extraction remains in older Git history; the author has acknowledged this and elected to retain the existing repository and its history.

### Reproducing the numerical results

Follow [RUN_INSTRUCTIONS.md](RUN_INSTRUCTIONS.md). Phase 24 must be labeled **post-hoc sensitivity**. The package versions for the author's successful rerun are archived in `results/environment/`.

### Citation / DOI

The repository contains `CITATION.cff`. **Do not insert a Zenodo DOI until Zenodo actually issues one.** This file is prepared for a proposed `v4.0.9` GitHub release; creating this document does **not** create a Git tag, GitHub Release, Zenodo deposit or DOI.
