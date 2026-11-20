# Capture R environment metadata for reproducibility
# Run this from the repository root. No figures/manuscripts created.
out <- "reproducibility_checks"
dir.create(out, recursive=TRUE, showWarnings=FALSE)
packages <- c("dplyr","fixest","glmnet","ranger","ggplot2","Matrix")
rows <- data.frame(
  package=packages,
  installed=vapply(packages, requireNamespace, logical(1), quietly=TRUE),
  version=vapply(packages, function(p) {
    if(requireNamespace(p,quietly=TRUE)) as.character(utils::packageVersion(p))
    else NA_character_
  }, character(1))
)
write.csv(rows,file.path(out,"r_package_versions.csv"),row.names=FALSE)
capture.output(sessionInfo(),file=file.path(out,"r_session_info.txt"))
files <- c(
  "data/processed/btos_sector_panel_corrected_release_dates.csv",
  "results/verified_phase19/phase19_corrected_primary_predictions.csv",
  "results/verified_phase19/phase24_restricted_horizon_predictions.csv",
  "results/tables/table5_corrected_accuracy.csv"
)
present <- file.exists(files)
hashes <- data.frame(path=files,available=present,md5=NA_character_)
hashes$md5[present] <- unname(tools::md5sum(files[present]))
write.csv(hashes,file.path(out,"input_md5_manifest.csv"),row.names=FALSE)
cat("Environment captured in",normalizePath(out), "\n")
print(rows)
