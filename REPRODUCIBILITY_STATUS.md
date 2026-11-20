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
