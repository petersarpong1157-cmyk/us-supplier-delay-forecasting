# Reconstructed Phase 15 one-lag models
# Author: Peter Sarpong
# Reconstruction: 2026-11-20. This is NOT the original missing script.
# Input: data/processed/btos_sector_panel_corrected_release_dates.csv
# Run from the repository root after installing dplyr and fixest.
# Does not upload manuscript files or figures.
#
# Uses one-period lags on the original calendar, retaining gaps, rather than
# computing lags after removal of invalid or missing survey periods.
#
# The two fixed effects specifications here each have 1,170 observations,
# distinct from the 1,110-observation distributed-lag model.

packages <- c("dplyr", "fixest")
missing_packages <- packages[!vapply(packages, requireNamespace,
                                    logical(1), quietly=TRUE)]
if(length(missing_packages)) {
  stop("Install missing R packages: ", paste(missing_packages, collapse=", "))
}
suppressPackageStartupMessages({
  library(dplyr)
  library(fixest)
})
input <- "data/processed/btos_sector_panel_corrected_release_dates.csv"
out <- "reproducibility_checks"
dir.create(out, showWarnings=FALSE, recursive=TRUE)
if(!file.exists(input)) stop("Missing corrected BTOS panel at: ",input)
d <- read.csv(input, stringsAsFactors=FALSE, check.names=FALSE)
need <- c("sector", "period", "reference_start",
          "supplier_delay_increased_pct", "input_prices_increased_pct")
if(!all(need %in% names(d))) stop("Missing columns: ",
   paste(setdiff(need, names(d)),collapse=", "))
cohort <- c("23","31","42","44","48","51","52","53",
            "54","56","61","62","71","72","81")
d <- d %>%
  mutate(sector=as.character(sector),period=as.character(period),
         reference_start=as.Date(reference_start),
         supplier_delay_increased_pct=as.numeric(supplier_delay_increased_pct),
         input_prices_increased_pct=as.numeric(input_prices_increased_pct)) %>%
  filter(sector %in% cohort)
stopifnot(nrow(d)==1245L, dplyr::n_distinct(d$period)==83L)
if(anyDuplicated(d[c("sector","period")])) stop("Duplicate sector-period keys")

calendar <- d %>%
  distinct(period, reference_start) %>%
  arrange(reference_start, period) %>%
  mutate(period_index=row_number())
if(anyNA(calendar$reference_start)) stop("Invalid calendar dates")

panel <- d %>%
  left_join(calendar, by=c("period","reference_start")) %>%
  arrange(sector,period_index) %>%
  group_by(sector) %>%
  mutate(delay_lag=lag(supplier_delay_increased_pct,1L),
         prices_lag=lag(input_prices_increased_pct,1L)) %>%
  ungroup()

sample <- panel %>%
  filter(is.finite(supplier_delay_increased_pct),
         is.finite(delay_lag), is.finite(prices_lag)) %>%
  arrange(sector,period_index)
if(nrow(sample)!=1170L || n_distinct(sample$sector)!=15L) {
  stop("Reconstruction sample differs: expected 1170 rows across 15 sectors; got ",
       nrow(sample))
}
if(n_distinct(sample$period)!=78L) stop("Expected 78 survey periods")
write.csv(sample,file.path(out,"phase15_one_lag_sample.csv"),row.names=FALSE)
cat("One-lag sample: ",nrow(sample)," records, ",
    n_distinct(sample$sector)," industries, ",
    n_distinct(sample$period)," periods.\n",sep="")

# Original two-way clustering: 15 sector clusters and time-period clusters.
m_industry <- feols(
  supplier_delay_increased_pct ~ delay_lag + prices_lag | sector,
  data=sample, vcov=~sector+period
)
m_two_way_fe <- feols(
  supplier_delay_increased_pct ~ delay_lag + prices_lag | sector+period,
  data=sample, vcov=~sector+period
)
stopifnot(nobs(m_industry)==1170L,nobs(m_two_way_fe)==1170L)
capture.output(etable(m_industry,m_two_way_fe),
               file=file.path(out,"phase15_one_lag_regressions.txt"))

get_coef <- function(m, label) {
  ct <- as.data.frame(coeftable(m))
  ct$variable <- rownames(ct)
  ct$model <- label
  rownames(ct) <- NULL
  ct
}
coef_table <- bind_rows(
  get_coef(m_industry,"Industry FE"),
  get_coef(m_two_way_fe,"Industry + Period FE"))
write.csv(coef_table,file.path(out,"phase15_one_lag_coefficients.csv"),
          row.names=FALSE)

# Compare independently against the ARCHIVED point estimates.
archived <- data.frame(
  model=c("Industry FE","Industry FE",
          "Industry + Period FE","Industry + Period FE"),
  variable=c("delay_lag","prices_lag","delay_lag","prices_lag"),
  estimate=c(0.523289171112821,0.0560284568805045,
             0.411782933049247,0.0881916927606622),
  archived_se=c(0.0565000129758522,0.0206061628740192,
                0.0853818964343202,0.0232811623085526)
)
estimates <- bind_rows(
  data.frame(model="Industry FE",variable=names(coef(m_industry)),
             estimate_new=as.numeric(coef(m_industry)),
             se_new=as.numeric(se(m_industry))),
  data.frame(model="Industry + Period FE",variable=names(coef(m_two_way_fe)),
             estimate_new=as.numeric(coef(m_two_way_fe)),
             se_new=as.numeric(se(m_two_way_fe)))
)
audit <- left_join(archived,estimates,by=c("model","variable")) %>%
  mutate(estimate_gap=estimate_new-estimate,
         se_gap=se_new-archived_se)
write.csv(audit,file.path(out,"phase15_one_lag_archive_comparison.csv"),
          row.names=FALSE)
print(audit)
if(anyNA(audit$estimate_gap) || any(abs(audit$estimate_gap)>1e-4)) {
  stop("Reconstructed one-lag point estimates differ from archive. Inspect audit CSV.")
}
if(anyNA(audit$se_gap) || any(abs(audit$se_gap)>1e-3)) {
  warning("Standard errors differ from archive; investigate small-sample correction / fixest version.")
}
cat("PASS: One-lag model point estimates match archived estimates to 1e-4.\n")
cat("Review standard errors and the saved comparison CSV before marking the model verified.\n")
