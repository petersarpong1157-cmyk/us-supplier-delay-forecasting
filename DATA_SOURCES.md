# Data sources and provenance

Primary source: U.S. Census Bureau **Business Trends and Outlook Survey (BTOS)** — https://www.census.gov/programs-surveys/btos.html

The analysis uses industry-level derived panel records covering 2023–2026. These are not original-release snapshots. Survey responses capture the proportion of businesses reporting increases in supplier delivery times or prices paid relative to the previous comparison period.

## 2025 interruption

BTOS reporting positions **202521–202523** contain unavailable estimates across the selected 15-industry cohort. The source analysis preserved these as missing, not zeros.

Survey period **202520** was assigned an earlier scheduled publication date in the assembled data; the corrected analysis uses **November 20, 2025** as the actual release date.

## Comparability cautions

Instrument question numbering changed; a historical questionnaire crosswalk found comparable question constructs in inspected versions, but full equivalence of denominators, sample frames, and estimator weights is not certified. The analytical cohort was selected retrospectively.

## Availability

The derived panel and original data-use conditions should be reviewed before redistribution. Independently obtaining official Census releases is preferred for complete replication.

## Release licensing and non-Census columns

The dataset includes non-BTOS/macroeconomic fields such as `gscpi_lagged_revised`, `ppi_level_lagged`, and `gscpi_vintage_selected`. These fields must not be represented as sourced solely from Census; their precise provenance and licensing/reuse terms require review before a blanket dataset license is applied. See [DATA_RIGHTS_AND_HISTORY_REVIEW.md](DATA_RIGHTS_AND_HISTORY_REVIEW.md) and the Census [data citation guidance](https://www.census.gov/about/policies/citation.html).

## License boundary (v4.0.9)

The repository's [MIT License](LICENSE) grants permission for the author's original research **software and associated author-created software documentation**. It does not establish a license for official Census data or third-party macroeconomic inputs, and must not be interpreted as author permission to sublicense datasets that the author does not own. Review the terms and provenance of the source data independently.
