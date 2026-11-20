# Public-data rights and Git history: release gate review
**Review date:** 2026-11-20  
**Status:** Action plan, **not** a legal opinion or clearance of all included files.

## 1. Source data and permitted public use

The project's core measured outcomes derive from the **U.S. Census Bureau Business Trends and Outlook Survey (BTOS)**, which publicly releases aggregate statistics. These are not confidential firm-level responses.

Relevant official links:
- [BTOS information and downloads](https://www.census.gov/programs-surveys/btos.html)
- [BTOS datasets and downloads](https://www.census.gov/hfp/btos/data_downloads)
- [Census citation guidance](https://www.census.gov/about/policies/citation.html)
- [Census transparency and reproducibility principles](https://www.census.gov/about/policies/quality/guidelines/transparency.html)

Census recommends citing experimental statistical products using the product title, vintage, URL and access date. Suggested attribution for this archive, to be made more specific using exact original file names:

> U.S. Census Bureau. *Business Trends and Outlook Survey (BTOS)* [Experimental], public industry-level releases covering 2023–2026, https://www.census.gov/hfp/btos/data_downloads (accessed November 20, 2026). Selected/processed and analyzed by Peter Sarpong; analytical corrections and transformations documented in this repository.

The processed panel includes columns besides the Census BTOS response series (e.g. `gscpi_lagged_revised`, `ppi_level_lagged`, and vintage-selected macro fields). The actual third-party source terms and original file URLs for these derived fields are **not fully documented** in this release candidate. Do not claim the whole panel is exclusively Census-originated or free of third-party restrictions.

The file being included publicly does not itself prove that every original data source or transformation is independently validated or authorized for republication. Review and cite each non-Census source separately. Avoid applying a blanket license to third-party data unless its terms permit it.

## 2. Methodological disclosure

- The data measure the **share of businesses reporting increases**, not the number of days delayed or the size of a price change.
- The 15-industry cohort was chosen retrospectively; the analysis is not restricted to SMEs.
- Period 202520's corrected publication date is November 20, 2025; 202521–202523 unavailable outcomes are preserved as missing, not zero.
- Census survey microdata are confidential and may not be reproduced from public aggregate releases alone. This archive does not contain respondent-level records.
- The original vintage of every historical aggregate observation has not been independently audited.

## 3. Historical manuscript in prior Git commits

An earlier manuscript text extraction was committed and subsequently removed from the current `main` branch. The earlier commits remain reachable through repository history. Neither deleting a file nor updating `.gitignore` erases that history.

Official documentation: [GitHub: Removing sensitive data from a repository](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/removing-sensitive-data-from-a-repository).

Two alternatives:

**Option A — Clean new repository (recommended if a history-free archive is essential).**
Create a new repository, populate it *only with files from the vetted release candidate*, verify its file inventory, then archive the clean repository in Zenodo when the code/data scope and citation are settled. A fresh import must not copy the old Git history. The old GitHub repository remains separately accessible unless its owner later deletes or otherwise remediates it. Creating a new repository does not erase earlier manuscript commits from the old repository.

**Option B — Rewrite the existing repository history (higher risk).**
The repository owner may use `git-filter-repo` on a fresh local clone with the **confirmed exact old manuscript path(s)**, verify the rewritten history, and force-push appropriately. This changes commit hashes, may affect branches, pull requests, collaborators and existing links, and may not remove all copies/caches/forks. GitHub Support assistance is limited in scope. Do not execute this without a backup, exact file-path inventory, and the owner's explicit approval.

**No history rewriting, force-push, repository deletion, or new repository creation was performed by this review.**

## 4. Licensing

The repository currently declares no software license. Until an explicit license is granted, other users generally do not have an open-source grant to copy, modify, and redistribute the author's code.

A possible later option is to license **author-created R code and documentation only** under an appropriate open-source license, explicitly excluding third-party data. A license file should be added only after author approval. The legal status of public Census aggregates and additional macroeconomic data fields must be addressed separately.

## 5. Release gate decision

**Hold the final v1.0.0/Zenodo DOI.** A scoped code/data artifact can be prepared now, but before publication:
1. Confirm the public/nonconfidential status, source citations, and redistribution terms for **each** non-Census column.
2. Decide whether to preserve the current GitHub repository/history or use a new, clean archive repository.
3. Choose the intended software license separately from third-party dataset permissions.
4. Audit the final tree for manuscript and image files and review the historical manuscript exposure risk.
5. Preserve the existing numerical verification boundaries: author-run reproducibility from the archived processed panel; **not** independent raw-source or prospective reproduction.

This review is evidence-based documentation, not a certification of legal rights or a claim that release conditions have been completed.
