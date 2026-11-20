# RECONSTRUCTED Phase 24 training-horizon sensitivity, 2026-11-20
# Derived from scripts/phase19_corrected_forecasting.R and the archived
# documented <=14-day restriction for HISTORICAL TRAINING records only.
# NOT the original author script; requires an R rerun before claiming a match.
# Separate output directory; intentionally produces no manuscript or figures.
# Uses only corrected-release-date BTOS data; rejects uncorrected fallback.
# The restriction was evaluated post hoc; not a prospective model selection.

# PHASE 16 — RELEASE-SAFE PROSPECTIVE-HORIZON HISTORICAL BACKTEST
# Research: U.S. BTOS supplier-delivery-time increases
# Prediction origin: actual BTOS publication date
# Outcome: first reference period strictly starting AFTER forecast origin
# No FRED vintages, BEA networks, or unknown future period fixed effects.
# Script prepares and runs a retrospective simulation using archived BTOS files.
# NOT a real-time vintage audit or independent prospective confirmation.

required <- c("dplyr", "glmnet", "ranger")
missing_packages <- required[!vapply(required, requireNamespace, logical(1), quietly = TRUE)]
if (length(missing_packages)) {
  stop("Install packages first: install.packages(c(",
       paste(sprintf('"%s"', missing_packages), collapse = ", "), "))")
}
suppressPackageStartupMessages({
  library(dplyr)
  library(glmnet)
  library(ranger)
})

out <- "Phase24_Horizon_Sensitivity_Reconstructed"
dir.create(out, showWarnings = FALSE, recursive = TRUE)

# Try the user's extracted Phase 2 file first, then a flat copy.
paths <- c(
  "data/processed/btos_sector_panel_corrected_release_dates.csv",
  "Phase19_Methodology_Audit/btos_sector_panel_corrected_release_dates.csv"
)
path <- paths[file.exists(paths)][1]
if (is.na(path)) stop("BTOS sector CSV not found. Extract the Phase 2 ZIP first.")

raw <- read.csv(path, stringsAsFactors = FALSE)
needed <- c("sector", "period", "reference_start", "reference_end",
            "publication_date", "supplier_delay_increased_pct",
            "input_prices_increased_pct")
if (!all(needed %in% names(raw))) {
  stop("Required BTOS fields absent: ", paste(setdiff(needed, names(raw)), collapse = ", "))
}

raw <- raw %>%
  mutate(
    sector = as.character(sector), period = as.character(period),
    reference_start = as.Date(reference_start),
    reference_end = as.Date(reference_end),
    publication_date = as.Date(publication_date),
    supplier_delay_increased_pct = as.numeric(supplier_delay_increased_pct),
    input_prices_increased_pct = as.numeric(input_prices_increased_pct)
  ) %>%
  filter(!is.na(publication_date), !is.na(reference_start), sector != "XX")

# Pre-specified research cohort; eligibility based on published Q11 coverage.
coverage <- raw %>%
  group_by(sector) %>%
  summarise(availability = mean(!is.na(supplier_delay_increased_pct)),
            periods = n(), .groups = "drop")
sectors <- coverage %>% filter(availability >= 0.90) %>% pull(sector) %>% sort()
if (length(sectors) < 5) stop("Too few high-coverage industries")
raw <- raw %>% filter(sector %in% sectors)
write.csv(coverage, file.path(out, "phase16_sector_coverage.csv"), row.names = FALSE)

# Survey reference-period calendar is derived from dates, not arithmetic on BTOS codes.
calendar <- raw %>%
  distinct(period, reference_start, reference_end) %>%
  arrange(reference_start)
if (anyDuplicated(calendar$period)) stop("Period calendar has conflicting dates")
origins <- sort(unique(raw$publication_date))

# Build a single point-in-time feature row for each industry and release date.
# The target outcome is looked up only for historical scoring, never as a feature.
rows <- list()
k <- 0L
for (origin_idx in seq_along(origins)) {
  origin <- origins[origin_idx]  # indexing preserves the Date class
  stopifnot(inherits(origin, "Date"))
  target <- calendar %>% filter(reference_start > origin) %>% slice_head(n = 1)
  if (nrow(target) == 0L) next
  target_period <- target$period[[1]]
  for (sec in sectors) {
    prior <- raw %>%
      filter(sector == sec, publication_date <= origin) %>%
      arrange(desc(publication_date), desc(reference_start))
    known_delays <- prior %>% filter(is.finite(supplier_delay_increased_pct))
    known_prices <- prior %>% filter(is.finite(input_prices_increased_pct))
    if (nrow(known_delays) == 0 || nrow(known_prices) < 3L) next
    last_delay <- known_delays %>% slice_head(n = 1)
    price_mean3 <- mean(head(known_prices$input_prices_increased_pct, 3))
    age_days <- as.integer(origin - last_delay$publication_date[[1]])
    target_row <- raw %>% filter(sector == sec, period == target_period)
    if (nrow(target_row) != 1L) next
    if (!(target_row$publication_date[[1]] > origin)) {
      stop("Timing violation: target published at or before forecast origin")
    }
    k <- k + 1L
    rows[[k]] <- data.frame(
      origin = origin, target_period = target_period,
      target_start = target$reference_start[[1]],
      target_end = target$reference_end[[1]],
      target_release = target_row$publication_date[[1]],
      sector = sec,
      last_delay = last_delay$supplier_delay_increased_pct[[1]],
      price_mean3 = price_mean3,
      age_days = age_days,
      target_value = target_row$supplier_delay_increased_pct[[1]]
    )
  }
}
if (length(rows) == 0L) stop("No eligible release-safe forecast records")
pairs <- bind_rows(rows) %>%
  mutate(sector = factor(sector, levels = sectors)) %>%
  arrange(origin, sector)

