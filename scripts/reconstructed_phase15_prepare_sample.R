# Reconstructed Phase 15: analytical sample creation
# Reconstructed 2026-11-20 from archived, corrected BTOS sector panel and
# phase15_distributed_lag_sample.csv; NOT the original author script.
# Input: repository's data/processed/btos_sector_panel_corrected_release_dates.csv
# Output: local reproducibility_checks/ directory; manuscripts/figures excluded.
#
# The research cohort is a retrospective 15-sector cohort. Do not call it
# pre-registered or independently prospective.

suppressPackageStartupMessages(library(dplyr))
input <- "data/processed/btos_sector_panel_corrected_release_dates.csv"
out_dir <- "reproducibility_checks"
dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)
stopifnot(file.exists(input))
raw <- read.csv(input, stringsAsFactors = FALSE, check.names = FALSE)
required <- c("sector", "period", "reference_start",
              "supplier_delay_increased_pct", "input_prices_increased_pct")
stopifnot(all(required %in% names(raw)))
cohort <- c("23","31","42","44","48","51","52","53",
            "54","56","61","62","71","72","81")
raw <- raw %>%
  mutate(sector = as.character(sector),
         period = as.character(period),
         reference_start = as.Date(reference_start),
         supplier_delay_increased_pct = as.numeric(supplier_delay_increased_pct),
         input_prices_increased_pct = as.numeric(input_prices_increased_pct)) %>%
  filter(sector %in% cohort)
if(nrow(raw) != 1245L || n_distinct(raw$period) != 83L) {
  stop("Unexpected corrected BTOS research cohort: expected 1245 rows, 83 periods")
}
if(anyDuplicated(raw[c("sector","period")])) stop("Duplicate industry-period records")
calendar <- raw %>%
  distinct(period, reference_start) %>%
  arrange(reference_start, period) %>%
  mutate(period_index = row_number())
stopifnot(nrow(calendar) == 83L, !anyNA(calendar$reference_start))
panel <- raw %>%
  left_join(calendar, by=c("period","reference_start")) %>%
  arrange(sector, period_index) %>%
  group_by(sector) %>%
  mutate(
    delay_l1 = lag(supplier_delay_increased_pct, 1L),
    prices_l1 = lag(input_prices_increased_pct, 1L),
    prices_l2 = lag(input_prices_increased_pct, 2L),
    prices_l3 = lag(input_prices_increased_pct, 3L)) %>%
  ungroup()
# The original reference period index remains continuous even if some BTOS
# periods are missing. Lag across missing periods is NOT bridged or compressed.
model_data <- panel %>%
  filter(is.finite(supplier_delay_increased_pct),
         is.finite(delay_l1), is.finite(prices_l1),
         is.finite(prices_l2), is.finite(prices_l3)) %>%
  arrange(sector, period_index)
stopifnot(nrow(model_data) == 1110L, n_distinct(model_data$sector) == 15L,
          n_distinct(model_data$period) == 74L)
write.csv(model_data, file.path(out_dir, "phase15_reconstructed_sample.csv"),
          row.names = FALSE)
cat("Reconstructed 1110 observations across 15 sectors and 74 periods.\n")

# Optional field-by-field comparison with independent archived reference sample.
reference <- "phase15_distributed_lag_sample.csv"
if(file.exists(reference)) {
  old <- read.csv(reference, stringsAsFactors=FALSE)
  old$sector <- as.character(old$sector); old$period <- as.character(old$period)
  keys <- c("sector","period")
  compare <- merge(model_data, old[,c(keys, "delay_l1",
                         "prices_l1","prices_l2","prices_l3")],
                   by=keys, suffixes=c("_new","_archive"))
  if(nrow(compare)!=1110L) stop("Archive and rebuilt observation keys differ")
  vars <- c("delay_l1","prices_l1","prices_l2","prices_l3")
  for(v in vars) {
    if(any(abs(compare[[paste0(v,"_new")]] -
               compare[[paste0(v,"_archive")]]) > 1e-9))
      stop("Archive lag mismatch in ",v)
  }
  cat("All 1110 rows match four archived lag fields.\n")
}
