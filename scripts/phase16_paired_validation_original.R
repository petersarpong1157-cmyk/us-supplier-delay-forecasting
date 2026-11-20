# PHASE 16 — PART B: PAIRED FORECAST VALIDATION
# Uses already generated Phase16_R_Results/phase16_rolling_predictions.csv.
# No re-training. Retrospective exploratory evaluation, not a confirmatory test.

required <- c('dplyr', 'ggplot2')
missing <- required[!vapply(required, requireNamespace, logical(1), quietly=TRUE)]
if(length(missing)) stop('Install these packages: ', paste(missing, collapse=', '))
suppressPackageStartupMessages({library(dplyr); library(ggplot2)})

out <- 'Phase16_R_Results'
infile <- file.path(out, 'phase16_rolling_predictions.csv')
if (!file.exists(infile)) stop('Missing ', infile, '\nRun the corrected Phase 16 forecasting script first.')
x <- read.csv(infile, stringsAsFactors=FALSE)
need <- c('origin','sector','target_period','model','target_value','prediction')
if (!all(need %in% names(x))) stop('Missing columns: ', paste(setdiff(need, names(x)), collapse=', '))
x$origin <- as.Date(x$origin)
if(anyNA(x$origin)) stop('Invalid forecast-origin dates')
if(anyNA(x[, c('target_value','prediction')])) stop('Missing outcomes or forecasts; audit before scoring')
x <- x %>% mutate(sector=as.character(sector), target_period=as.character(target_period),
                  abs_error=abs(prediction-target_value), error=prediction-target_value)
model_names <- c('Persistence','Random forest','Ridge (fixed lambda=5)')
if (!setequal(unique(x$model), model_names)) stop('Unexpected model labels: ', paste(unique(x$model), collapse=', '))
key <- c('origin','sector','target_period')
if (anyDuplicated(x[c(key,'model')])) stop('Duplicate (origin,sector,target_period,model) records; cannot form pairs.')
counts <- x %>% count(across(all_of(key)), name='n_models')
if(any(counts$n_models != 3L)) stop('Some forecast targets lack all 3 model predictions')

# Explicit wide paired comparisons; all models scored on identical targets
persist <- x %>% filter(model=='Persistence') %>% select(all_of(key), target_value, persist_error=error, persist_abs=abs_error)
forest <- x %>% filter(model=='Random forest') %>% select(all_of(key), rf_target=target_value, rf_error=error, rf_abs=abs_error)
ridge <- x %>% filter(model=='Ridge (fixed lambda=5)') %>% select(all_of(key), ridge_target=target_value, ridge_error=error, ridge_abs=abs_error)
pairs <- persist %>% inner_join(forest, by=key) %>% inner_join(ridge, by=key)
if(nrow(pairs) != nrow(persist) || any(pairs$target_value!=pairs$rf_target) || any(pairs$target_value!=pairs$ridge_target)) {
  stop('Paired dataset mismatch: check duplicated, missing, or inconsistent outcomes.')
}
pairs <- pairs %>% mutate(gain_rf_pp=persist_abs-rf_abs,
                          gain_ridge_pp=persist_abs-ridge_abs)
write.csv(pairs, file.path(out, 'phase16_paired_forecast_records.csv'), row.names=FALSE)

# Report point estimates on the common 300 targets
point <- data.frame(comparison=c('Random forest vs Persistence','Ridge vs Persistence'),
                    n_targets=nrow(pairs), n_origins=n_distinct(pairs$origin),
                    n_sectors=n_distinct(pairs$sector),
                    mae_gain_pp=c(mean(pairs$gain_rf_pp),mean(pairs$gain_ridge_pp)),
                    mae_gain_pct=c(100*mean(pairs$gain_rf_pp)/mean(pairs$persist_abs),
                                   100*mean(pairs$gain_ridge_pp)/mean(pairs$persist_abs)))

# Paired origin-cluster bootstrap: resample complete origins with replacement.
# Includes all sectors each time; never independently resamples model records.
origin_means <- pairs %>% group_by(origin) %>% summarise(
  rf_gain=mean(gain_rf_pp), ridge_gain=mean(gain_ridge_pp),
  persistence_mae=mean(persist_abs), rf_mae=mean(rf_abs), ridge_mae=mean(ridge_abs),
  n_sectors=n(), .groups='drop')