# Hard checks: info is available before target starts; the outcome becomes public later.
stopifnot(all(pairs$origin < pairs$target_start))
stopifnot(all(pairs$target_release > pairs$origin))
stopifnot(all(is.finite(pairs$last_delay)))
stopifnot(all(is.finite(pairs$price_mean3)))
write.csv(pairs, file.path(out, "phase16_information_availability_audit.csv"), row.names = FALSE)

# Retrospective rolling-origin scoring: 20 most recent origin dates with observed outcomes.
# Each model's training records must have had their target published by the forecast origin.
scorable <- pairs %>% filter(is.finite(target_value))
eval_origins <- tail(sort(unique(scorable$origin)), 20L)
predictions <- list()
i <- 0L
for (origin_idx in seq_along(eval_origins)) {
  origin <- eval_origins[origin_idx]  # indexing preserves the Date class
  stopifnot(inherits(origin, "Date"))
  test <- scorable %>% filter(origin == !!origin)
  train <- scorable %>%
    filter(target_release <= !!origin, .data$origin < !!origin)
  # Post-hoc Phase 24 sensitivity restriction. Apply to historical training
  # records only; leave the final evaluated forecast origins/targets untouched.
  # The upper bound counts days from each TRAINING origin, not from this loop's
  # evaluation origin.
  train <- train %>%
    filter(as.integer(.data$target_start - .data$origin) <= 14L)
  # The number of independent training origins matters alongside row count.
  if (nrow(train) < 250L || n_distinct(train$origin) < 18L || nrow(test) < 5L) next

  # Same fixed factor levels and same predictors for both statistical models.
  train$sector <- factor(as.character(train$sector), levels = sectors)
  test$sector <- factor(as.character(test$sector), levels = sectors)
  predictors <- c("sector", "last_delay", "price_mean3", "age_days")
  formula <- ~ sector + last_delay + price_mean3 + age_days
  x_train <- model.matrix(formula, data = train)[, -1, drop = FALSE]
  x_test <- model.matrix(formula, data = test)[, -1, drop = FALSE]

  # Fixed ridge penalty; no hyperparameter selection on the test outcomes.
  ridge <- glmnet::glmnet(x_train, train$target_value,
                          alpha = 0, lambda = 5, standardize = TRUE)
  pr_ridge <- as.numeric(predict(ridge, newx = x_test, s = 5))

  rf <- ranger::ranger(
    target_value ~ sector + last_delay + price_mean3 + age_days,
    data = train[, c("target_value", predictors)],
    num.trees = 300, mtry = 2, min.node.size = 10,
    seed = 2026, num.threads = 1
  )
  pr_rf <- as.numeric(predict(rf, data = test[, predictors])$predictions)
  i <- i + 1L
  predictions[[i]] <- bind_rows(
    transform(test, model = "Persistence", prediction = last_delay),
    transform(test, model = "Ridge (fixed lambda=5)", prediction = pmin(100, pmax(0, pr_ridge))),
    transform(test, model = "Random forest", prediction = pmin(100, pmax(0, pr_rf)))
  )
}
if (!length(predictions)) {
  stop("No eligible backtest origins met training thresholds; adjust only with documented rationale.")
}
results <- bind_rows(predictions) %>%
  mutate(error = prediction - target_value, abs_error = abs(error),
         squared_error = error^2)
stopifnot(all(is.finite(results$prediction)))
write.csv(results, file.path(out, "phase16_rolling_predictions.csv"), row.names = FALSE)

metrics <- results %>% group_by(model) %>%
  summarise(n_predictions = n(), n_origins = n_distinct(origin),
            n_sectors = n_distinct(sector),
            MAE_pp = mean(abs_error), RMSE_pp = sqrt(mean(squared_error)),
            bias_pp = mean(error), .groups = "drop") %>%
  arrange(MAE_pp)
write.csv(metrics, file.path(out, "phase16_model_metrics.csv"), row.names = FALSE)

sector_metrics <- results %>% group_by(sector, model) %>%
  summarise(n = n(), MAE_pp = mean(abs_error), .groups = "drop")
write.csv(sector_metrics, file.path(out, "phase16_sector_metrics.csv"), row.names = FALSE)

cat("\nPHASE 24 RECONSTRUCTED — POST-HOC TRAINING-HORIZON SENSITIVITY\n")
cat("BTOS source:", path, "\n")
cat("Industries:", paste(sectors, collapse = ", "), "\n")
cat("Forecast origins:", n_distinct(results$origin), "\n")
print(metrics)
cat("\nOutputs:", normalizePath(out), "\n")
