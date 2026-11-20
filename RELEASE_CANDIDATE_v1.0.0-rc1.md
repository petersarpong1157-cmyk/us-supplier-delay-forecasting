# Research code archive — v1.0.0-rc1 (draft release notes)

**Status:** Release candidate documentation only. No GitHub Release, Git tag, Zenodo deposit, or DOI has been created.

**Project:** Predicting Supplier Delivery-Time Disruptions Across U.S. Industries  
**Author:** Peter Sarpong, Independent Researcher  
**Date:** 2026-11-20

## Scope of this candidate

This is a public archive of **derived industry-level BTOS data, R scripts, numerical tables, model predictions, and reproducibility audits**. It intentionally **does not distribute manuscripts or figure images**.

The focus is a retrospective exploratory analysis rather than a prospective forecasting product. The corrected primary forecasting specification is Phase 19; the tighter historical training-window specification is Phase 24, a **post-hoc sensitivity**.

## Verified numerical outputs

| Analysis | Records | Verified result |
|---|---:|---|
| Phase 15 industry FE and industry+period FE one-lag models | 1,170 | Archived coefficients and clustered SEs matched to numerical precision |
| Phase 15 three-price-lag panel model | 1,110 | Cumulative price coefficient 0.1286766, SE 0.02806728, matching archive |
| Phase 19 corrected historical forecast evaluation | 300 matched targets; 900 model rows | Random forest MAE 1.164515 pp; persistence MAE 1.277333 pp |
| Phase 24 restricted-training-horizon sensitivity | 300 matched targets; 900 model rows | Random forest MAE 1.154348 pp; archived predictions matched exactly |

Random forest reduced corrected **historical** MAE by 8.8323% relative to persistence. The incremental MAE change under the post-hoc Phase 24 restriction was only +0.010166569 pp, with an exploratory origin-resampling interval that includes zero (approximately −0.00905 to +0.02942 pp). Do not present the Phase 24 result as a new prospectively selected model.

The Phase 19 forecast evaluation covers 20 origins and 15 industries, and the evaluated target reference periods begin 11 days after their forecast origins.

## Reproduction record

The author ran the reconstructed Phase 15 models and the Phase 19 and Phase 24 forecast/validation scripts locally in RStudio. Verification CSV and text files were reviewed and uploaded under `results/verified_phase15/` and `results/verified_phase19/`.

The reconstructed Phase 15 and 24 scripts were developed from archived results and existing script structure; they are **not recovered original source code**. The successful local checks do not constitute an independently executed end-to-end reproduction.

## Material limitations / release gates

1. **Raw data provenance:** The complete process from original U.S. Census BTOS downloads to the corrected processed panel has not been independently rerun.
2. **Vintages:** An audit of original-release historical BTOS vintages for every observation is outstanding.
3. **Survey comparability:** Instrument question numbering, business population coverage and weighting/denominators are not fully established as invariant.
4. **Forecast generalization:** Repeated examination of the retrospective test period means inference is exploratory; the forecasts are not prospectively validated.
5. **Data rights:** Review redistribution terms for any material derived from third parties prior to release. The included derived data are not an official U.S. Census product.
6. **Software environment:** The author's R 4.5.2 session and six installed package versions are now archived in `results/environment/`; an independent clean-environment rerun and full historical dependency lockfile are still outstanding.
7. **Prior Git history:** A manuscript text extraction was deleted from the current branch but exists in earlier Git history. A public tagged release of this repository would not erase that history.

These limitations must be clearly preserved in any external archive or citation.

## How to reproduce from this repository

See [RUN_INSTRUCTIONS.md](RUN_INSTRUCTIONS.md) for the scripts and [REPRODUCIBILITY_STATUS.md](REPRODUCIBILITY_STATUS.md) for the audit record. Verify scripts using the corrected processed panel and do not substitute the uncorrected Phase 16 output for the corrected Phase 19 run.

## Citation and licensing

The citation metadata is in [CITATION.cff](CITATION.cff). **No DOI exists yet** and no license has yet been granted. The author should decide on a code license and independently assess derived-data redistribution rights before public release.

## Release decision

**HOLD** on declaring this a complete reproducibility archive or minting a final DOI. This repository may later be released as a carefully scoped *code and processed-analysis archive* provided the remaining provenance/licensing issues are addressed and the limitations remain visible.

## Environment evidence update — 2026-11-20

The author supplied the R package versions, `sessionInfo()` output, and an MD5 input manifest, now stored under `results/environment/`. The manifest includes hashes for the corrected derived BTOS panel and Table 5. Two local prediction-file paths were unavailable when the manifest was generated; the relevant prediction data are available in GitHub but not covered by that MD5 manifest. This is useful reproducibility metadata but does not establish an independent raw-data or clean-environment reproduction.