write.csv(origin_means, file.path(out,'phase16_origin_error_comparison.csv'),row.names=FALSE)
B <- 5000L
set.seed(160026)
K <- nrow(origin_means)
if(K < 8) stop('Too few forecast origins for exploratory bootstrap')
boot <- replicate(B, {
  ix <- sample.int(K, K, replace=TRUE)
  c(rf=mean(origin_means$rf_gain[ix]), ridge=mean(origin_means$ridge_gain[ix]))
})
# Balanced panels have same sectors per origin. Require this for origin means.
if(length(unique(origin_means$n_sectors)) != 1L) stop('Unbalanced origins: cluster bootstrap should use row-weighted resamples instead.')
point$ci_low_pp <- c(quantile(boot['rf',], 0.025), quantile(boot['ridge',], 0.025))
point$ci_high_pp <- c(quantile(boot['rf',], 0.975), quantile(boot['ridge',], 0.975))
point$origins_positive_gain <- c(sum(origin_means$rf_gain>0),sum(origin_means$ridge_gain>0))
point$interval_excludes_zero <- (point$ci_low_pp>0 | point$ci_high_pp<0)
write.csv(point, file.path(out,'phase16_paired_bootstrap_summary.csv'), row.names=FALSE)

# Industry diagnostics on the matched panel
by_sector <- pairs %>% group_by(sector) %>% summarise(
  n=n(), persist_mae=mean(persist_abs), rf_mae=mean(rf_abs), ridge_mae=mean(ridge_abs),
  rf_gain_pp=mean(gain_rf_pp), ridge_gain_pp=mean(gain_ridge_pp),
  rf_better_origins=sum(gain_rf_pp>0), .groups='drop') %>% arrange(desc(rf_gain_pp))
write.csv(by_sector, file.path(out,'phase16_sector_paired_comparison.csv'), row.names=FALSE)

# Leave-one-sector / leave-one-origin OUT of scored sample (not refitting forecasts)
loo_sector <- lapply(sort(unique(pairs$sector)), function(s) {
  z <- pairs[pairs$sector!=s,]
  data.frame(excluded_sector=s, n=nrow(z), rf_gain_pp=mean(z$gain_rf_pp),ridge_gain_pp=mean(z$gain_ridge_pp))
}) %>% bind_rows()
loo_origin <- lapply(sort(unique(pairs$origin)), function(o) {
  z <- pairs[pairs$origin!=o,]
  data.frame(excluded_origin=as.character(o), n=nrow(z), rf_gain_pp=mean(z$gain_rf_pp),ridge_gain_pp=mean(z$gain_ridge_pp))
}) %>% bind_rows()
write.csv(loo_sector,file.path(out,'phase16_loo_sector_scoring.csv'),row.names=FALSE)
write.csv(loo_origin,file.path(out,'phase16_loo_origin_scoring.csv'),row.names=FALSE)

# Figures
p1 <- ggplot(origin_means, aes(x=origin)) +
  geom_hline(yintercept=0,linetype='dashed',color='gray45') +
  geom_line(aes(y=rf_gain),color='steelblue') +
  geom_point(aes(y=rf_gain),color='steelblue',size=2) +
  labs(title='Random forest improvement over persistence by forecast origin',
       subtitle='Positive values indicate lower random-forest MAE',
       x='Forecast origin (published information cutoff)',y='Paired MAE reduction (percentage points)') + theme_minimal()
ggsave(file.path(out,'phase16_rf_gain_by_origin.png'),p1,width=10,height=5.5,dpi=300)
p2 <- ggplot(by_sector,aes(x=reorder(sector,rf_gain_pp),y=rf_gain_pp)) +
  geom_col(fill='steelblue') + geom_hline(yintercept=0,color='gray45') + coord_flip() +
  labs(title='Random forest advantage by industry', x='NAICS sector',y='Persistence MAE minus random forest MAE (pp)') + theme_minimal()
ggsave(file.path(out,'phase16_rf_gain_by_sector.png'),p2,width=9,height=6,dpi=300)

cat('\nPHASE 16 PART B COMPLETED — PAIRED VALIDATION\n')
cat('Matched targets:', nrow(pairs), 'Origins:',K,'Industries:',n_distinct(pairs$sector),'\n')
print(point, row.names=FALSE)
cat('\nSector-level results:\n')
print(by_sector, n=Inf)
cat('\nOutputs saved in:', normalizePath(out), '\n')
cat('\nCAUTION: exploratory clustered-bootstrap intervals; no multiple-testing/model-selection adjustment.\n')
