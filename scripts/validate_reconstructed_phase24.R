# Phase 24 reconstructed sensitivity validation (2026-11-20)
# Run AFTER source("reconstructed_phase24_training_horizon.R")
# Reads the archived Phase 24 and corrected primary prediction CSVs from
# GitHub if not available locally; no original-source/vintage assertion.
# Creates only CSV audit files, no figures or manuscripts.

result_dir <- "Phase24_Horizon_Sensitivity_Reconstructed"
candidate <- file.path(result_dir,"phase16_rolling_predictions.csv")
if(!file.exists(candidate)) stop("Missing Phase 24 reconstructed predictions: ", candidate)

repo_base <- paste0(
 "https://raw.githubusercontent.com/petersarpong1157-cmyk/",
 "us-supplier-delay-forecasting/main/results/verified_phase19/")
read_reference <- function(filename) {
  local_path <- file.path("results","verified_phase19",filename)
  if(file.exists(local_path))
    return(read.csv(local_path,stringsAsFactors=FALSE))
  temporary <- tempfile(fileext=".csv")
  on.exit(unlink(temporary),add=TRUE)
  tryCatch(
    download.file(paste0(repo_base,filename), temporary, mode="wb", quiet=TRUE),
    error=function(e) stop("Cannot download archived reference ",filename,": ",conditionMessage(e))
  )
  read.csv(temporary,stringsAsFactors=FALSE)
}
current <- read.csv(candidate, stringsAsFactors=FALSE)
archived <- read_reference("phase24_restricted_horizon_predictions.csv")
primary <- read_reference("phase19_corrected_primary_predictions.csv")

keys <- c("origin","sector","target_period","model")
fields <- c(keys,"target_start","target_value","prediction")
if(!all(fields %in% names(current)) ||
   !all(fields %in% names(archived)) ||
   !all(fields %in% names(primary))) stop("Missing required forecast columns")
current$sector <- as.character(current$sector)
archived$sector <- as.character(archived$sector)
primary$sector <- as.character(primary$sector)
models <- c("Persistence","Random forest","Ridge (fixed lambda=5)")
for (x in list(current,archived,primary)) {
  if(nrow(x)!=900L || anyDuplicated(x[key]) ||
     !setequal(unique(x$model),models) ||
     length(unique(x$origin))!=20L ||
     length(unique(x$sector))!=15L) stop("Expected 900 unique three-model records across 20 origins and 15 sectors")
  if(any(!is.finite(x$prediction)) ||
     any(!is.finite(x$target_value))) stop("Missing numeric predictions/outcomes")
  if(any(as.integer(as.Date(x$target_start)-as.Date(x$origin))!=11L))
    stop("Nonstandard evaluation lead time")
}

# Compare the exact same industry-origin-model and target outcome.
joined <- merge(
  current[,fields],
  archived[,fields],
  by=keys,suffixes=c("_reproduced","_archived"),sort=FALSE)
if(nrow(joined)!=900L) stop("Archive keys differ from reconstruction")
if(any(joined$target_start_reproduced != joined$target_start_archived) ||
   any(abs(joined$target_value_reproduced - joined$target_value_archived)>1e-12)) {
  stop("Reproduced evaluation targets do not match archive")
}
joined$prediction_difference <- joined$prediction_reproduced - joined$prediction_archived
joined$abs_prediction_difference <- abs(joined$prediction_difference)
by_model <- do.call(rbind,lapply(models,function(m) {
  z <- joined[joined$model==m,,drop=FALSE]
  data.frame(model=m,n=nrow(z),
             MAE_reproduced=mean(abs(z$prediction_reproduced-z$target_value_reproduced)),
             MAE_archived=mean(abs(z$prediction_archived-z$target_value_archived)),
             maximum_abs_prediction_difference=max(z$abs_prediction_difference),
             mean_abs_prediction_difference=mean(z$abs_prediction_difference))
}))
rownames(by_model) <- NULL
print(by_model)
dir.create("reproducibility_checks",recursive=TRUE,showWarnings=FALSE)
write.csv(by_model,"reproducibility_checks/phase24_reproduction_check.csv",row.names=FALSE)

# IMPORTANT: don't silently waive prediction-level disagreement just because
# aggregate accuracy is similar. Ranger numeric tolerances across systems
# may vary; inspect differences before accepting a rerun.
if(any(by_model$maximum_abs_prediction_difference > 1e-5)) {
  stop("Phase 24 reproduced predictions differ from archived forecasts by >1e-5 pp.")
}

# Sensitivity is evaluated against identical main-model targets.
main <- primary[,c(keys,"target_start","target_value","prediction")]
names(main)[names(main)=="prediction"] <- "primary_prediction"
paired <- merge(joined,main,by=keys,sort=FALSE)
if(nrow(paired)!=900L ||
   any(abs(paired$target_value_reproduced-paired$target_value)>1e-12) ||
   any(paired$target_start_reproduced != paired$target_start)) stop("Primary and restricted evaluation targets differ")
paired$gain_restricted_vs_primary <- abs(paired$primary_prediction-paired$target_value) -
                                    abs(paired$prediction_reproduced-paired$target_value)
gain <- aggregate(gain_restricted_vs_primary~model,data=paired,mean)
print(gain)
write.csv(gain,"reproducibility_checks/phase24_restriction_gain.csv",row.names=FALSE)
rf <- gain$gain_restricted_vs_primary[gain$model=="Random forest"]
ridge <- gain$gain_restricted_vs_primary[gain$model=="Ridge (fixed lambda=5)"]
if(abs(rf-0.0101665693384781)>1e-5 ||
   abs(ridge-0.00919459635767487)>1e-5)
  stop("Restricted-vs-primary gains differ from archived Phase 24 results")

cat("PASS: Phase 24 prediction-level sensitivity reproduction matched archived forecasts.\n")
cat("This is a post-hoc robustness result, NOT independently validated prospective performance.\n")
