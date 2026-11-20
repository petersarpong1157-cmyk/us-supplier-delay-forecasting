# Reconstructed Phase 15: industry and time fixed-effects regressions
# Reconstructed 2026-11-20 from archived model-sample/summary files.
# NOT the original estimation script. Requires R and fixest.
#
# Run from repository root:
# source("scripts/reconstructed_phase15_prepare_sample.R")
# source("scripts/reconstructed_phase15_econometrics.R")

if (!requireNamespace("fixest", quietly=TRUE)) {
  stop('Install the needed package: install.packages("fixest")')
}
suppressPackageStartupMessages(library(fixest))
infile <- "reproducibility_checks/phase15_reconstructed_sample.csv"
out <- "reproducibility_checks"
if(!file.exists(infile)) stop("Run reconstructed_phase15_prepare_sample.R first")
x <- read.csv(infile, stringsAsFactors=FALSE)
x$sector <- factor(x$sector)
x$period <- factor(x$period)
stopifnot(nrow(x)==1110, nlevels(x$sector)==15, nlevels(x$period)==74)

# Main models are on the SAME complete-case 1110-record sample.
m_short <- feols(
  supplier_delay_increased_pct ~ delay_l1 + prices_l1 | sector + period,
  data=x, vcov=~sector + period)
m_full <- feols(
  supplier_delay_increased_pct ~ delay_l1 + prices_l1 + prices_l2 + prices_l3 |
  sector + period, data=x, vcov=~sector + period)
# Non-causal associations; two-way clustered standard errors (15 sector clusters).
capture.output(etable(m_short,m_full),file=file.path(out,"phase15_reconstructed_regressions.txt"))
cs <- as.data.frame(coeftable(m_full))
cs$variable <- rownames(cs)
write.csv(cs,file.path(out,"phase15_reconstructed_coefficients.csv"),row.names=FALSE)

# Main estimate checks from archived Phase 15 analytical outputs.
expected <- c(delay_l1=0.37894259, prices_l1=0.01561126,
              prices_l2=0.03587415,prices_l3=0.07719124)
actual <- coef(m_full)[names(expected)]
if(anyNA(actual) || any(abs(actual-expected)>0.0001))
  stop("Main model estimates do not match archived coefficients")
cat("Verified: model point estimates reproduce archived coefficients within 1e-4.\n")

# Cumulative price-association coefficient; its variance reflects full
# coefficient covariance, including cross-term covariances.
L <- setNames(rep(0,length(coef(m_full))),names(coef(m_full)))
L[c("prices_l1","prices_l2","prices_l3")] <- 1
cumulative <- sum(L*coef(m_full))
cumulative_se <- sqrt(drop(t(L) %*% vcov(m_full) %*% L))
archive_cumulative <- 0.12867665
archive_se <- 0.02806728
cat("Cumulative estimate:", cumulative, " SE:", cumulative_se, "\n")
stopifnot(abs(cumulative-archive_cumulative)<0.0001)
# For archived SE, differences can arise from fixest version and small-sample
# corrections; flag rather than silently treating them as a successful match.
if(abs(cumulative_se-archive_se)>0.001)
  warning("Cumulative SE differs from archived: check fixest version and SSC")
write.csv(data.frame(estimate=cumulative,standard_error=cumulative_se,
                     normal_ci_low=cumulative-1.96*cumulative_se,
                     normal_ci_high=cumulative+1.96*cumulative_se),
          file.path(out,"phase15_reconstructed_cumulative.csv"),row.names=FALSE)

# Optional one-lag model was originally evaluated on a different sample
# (1170 observations), and should NOT be inferred from the 1110-record
# three-lag complete-case data.
cat("Note: separate 1170-record one-lag model is not reconstructed here.\n")
cat("Historical coefficients verified; original production script not recovered.\n")
