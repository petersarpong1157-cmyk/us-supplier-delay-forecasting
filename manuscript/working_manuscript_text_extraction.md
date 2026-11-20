# Manuscript — readable text extraction

> This Markdown file is an accessibility copy extracted from the Phase 26 Word manuscript. Formatting, page breaks, equations, and embedded exhibits may not be faithfully reproduced. The original DOCX is the authoritative editable document and is not uploaded here.

<PARSED TEXT FOR PAGE: 1 / 27>
  Predicting Supplier Delivery-Time Disruptions Across
                                          U.S. Industries
                    Input-Price Dynamics, Machine Learning, and Forecast Reliability

                                               Peter Sarpong
Independent Researcher

Gaithersburg, Maryland, USA

Email: peter.sarpong1157@gmail.com

Working research manuscript • November 2026

Target journal and data/code availability statements require author review before submission.



Abstract
Supplier delivery-time disruptions matter for procurement and operational planning, yet models that
improve average predictive accuracy may fail to improve forecasts during elevated supply-chain
stress. This study combines historical panel associations and exploratory machine-learning forecasts
using industry-level U.S. Census Bureau Business Trends and Outlook Survey (BTOS) estimates from
2023–2026. In a 15-industry fixed-effects sample, the sum of coefficients on three lagged input-price
indicators is 0.1287 (SE 0.0281; approximate 95% interval 0.0685–0.1889). The sign remains positive
across 15 leave-one-industry-out and four leave-one-calendar-year-out specifications. A corrected
publication-date-restricted backtest evaluates 20 forecast origins and 300 matched forecasts for each
model. Random forest produces an MAE of 1.1645 percentage points, compared with 1.2773 for
persistence and 1.7944 for Ridge regression, yielding an 8.83% improvement relative to persistence
(paired origin-resampled 95% interval for the absolute gain: 0.0121–0.2044 percentage points). Among
35 observations with realized supplier-delay rates of at least 15%, however, the random forest MAE
advantage is not established and its average underprediction exceeds that of persistence. Results
remain exploratory owing to retrospective industry selection, repeated testing, vintage limitations,
and outcome-defined subgroup analysis.

Keywords: supplier delivery times; input prices; BTOS; production networks; random forest;
historical forecasting; calibration; operational resilience.



1. Introduction
Supply-chain resilience depends partly on anticipating interruptions before they compromise
purchasing decisions, inventory buffers, and production schedules. Delays and input-price pressure
can occur together when common upstream disturbances affect sourcing, freight capacity, or the
distribution of scarce inputs. Their joint movement motivates empirical study, but does not itself
identify causal supply-chain propagation. Production-network research establishes how firm-to-firm
linkages can connect sectoral shocks to broader fluctuations (Acemoglu et al., 2012; Carvalho and
Tahbaz-Salehi, 2019).


                        RESEARCH MANUSCRIPT DRAFT • 20 NOVEMBER 2026 • NOT SUBMISSION-READY
<PARSED TEXT FOR PAGE: 2 / 27>
Predictive models should be evaluated not only by in-sample fit or overall mean errors, but by
whether they improve on realistic benchmarks at historically feasible decision dates. This study
therefore integrates industry-panel associations, an expanding-window forecasting comparison, and
retrospective error diagnostics for unusually elevated reported supplier-delay rates. The contribution
is an evidence-based contrast between average forecast gains and conditional reliability, together
with a documented correction to a historical survey release date.

Three research questions guide the analysis: whether preceding input-price indicators are associated
with later supplier-delay reports after controlling for persistence and shared reporting-period
conditions; whether nonlinear random forest improves historical predictive accuracy over
persistence and a fixed-penalty linear comparator; and whether any overall improvement extends to
periods with elevated realized supplier-delay rates.



2. Background and related literature

2.1 Production-network shocks and delivery outcomes
Production-network models emphasize the possibility that disturbances at selected upstream
suppliers can affect downstream performance through input-output relationships (Acemoglu et al.,
2012). Carvalho and Tahbaz-Salehi (2019) review mechanisms governing transmission through
production networks. These frameworks motivate examination of covariation between price pressure
and delivery delays, but the present industry-level data cannot identify firm-to-firm network paths or
isolate the direction of transmission.

2.2 Supply-chain forecasting and operational interpretation
Operational-risk forecasting has used simulation and analytical tools to explore how disruptions
interact with network structure and response policies. Ivanov (2020), for example, studies outbreak-
related supply-chain impacts using simulation. The present analysis differs in relying on repeated
nationally reported industry survey estimates. The outcome is the percentage of businesses reporting
increased supplier delivery times, not the physical duration of a shipment delay.

2.3 Predictive accuracy, baseline comparison and uncertainty
Random forest averages predictions from randomized collections of decision trees and can
accommodate nonlinear relationships (Breiman, 2001). Comparing a flexible model with persistence
prevents overstating improvement that is already supplied by temporal autocorrelation. Hyndman
and Koehler (2006) explain accuracy-measurement considerations, while Diebold and Mariano (1995)
motivate paired forecast comparison. The present bootstrap resamples entire forecast origins; it is
exploratory and is not presented as a formal Diebold–Mariano test.

2.4 Direct evidence from the BTOS and survey-based business indicators
The BTOS was developed to provide high-frequency, geographically and industrially detailed
measures of business conditions and expectations. Buffington, Foster, and Shevlin (2023) explain its
role in supplementing less frequent business statistics and emphasize the distinction between
categorical business responses and derived diffusion measures. The present study uses the published
percentage selecting the “increased” response for two current-condition items, rather than a diffusion


                      RESEARCH MANUSCRIPT DRAFT • 20 NOVEMBER 2026 • NOT SUBMISSION-READY
<PARSED TEXT FOR PAGE: 3 / 27>
index combining increased, unchanged, and decreased responses. This distinction matters: a 10%
share of businesses reporting longer supplier delivery times does not mean that delivery times
increased by 10%, and it is not itself a direct estimate of the number of delay days.

Recent evidence provides a more direct comparison between BTOS indicators and other measures of
manufacturing activity. Bhamidi, Hoffmann, and Kamal (2026) compare manufacturing BTOS
diffusion indices with corresponding Institute for Supply Management and S&P Global measures and
document strong contemporaneous co-movement for input prices and supplier delivery times. Their
work demonstrates the value of industrial detail and cautions against interpreting industry
aggregates as homogeneous. It differs from the present study in focusing on manufacturing validation
and contemporaneous indicator comparison, whereas the present analysis considers multiple sectors
and publication-date-constrained subsequent-period forecasts. Their reported correlations apply to
diffusion indices and should not be treated as estimates for our response-share outcome.

An important contribution of the BTOS literature is clarity about the sampling frame and timing. The
Census Bureau describes a stratified rotating sample of employer businesses, with six biweekly
panels and a recurring 12-week contact cycle. After the September 2023 redesign, coverage includes
both single-location and multi-location employer businesses other than farms. Our analytical period
begins after this principal frame expansion, although the research does not establish complete
invariance of questionnaire wording, response composition, or sector-specific representativeness.
The present unit is the published industry-period aggregate, not a business-level observation.

2.5 From historical association to forecast evaluation
Production-network theory offers a plausible motivation for joint movement in supplier delivery
difficulties and input costs, but neither the network mechanisms described by Acemoglu et al. (2012)
nor the broader framework reviewed by Carvalho and Tahbaz-Salehi (2019) is directly identified by
the two published survey response shares. Demand shocks, international transportation conditions,
policy changes, upstream shortages, and general uncertainty can move both variables. Fixed effects
and lagged outcomes help describe conditional associations but do not create an exogenous source of
variation. Accordingly, the distributed-lag coefficient sum is an empirical conditional association, not
a structural pass-through rate.

The forecasting literature motivates a second, conceptually different question: whether the
information adds value for predictions made at actual decision dates. Breiman (2001) provides the
foundation for random forest as a nonlinear prediction procedure. Hyndman and Koehler (2006)
emphasize the importance of clearly defined accuracy measures and appropriate baselines, while
Diebold and Mariano (1995) formalize comparisons of predictive loss. Our design uses the paired
absolute-error difference and resamples entire forecast origins because 15 industry outcomes share
each origin. This bootstrap is a descriptive uncertainty assessment, not a formal Diebold–Mariano test
or prospective statistical validation.

Finally, operational consequences are not symmetric across states of the world. Ivanov (2020) uses
simulation to investigate disruption propagation and adaptation under epidemic shocks; its
contribution is mechanistic and scenario-based rather than a direct comparison of BTOS industry-
period prediction errors. Our retrospectively defined high-outcome band supplies a diagnostic of
conditional error and underprediction, but it is neither a prospective warning classification nor a

                       RESEARCH MANUSCRIPT DRAFT • 20 NOVEMBER 2026 • NOT SUBMISSION-READY
<PARSED TEXT FOR PAGE: 4 / 27>
validated loss function for procurement decisions. Future evaluations should pre-specify business-
specific asymmetric losses and independently collected forecast targets.

2.6 Distinct contribution and scope of inference
Relative to this literature, this study integrates three elements in one industry-period workflow: (i)
fixed-effects and distributed-lag descriptions of input-price and supplier-delivery measures, (ii)
publication-date-restricted comparisons with a strong persistence benchmark and a specified fixed-
penalty Ridge comparator, and (iii) outcome-conditioned accuracy diagnostics combined with a
source-release metadata audit. The additional audit matters because the Census Bureau delayed the
release of BTOS period 202520; correcting its historical availability changed fitted model predictions
but left the aggregate ranking broadly intact. The work offers exploratory evidence of forecasting
value, not evidence of causal transmission, firm-level decision improvement, or prospective early-
warning deployment.



3. Data and empirical design

3.1 Survey source, population and variable definitions
The U.S. Census Bureau BTOS provides repeated industry-level indicators for U.S. employer
businesses. The analytical panel focuses on 15 high-coverage two-digit industry codes: 23, 31, 42, 44,
48, 51, 52, 53, 54, 56, 61, 62, 71, 72 and 81. These observations must not be described as an exclusively
small- and medium-enterprise cohort. Two percentages are central: businesses reporting increased
supplier delivery times, and businesses reporting increased prices paid for inputs. Neither is a
shipment-duration measure, an average inflation rate, or a business-level binary label.

The selected panel includes 1,245 industry-period records over 83 sequential biweekly reference
positions, of which 1,200 records contain the principal variables. The dataset documents distinct
reference windows, collection windows and publication dates. The collection start is exactly 14 days
after the reference start in all 83 positions, and all 80 recorded publication dates follow collection-
period endings.

3.2 Structural missingness and publication-date correction
BTOS periods 202521–202523 have invalid principal variables in all 15 selected industries (45 rows)
and no recorded publication dates. The Census Bureau attributes the absent collection to the October–
November 2025 federal funding lapse. The first subsequent observed collection interval begins
November 17, 2025. The missing rows remain unfilled rather than being coded as zero (U.S. Census
Bureau, 2026).

An original archive assigned period 202520 the scheduled October 9, 2025 publication date, although
the official actual release occurred November 20, 2025. This discrepancy was corrected in a separate
copy of the source dataset. The revised historical forecasting exercise was rerun without changing
model specifications or evaluated targets. The change affects the recorded information cutoff but does
not by itself establish full historical-vintage fidelity.




                       RESEARCH MANUSCRIPT DRAFT • 20 NOVEMBER 2026 • NOT SUBMISSION-READY
<PARSED TEXT FOR PAGE: 5 / 27>
3.3 Main estimation sample
The distributed-lag fixed-effects comparison uses 1,110 complete-case observations across 15
industries and 74 observed reporting periods. The lag model includes an industry-specific lagged
supplier-delay indicator, three lags of input-price reporting, industry fixed effects, and reporting-
period fixed effects. Reported uncertainty uses two-way industry/period cluster-robust standard
errors. With only 15 industry clusters, finite-cluster inference remains a limitation.

3.4 Econometric specification
Conceptually, the distributed-lag specification is: delay[s,t] = alpha[s] + gamma[t] + rho × delay[s,t−1]
+ beta1 × price[s,t−1] + beta2 × price[s,t−2] + beta3 × price[s,t−3] + error[s,t]. The cumulative input-
price association is beta1 + beta2 + beta3. Observations are ordered by biweekly survey position
rather than treated as days, and gaps in available survey outcomes are preserved as missing values.
This is a predictive association, not an identified causal response.

An alternative parsimonious specification replaces the three individual price lags with their three-
period mean. Supplementary analyses exclude one industry or calendar year at a time. Such
robustness checks evaluate coefficient stability; they do not eliminate endogeneity, omitted variables
or dynamic-panel bias.

3.5 Historical forecast protocol
The exploratory backtest uses 20 recent historical publication-date origins, 15 industries, and 300
matched targets per method. For each origin, historical predictors and training targets must have
recorded publication dates not later than that origin. Each target begins strictly after the origin.
Inputs include the most recently published supplier-delay estimate, a mean of three recent published
input-price observations, and industry identity. The forest uses 300 trees, mtry = 2 and minimum
node size 10; the Ridge comparison uses a fixed lambda of 5. Persistence carries forward the last
published supplier-delay estimate.

Training expands through the available historical releases. The 15-industry cohort was selected
retrospectively and the same periods were studied in earlier development phases. Consequently,
forecast accuracy estimates are not represented as independent out-of-sample confirmation. The
archive reconstructs 1,125 historical predictor records and recorded publication-date checks, but
historical releases were not independently re-downloaded at each original vintage.

3.6 Accuracy, resampling and observed-severity diagnostics
Accuracy is assessed by mean absolute error (MAE), root mean square error (RMSE) and mean signed
error (bias), all in percentage points of the reported business share. For paired model comparisons, a
positive gain is defined as persistence MAE minus candidate MAE. The evaluation resamples entire
forecast origins with replacement 5,000 times, retaining the within-origin industry dependence.
Because a limited number of origins is resampled after model development, intervals are best treated
as descriptive/exploratory.

The realized-outcome diagnostics divide targets into four bands: below 5%, 5–10%, 10–15%, and 15%
or above. These bands use observed future outcomes and cannot serve as prospective alert groups
available at the forecast origin. The highest observed band has only 35 targets from manufacturing
and wholesale trade.

                       RESEARCH MANUSCRIPT DRAFT • 20 NOVEMBER 2026 • NOT SUBMISSION-READY
<PARSED TEXT FOR PAGE: 6 / 27>
3.7 Historical questionnaire comparability and outcome harmonization
The Census Bureau reported that the February 29, 2024 BTOS publication introduced updated data
that include multiunit/multilocation businesses. This provides an additional source of potential
discontinuity that must be distinguished from item-wording comparability. The study begins with
September 2023 BTOS sector estimates and should avoid assuming that sample representation,
weighting, and estimation denominators were constant through this transition. A population and
estimator break, if present, could affect both time-series patterns and the interpretation of industry
and period effects (U.S. Census Bureau, 2024 press release).

The two outcome variables are derived from BTOS current-conditions questions that ask businesses
about changes during a specified preceding two-week reference interval. The supplier variable
records the published share responding “Increased” to the question about time to receive deliveries
from suppliers; the input-price variable records the share responding “Increased” to the question
about prices paid for goods or services. These two series must not be confused with expectations for
the next six months, with changes in delivery days or transaction prices, or with a 0–100 diffusion
index. For longitudinal analysis, matching must use item semantics, time horizon, response category,
and published estimate type, never the positional question number alone.

The historical item audit now includes official Census questionnaire copies for the 2023 Version 2
core/supplement, the November 2024 Version 3 work-from-home cycle, the July 2025 Version 4 AI
cycle, and two 2026 instruments. Across the inspected 2023–2026 versions, the current-condition
supplier-delivery and prices-paid items use a two-week reference window and the response category
“Increased”; supplier deliveries permit “Not applicable.” Question positions change across versions
without an observed change in the targeted core constructs. This is evidence of conceptual item
stability in inspected instruments, not proof of invariant statistical denominators, question routing,
business population, or weights across all survey cycles. U.S. Census Bureau (2023, 2024, 2025, 2026b,
2026c).

A complete question-by-question comparison for every 2023, 2024, and 2025 fielded instrument has
not been documented in the evidence available for this manuscript revision. The Census Bureau
cautions that questionnaire wording has changed over time. Therefore this paper cannot assert that
all 83 archived positions have identical question wording or that no methodological changes affected
these individual response shares. The remaining comparison should be treated as an unresolved
instrument-version audit, with each historical fielding interval linked to its actual questionnaire and
statistical metadata. We retain an explicit qualification in interpreting interannual differences.

3.8 Sample construction, denominators, and source metadata
The selected panel contains 83 nominal biweekly reporting positions and 15 industries, giving 1,245
industry-position cells. Forty-five cells have unavailable current-condition estimates in periods
202521–202523, leaving 1,200 valid cells for both primary outcomes. Those three positions correspond
to a documented government funding-lapse interruption, and no values are imputed. The industry
selection is retrospective and excludes sectors with weaker series coverage; it should not be
presented as a nationally representative cross-sector subset chosen before observing the data. The
published survey estimators carry year-varying standard errors, with median supplier-delay
standard errors of 0.61, 0.61, 0.70, and 0.82 in 2023–2026, respectively, and corresponding input-price


                      RESEARCH MANUSCRIPT DRAFT • 20 NOVEMBER 2026 • NOT SUBMISSION-READY
<PARSED TEXT FOR PAGE: 7 / 27>
standard errors of 1.17, 1.25, 1.43, and 1.56. These are descriptive standard errors and are not
incorporated into the principal unweighted regressions or the paired forecast bootstrap.

Published sector aggregates and response-share denominators require special care. A respondent
selecting “Not applicable” for delivery-time changes may affect the estimated share and the analysis
population depending on the Census tabulation rules. Without independently documenting the
denominator and response-treatment definitions in each historical download, equivalence of
percentages across all periods is not fully verified. This is a limitation of the present secondary-data
design rather than evidence that the questionnaire series is unusable.

3.9 Historical release audit and limits of verification
The official BTOS methodology identifies periods 202521–202523 as unavailable following the
October–November 2025 federal funding lapse and records that period 202520 was published
November 20, 2025 rather than the previously scheduled October 9 date. We corrected that date in a
separate panel and reran the forecasting workflow without changing its model settings. Across the 83
period positions, 80 have recorded release dates and three are structurally missing. Our earlier
archived predictor audit reconstructed 1,125 feature rows against the stored release metadata, but
full original-release vintage parity and the complete set of independently verified historical release
dates remain unconfirmed. The revised analyses are therefore publication-date-restricted historical
backtests, not established real-time vintage evaluations.



4. Results

4.1 Descriptive coverage and measurement
Data coverage is concentrated in 15 high-coverage industries. The selected-sector panel has 1,245
rows, of which 45 are structurally invalid during the 2025 collection interruption. Median reported
supplier-delay standard errors rose from 0.61 in 2023 to 0.82 in 2026; corresponding input-price
standard errors rose from 1.17 to 1.56. Such changes describe variation in reported sampling
uncertainty and should not be interpreted as proof of deteriorating survey quality. The main models
do not explicitly propagate that survey-estimation variance.

4.2 Persistence and industry/time effects
The high-coverage industry fixed-effects specification produces an estimate of 0.5233 on lagged
supplier delays and 0.0560 on lagged input prices. Including reporting-period fixed effects yields
corresponding coefficients of 0.4118 and 0.0882. These associations motivate the richer distributed-lag
specification, but the two alternative controls sets should not be conflated.

4.3 Distributed input-price association
The three lagged price coefficients in the complete-case industry-and-period fixed-effects model are
0.0156, 0.0359 and 0.0772, with a cumulative coefficient of 0.1287 (SE 0.0281). An approximate 95%
interval for the cumulative effect is 0.0685–0.1889. The lag-average model produces a coefficient of
0.1296 (SE 0.0282). The original price-lag joint Wald comparison gave F(3, 14) = 8.76 and p = 0.0016,
subject to the small number of industry clusters.



                        RESEARCH MANUSCRIPT DRAFT • 20 NOVEMBER 2026 • NOT SUBMISSION-READY
<PARSED TEXT FOR PAGE: 8 / 27>
Lagged inputs are strongly correlated; consequently the cumulative association is more interpretable
than a literal causal propagation lag for any single price coefficient. All 15 leave-one-industry-out
estimates remain positive (range approximately 0.1163–0.1588), as do the four leave-one-calendar-
year-out estimates (approximately 0.1022–0.1606).

4.4 Corrected historical forecasting performance
In the corrected 300-target matched evaluation, random forest has MAE 1.1645 and RMSE 1.5221,
persistence MAE 1.2773 and RMSE 1.6300, and fixed-penalty Ridge MAE 1.7944 and RMSE 2.4383. The
random forest advantage is 0.1128 percentage points, an 8.83% MAE reduction relative to persistence.
Across 20 forecast origins, random forest has lower origin-level MAE at 16. An exploratory paired
origin-bootstrap 95% interval for its improvement is 0.0121–0.2044 percentage points; the Ridge
minus persistence advantage is negative (−0.5171; interval −0.6385 to −0.3949).

4.5 Reliability in the elevated realized-outcome band
For the 35 targets with observed supplier-delay reporting at least 15%, random forest has MAE 2.2795,
compared with 2.2743 for persistence. The random forest improvement is −0.0052 percentage points
(95% exploratory bootstrap interval −0.4178 to 0.3918). Its signed bias is −1.9454 compared with
−0.9257 for persistence and −5.2738 for Ridge. Thus the overall random forest advantage does not
carry through as an established severe-group MAE gain. The manufacturing severe-group advantage
is −0.332, while the wholesale-trade advantage is +0.303; these subgroup findings are based on just 17
and 18 targets, respectively.

4.6 Information provenance and sensitivity to release metadata
The archived reconstruction audit records 1,125 of 1,125 feature records with reconstructed historical
last-delay and three-price-average inputs, target ordering, and publication-date checks. When the
release date for period 202520 was corrected from October 9 to November 20, 2025, all 300 random
forest predictions and all 300 Ridge predictions changed while persistence predictions did not. The
random forest MAE decreased slightly from 1.1666 to 1.1645, preserving the model ranking. This
demonstrates metadata sensitivity of individual forecasts without independent certification of
vintage source values.



5. Discussion
The two analytical components answer complementary questions. The panel findings provide
evidence that input-price pressure and subsequently reported supplier delivery-time increases move
together after controls for lagged outcomes and common time effects. They do not identify a
structural price-to-delay effect. The forecasting findings instead ask whether a specified modeling
workflow predicts later survey outcomes more accurately than simple alternatives at the historical
information cutoffs supplied by the archive.

Random forest improves average forecast accuracy modestly, but its stronger mean performance
does not establish superior reliability during elevated realized disruption. The outcome-defined
severe subgroup has limited sample size, a restricted industry composition, and pronounced negative
bias in the nonlinear forecasts. In risk-management applications, underprediction during stressful
conditions may create asymmetric operational costs, which symmetric MAE alone does not capture.

                      RESEARCH MANUSCRIPT DRAFT • 20 NOVEMBER 2026 • NOT SUBMISSION-READY
<PARSED TEXT FOR PAGE: 9 / 27>
The comparison also does not isolate the benefit of input-price inputs: the random forest and its fixed-
penalty comparator differ in functional form, and there is no fully paired, pre-specified same-model
ablation holding every other element constant. Further model development on these same evaluated
origins would risk additional researcher degrees of freedom. A prospective or previously untouched-
window ablation would offer a more credible test.

Survey-based percentages should not be interpreted as the average number of delay days or as
directly observed inventory shortages. Sector selection and the distinction between release-vintage
data and corrected later archives further constrain interpretation. Additionally, the 2025 interruption
means the nominally regular survey-position calendar contains positions with no collected outcomes.
The metadata correction highlights the value of documenting actual rather than scheduled
publication dates.



6. Conclusion
Across 15 U.S. industries, the share of businesses reporting higher input prices is positively associated
with subsequent reported supplier delivery-time increases. A publication-date-restricted historical
backtest shows that random forest modestly reduces average errors relative to persistence after
correction of a delayed Census release date, but does not establish an improvement for the highest
observed supplier-delay group. The results support careful use of nonlinear forecasts as
supplementary operational decision tools while underscoring the need for stronger prospective
validation, survey-vintage reconstruction, and explicit monitoring of underprediction in adverse
conditions.



Declarations

Funding
The author received no financial support for the research, authorship, or publication of this article.

Declaration of competing interests
The author declares no competing financial or non-financial interests.



References
Acemoglu, D., Carvalho, V. M., Ozdaglar, A., & Tahbaz-Salehi, A. (2012). The network origins of
aggregate fluctuations. Econometrica, 80(5), 1977–2016. https://doi.org/10.3982/ECTA9623

Breiman, L. (2001). Random forests. Machine Learning, 45, 5–32.
https://doi.org/10.1023/A:1010933404324

Carvalho, V. M., & Tahbaz-Salehi, A. (2019). Production networks: A primer. Annual Review of
Economics, 11, 635–663. https://doi.org/10.1146/annurev-economics-080218-030212

Diebold, F. X., & Mariano, R. S. (1995). Comparing predictive accuracy. Journal of Business & Economic
Statistics, 13(3), 253–263. https://doi.org/10.1080/07350015.1995.10524599



                      RESEARCH MANUSCRIPT DRAFT • 20 NOVEMBER 2026 • NOT SUBMISSION-READY
<PARSED TEXT FOR PAGE: 10 / 27>
Hyndman, R. J., & Koehler, A. B. (2006). Another look at measures of forecast accuracy. International
Journal of Forecasting, 22(4), 679–688. https://doi.org/10.1016/j.ijforecast.2006.03.001

Ivanov, D. (2020). Predicting the impacts of epidemic outbreaks on global supply chains: A simulation-
based analysis on the coronavirus outbreak (COVID-19/SARS-CoV-2) case. Transportation Research
Part E: Logistics and Transportation Review, 136, 101922. https://doi.org/10.1016/j.tre.2020.101922

U.S. Census Bureau. Business Trends and Outlook Survey: Program information and data downloads.
https://www.census.gov/programs-surveys/btos.html

Bhamidi, A., Hoffmann, N., & Kamal, F. (2026, October 1). Beyond aggregates: Measuring
manufacturing subsector heterogeneity with the Business Trends and Outlook Survey. FEDS Notes.
Board of Governors of the Federal Reserve System. https://doi.org/10.17016/2380-7172.4178

Buffington, C., Foster, L., & Shevlin, C. (2023). Measuring business trends and outlook through a new
survey. AEA Papers and Proceedings, 113, 140–144. https://doi.org/10.1257/pandp.20231051

U.S. Census Bureau. (2026a). Business Trends and Outlook Survey methodology (Version 6).
https://www.census.gov/hfp/btos/downloads/methodology/Business_Trends_and_Outlook_Survey_Met
hodology_V6.pdf

U.S. Census Bureau. (2026b). Business Trends and Outlook Survey, Content Year 4/5 core
questionnaire, fielded February 9–October 18, 2026.
https://www.census.gov/hfp/btos/downloads/BTOS%20Content%20Y4%20Core%20Cycle%203%2C%20
4.pdf

U.S. Census Bureau. (2026c). Business Trends and Outlook Survey, Content Year 5 core and SI
instrument.
https://www.census.gov/hfp/btos/downloads/BTOS%20Content%20V5%20Core%20and%20SI%20Instr
ument%20-%20Cycle%202-Tagged.pdf

U.S. Census Bureau. (2026d). Business Trends and Outlook Survey: Data downloads and
documentation. https://www.census.gov/hfp/btos/data_downloads?so=1

U.S. Census Bureau. (2023). Business Trends and Outlook Survey: Core with supplemental content V2
for Cycle 2 (August 23, 2023).
https://www.census.gov/hfp/btos/downloads/BTOS%20Content%20V2%20Supplement%2011.29.2023_
Watermarked.pdf

U.S. Census Bureau. (2024a). Business Trends and Outlook Survey: Content V3, Cycle 2 with work-
from-home supplement (November 2024).
https://www.census.gov/hfp/btos/downloads/BTOSContentV311.20.24Cycle2WFHSupplement.pdf

U.S. Census Bureau. (2024b, February 29). Business Trends and Outlook Survey data release (CB24-
TPS.22). https://www.census.gov/newsroom/press-releases/2024/business-trends-outlook-survey-data-
feb29.html

U.S. Census Bureau. (2025). Business Trends and Outlook Survey: Content V4, Cycle 2 with AI
supplement (revised July 23, 2025).
https://www.census.gov/hfp/btos/downloads/BTOS%20Core%20and%20AI%20Content.pdf



                      RESEARCH MANUSCRIPT DRAFT • 20 NOVEMBER 2026 • NOT SUBMISSION-READY
<PARSED TEXT FOR PAGE: 11 / 27>
Tables and exhibits
Tables reproduce the uploaded evidence files with numerical precision retained. Table 1 covers all 19
available source industries; the main analytic cohort comprises the 15 higher-coverage codes listed in
Section 3.1. Tables 5–7 use corrected publication-date predictions. Units and flags should be
reconciled to the journal’s preferred style before submission.
Table 1. Survey-industry coverage in the archived sector panel.
 sector                                                              coverage pct
 11.000                                                              60.24
 21.000                                                              62.65
 22.000                                                              42.17
 23.000                                                              96.39
 31.000                                                              96.39
 42.000                                                              96.39
 44.000                                                              96.39
 48.000                                                              96.39
 51.000                                                              96.39
 52.000                                                              96.39
 53.000                                                              96.39
 54.000                                                              96.39
 55.000                                                              4.82
 56.000                                                              96.39
 61.000                                                              96.39
 62.000                                                              96.39
 71.000                                                              96.39
 72.000                                                              96.39
 81.000                                                              96.39




Table 2. Industry fixed-effects and industry-plus-period fixed-effects estimates.
 Estimate              Std. Error               t value              Pr(>|t|)                 variable             model
 0.5233                0.0565                   9.26                 0.0000                   delay_lag            Industry FE
 0.0560                0.0206                   2.72                 0.0166                   prices_lag           Industry FE
 0.4118                0.0854                   4.82                 0.0003                   delay_lag            Industry + Period FE
 0.0882                0.0233                   3.79                 0.0020                   prices_lag           Industry + Period FE




Table 3. Distributed-lag input-price estimates and three-period mean specification.
 specification              variable                      estimate                  standard error             observations
 Distributed lag            prices_l1                     0.01561                   0.02461                    1,110
 Distributed lag            prices_l2                     0.03587                   0.01832                    1,110
 Distributed lag            prices_l3                     0.07719                   0.02152                    1,110
 Distributed lag            Sum of price lags             0.12868                   0.02807                    1,110
 Average-price model        Three-period mean             0.12957                   0.02823                    1,110




Table 4. Leave-one-industry-out and leave-one-year-out sensitivity of cumulative price association.
 analysis              excluded                 observations         coefficient              standard error       p value
 Leave-one-
                       23                       1,036                0.1340                   0.0315               0.0010
 industry-out
 Leave-one-
                       31                       1,036                0.1163                   0.0243               0.0004
 industry-out
 Leave-one-
                       42                       1,036                0.1321                   0.0310               0.0009
 industry-out
 Leave-one-            44                       1,036                0.1278                   0.0296               0.0008



                            RESEARCH MANUSCRIPT DRAFT • 20 NOVEMBER 2026 • NOT SUBMISSION-READY
<PARSED TEXT FOR PAGE: 12 / 27>
 industry-out
 Leave-one-
                         48                    1,036                 0.1588                   0.0230                 0.0000
 industry-out
 Leave-one-
                         51                    1,036                 0.1237                   0.0274                 0.0006
 industry-out
 Leave-one-
                         52                    1,036                 0.1312                   0.0339                 0.0019
 industry-out
 Leave-one-
                         53                    1,036                 0.1277                   0.0287                 0.0007
 industry-out
 Leave-one-
                         54                    1,036                 0.1306                   0.0291                 0.0006
 industry-out
 Leave-one-
                         56                    1,036                 0.1287                   0.0301                 0.0009
 industry-out
 Leave-one-
                         61                    1,036                 0.1219                   0.0277                 0.0007
 industry-out
 Leave-one-
                         62                    1,036                 0.1268                   0.0283                 0.0006
 industry-out
 Leave-one-
                         71                    1,036                 0.1290                   0.0293                 0.0007
 industry-out
 Leave-one-
                         72                    1,036                 0.1332                   0.0295                 0.0006
 industry-out
 Leave-one-
                         81                    1,036                 0.1247                   0.0277                 0.0006
 industry-out
 Leave-one-year-out      2,023                 1,020                 0.1334                   0.0314                 0.0008
 Leave-one-year-out      2,024                 720                   0.1022                   0.0309                 0.0052
 Leave-one-year-out      2,025                 810                   0.1406                   0.0387                 0.0027
 Leave-one-year-out      2,026                 780                   0.1606                   0.0208                 0.0000




Table 5. Corrected historical forecast accuracy (percentage-point errors).
 model                        predictions                 MAE pp                  RMSE pp                        Bias pp
 Random forest                300                         1.1645                  1.5221                         -0.1794
 Persistence                  300                         1.2773                  1.6300                         -0.0733
 Ridge (fixed lambda=5)       300                         1.7944                  2.4383                         -0.4129




Table 6. Paired MAE advantage over persistence with 95% exploratory origin-bootstrap intervals
(percentage points).
 comparison                         estimate                         low                               high
 Random forest vs persistence       0.1128                           0.0121                            0.2044
 Ridge vs persistence               -0.5171                          -0.6385                           -0.3949
 Random forest: severe
                                    -0.0052                          -0.4178                           0.3918
 subgroup
 Random forest: below 15%           0.1284                           0.0245                            0.2275




Table 7. Calibration by retrospectively observed supplier-delay rates. Bias, MAE and RMSE in percentage
points.
                 disruption                                          mean
 model                              observations       mean actual                   Bias pp           MAE pp              RMSE pp
                 band                                                prediction
 Persistence     Below 5%           67                 3.84          4.45            0.610             1.106               1.479
 Persistence     5–10%              154                6.79          6.64            -0.156            1.129               1.435
 Persistence     10–15%             44                 12.15         12.00           -0.148            1.266               1.525
                 15% and
 Persistence                        35                 17.13         16.21           -0.926            2.274               2.568
                 above
 Random
                 Below 5%           67                 3.84          4.80            0.962             1.081               1.404
 forest
 Random          5–10%              154                6.79          6.51            -0.281            0.949               1.252


                              RESEARCH MANUSCRIPT DRAFT • 20 NOVEMBER 2026 • NOT SUBMISSION-READY
<PARSED TEXT FOR PAGE: 13 / 27>
 forest
 Random
                  10–15%              44         12.15         11.99          -0.159        1.157   1.307
 forest
 Random           15% and
                                      35         17.13         15.19          -1.945        2.280   2.653
 forest           above
 Ridge (fixed
                  Below 5%            67         3.84          5.67           1.832         1.833   2.068
 lambda=5)
 Ridge (fixed
                  5–10%               154        6.79          6.99           0.193         0.903   1.140
 lambda=5)
 Ridge (fixed
                  10–15%              44         12.15         10.06          -2.086        2.086   2.285
 lambda=5)
 Ridge (fixed     15% and
                                      35         17.13         11.86          -5.274        5.274   5.522
 lambda=5)        above




Table 8. Historical predictor provenance audit from the archived feature construction.
 Verification                                                  Count
 Historical feature records audited                            1,125
 Supplier-delay value matches                                  1,125
 Input-price mean matches                                      1,125
 Publication-date checks passed                                1,125
 Failed records                                                0




Figures




Figure 1. Industry-level supplier-delay trends.




                             RESEARCH MANUSCRIPT DRAFT • 20 NOVEMBER 2026 • NOT SUBMISSION-READY
<PARSED TEXT FOR PAGE: 14 / 27>
Figure 2. Input-price and supplier-delay survey patterns.




                      RESEARCH MANUSCRIPT DRAFT • 20 NOVEMBER 2026 • NOT SUBMISSION-READY
<PARSED TEXT FOR PAGE: 15 / 27>
Figure 4. Leave-one-industry-out cumulative estimates.




                      RESEARCH MANUSCRIPT DRAFT • 20 NOVEMBER 2026 • NOT SUBMISSION-READY
<PARSED TEXT FOR PAGE: 16 / 27>
Figure 5. Leave-one-year-out coefficient stability.




Figure 6. Corrected forecast errors across historical origins.




                       RESEARCH MANUSCRIPT DRAFT • 20 NOVEMBER 2026 • NOT SUBMISSION-READY
<PARSED TEXT FOR PAGE: 17 / 27>
Figure 7. Corrected observed versus predicted survey percentages.




Figure 8. Corrected forecast bias conditional on retrospectively observed severity.



Appendix 0. Questionnaire crosswalk and verification status
Documentary crosswalk (verified source exemplars; item positions and sample coverage are version-
specific). All entries refer to reported changes over a preceding two-week period, not measured
delivery days or price inflation magnitude.

 Version /            Delivery item          Prices-paid item       Response framing        Verification scope
 document

 V2, Aug 2023         Q7                     Q11                    Increased /             2023 exemplar
                                                                    decreased / no
                                                                    change; delivery
                                                                    has N/A


                      RESEARCH MANUSCRIPT DRAFT • 20 NOVEMBER 2026 • NOT SUBMISSION-READY
<PARSED TEXT FOR PAGE: 18 / 27>
 V3, Nov 2024         Q9                     Q13                    Same core               2024 WFH cycle
                                                                    options                 exemplar

 V4, Jul 2025         Q7                     Q11                    Same core               2025 AI cycle
                                                                    options                 exemplar

 Y4/5, Feb–Oct        Q8                     Q12                    Same core               2026 core
 2026                                                               options                 exemplar

 V5 later 2026        Q7                     Q11                    Same core               2026 core/SI
                                                                    options                 exemplar

Source-specific caution: the 2022 Version 1 design predates the study and lacks the “Not applicable”
option for the supplier-delivery item; it must not be used as proof of the 2023–2026 response
denominator. The expanded February 2024 release may also change population coverage
independently of questionnaire wording. Document coverage using published methodological and
historical-sector metadata before claiming full longitudinal equivalence.

2026 core instrument (fielded February 9–October 18): delivery-time item Q8; prices-paid item Q12.
Both ask about the preceding two-week interval and provide increased/decreased/no-change
categories. Supplier delivery additionally permits “Not applicable.” Official source: U.S. Census Bureau
(2026b).

Later 2026 core/SI instrument: delivery-time item Q7; prices-paid item Q11; same two-week current-
condition constructs and respective categorical response options. Official source: U.S. Census Bureau
(2026c). Question number change does not, by itself, indicate a measurement break.

Expanded documentary audit: the August 2023 V2, November 2024 V3, July 2025 V4, and two 2026
instrument copies have been inspected. These are exemplars, not a complete period-by-period
fielding history. Outstanding: link each of the 83 survey positions to its specific fielded instrument and
confirm published sector-estimate denominator, estimation weights, non-applicable handling, and
revisions.

The official Census methodology (Version 6) identifies three missing data-collection periods 202521–
202523 and the delayed release of 202520. Verify all other historical publication dates independently
before claiming full contemporaneous information availability.

Reference verification: The six foundational academic references were checked against their
journal/publisher DOI records; the BTOS measurement paper against its AEA record; the 2026
manufacturing validation note against the Federal Reserve; the methodology and both 2026
instruments against Census-hosted documents. The bibliography documents source existence and
bibliographic metadata, not that every research interpretation has been independently replicated.



Appendix A. Reproducibility and analysis definitions
Replication boundary. The supplied 21-file checksum archive confirms byte-for-byte preservation of
the named tables, figures, three forecasting scripts, the corrected input panel, and an R session report.
It does NOT include the complete econometric transformation scripts, original Census
response/estimate vintages, or a full release-calendar record. Thus, a fresh end-to-end independent


                      RESEARCH MANUSCRIPT DRAFT • 20 NOVEMBER 2026 • NOT SUBMISSION-READY
<PARSED TEXT FOR PAGE: 19 / 27>
reproduction cannot yet be certified. Figures 7 and 8 in the manuscript are generated from corrected
Phase 19 predictions rather than the superseded Phase 16 images.

Study period and target construction: industry-level BTOS reporting positions from 2023–2026, with
publication dates used as historical information cutoffs. Observed target reference starts strictly
follow the forecast origins. The 2025 structural gaps are not imputed. Record-level archived-source
checks passed for 1,125 audited prediction-feature rows. Release-date correction: period 202520
actual public release November 20, 2025, replacing the previously archived scheduled date of October
9, 2025.

Forecast parameter record: 15 industry codes; most recent published delay; three-observation mean
of most recently published input-price data; industry identity; 300-tree random forest with mtry=2
and minimum terminal node size 10; Ridge at fixed lambda 5; persistence baseline; 20 evaluated
origins and 300 matched targets/model; origin-resampled paired bootstrap 5,000 iterations, R seed
1906. Training expands using historically eligible archived targets. `age_days` was always zero in the
feature audit and is not a source of independent predictive information.

Evidence archive: Phase20_Final_Manuscript (user local filesystem). The supplied 21-item manifest
reported 21 source files archived with matching MD5 checksums. Figures 7–8 were subsequently
regenerated from corrected predictions; their corrected images are embedded in this manuscript. The
historical origin-by-origin Figure 6 was rebuilt from the corrected matched predictions in the
uploaded comparison file.



Appendix B. Limitations and final submission checks
   Confirm all 83 historical release dates against official Census release records, particularly near
    nonstandard publication intervals; corrected one identified discrepancy only.
   Question wording is now checked in selected official 2023, 2024, 2025, and 2026 instruments. Still
    unresolved: fielding-window mapping for all 83 periods, published estimate denominators and
    weights, and effects of the February 2024 expanded multi-location business release.
   Independent original-release vintage files are unavailable in the supplied archive; this cannot be
    claimed as a true real-time archived-vintage forecast.
   Provide all source scripts for Phase 15 econometrics and all transforms necessary to rebuild
    Tables 1–8; the 21-item checksum register did not cover every transformation script.
   Assess whether the regression exclusion choices and the 15-industry cohort were fixed prior to
    analysis, and disclose retrospective selection explicitly.
   Document finite industry-cluster limits and serially correlated distributed-lag predictors;
    interpret all coefficients associationally.
   Clarify any handling of suppressed/invalid survey values and the use (or nonuse) of survey
    reported standard errors in regression weights.
   Validate figure captions, author details, declarations and journal-specific citation style before
    submission.
   Prospective feature-ablation and new-window testing are recommended for future work and
    should not be fabricated into present results.



                       RESEARCH MANUSCRIPT DRAFT • 20 NOVEMBER 2026 • NOT SUBMISSION-READY
<PARSED TEXT FOR PAGE: 20 / 27>
Appendix C. Statistical interpretation and audit protocol

C.1 Survey outcome and scale
Let D(s,t) denote the Census BTOS share (in percentage points) of employer businesses in industry s
and survey period t reporting an increase in supplier delivery times. Let P(s,t) denote the
corresponding share reporting higher prices paid for inputs. These are shares of reporting businesses,
not days of delay or percentage changes in transaction prices. A one-percentage-point change in P(s,t)
is a one-point change in the share of businesses reporting the indicated condition. Regressions
describe conditional associations across repeated industry-survey cells; coefficients must not be
interpreted as an average causal effect for any firm.

C.2 Regression parameter interpretation
The primary distributed-lag equation is D(s,t) = industry effect + period effect + rho × D(s,t−1) + beta1
× P(s,t−1) + beta2 × P(s,t−2) + beta3 × P(s,t−3) + error. Its main summary, beta1 + beta2 + beta3, is
0.1287 (SE 0.0281). This is a sum of conditional regression coefficients. Because historical input-price
measures are strongly correlated, it should not be treated as a structural shock multiplier or
interpreted as the response to a lasting one-percentage-point price shock without further
assumptions. The displayed uncertainty uses the previously computed two-way industry/period
clustered covariance estimate; with only 15 industry clusters, normal approximations and nominal p-
values require caution.

C.3 Forecast loss and paired resampling
For each industry-origin forecast, error equals prediction minus realized reported share. Mean
absolute error averages the absolute errors, root mean squared error takes the square root of the
mean squared errors, and mean bias averages signed errors. Paired loss differences subtract model
absolute error from persistence absolute error on the same target. Bootstrap resampling selects
complete forecast origins with replacement, preserving all industry predictions within each sampled
origin. The resampled interval reflects uncertainty across the 20 historical origins under this design;
it is not a substitute for independent external validation and is not a formal prospective coverage
guarantee.

C.4 Missing periods and release-date protocol
Positions 202521–202523 are retained on the reference calendar with their outcome estimates
unavailable, not represented as zero. Reference-period starts precede collection-period starts by 14
days in every one of the 83 calendar positions. Forecast input eligibility is based on recorded public-
release dates, not simply reference or collection dates. For period 202520, the historically scheduled
October 9, 2025 date was replaced with the November 20, 2025 publication date, with the original
preserved. The corrected experiment reruns the same training protocol and evaluates the same 300
matched targets per model. Neither this correction nor the archived-predictor reconstruction
establishes independent reconstruction from every originally published survey vintage.

C.5 Conditional severe-outcome diagnostics
The 15% threshold refers to a realized share of businesses reporting longer supplier delivery times,
not a shipment-level extreme event or a measured national disruption severity threshold. The 35


                      RESEARCH MANUSCRIPT DRAFT • 20 NOVEMBER 2026 • NOT SUBMISSION-READY
<PARSED TEXT FOR PAGE: 21 / 27>
targets at or above that level arise from manufacturing and wholesale trade alone. Conditioning on
future observed values is useful for diagnosing error asymmetry but cannot identify which instances
would have been flagged prospectively using information available at the time of prediction. No
classification sensitivity, positive predictive value, or prospective alarm performance is claimed.

C.6 Remaining verification boundaries
The eight exhibit tables originate from phase-specific archived output files rather than newly
estimated coefficients in this document. The archive integrity evidence confirms bytewise copies but
does not itself certify data provenance, source-questionnaire equivalence, or model-code
completeness. Before submission, source scripts for every table and figure should be mapped to exact
source-data revisions, historical questionnaire changes should be checked against archived survey
instruments, and citation metadata should be independently reviewed. Data and code availability
statements must accurately describe the intended public repository and any restricted or third-party
source dependencies.




                       RESEARCH MANUSCRIPT DRAFT • 20 NOVEMBER 2026 • NOT SUBMISSION-READY
<PARSED TEXT FOR PAGE: 22 / 27>
Appendix D. Independent exhibit reconciliation and remaining replication boundaries
Audit conducted from the source CSV files supplied with the present research conversation. These
checks reproduce arithmetic and source-row alignment; they do not independently rerun the
underlying fixed-effects regressions from the original extraction code or verify every historical
Census vintage.

D.1 Reconciliation of analytic cohort and missing-period sample
The selected analytical cohort comprises 15 industries and 83 scheduled reference periods (1,245
industry-period positions). There are 1,200 nonmissing supplier-delay estimates and 45 unavailable
industry-period estimates, concentrated in BTOS periods 202521–202523. The complete-case
distributed-lag file contains 1,110 rows, or 74 periods for each industry. The nine excluded reference
positions are 202319, 202320, 202321, 202521, 202522, 202523, 202524, 202525, 202526. This consists of
the three opening positions, three unavailable positions during the 2025 interruption, and three
subsequent positions whose consecutive three-lag histories cross the interruption. Consecutive
calendar-reference lags must not be confused with previous nonmissing observations.

D.2 Direct lag and outcome cross-checks
For each of the 1,110 distributed-lag observations, the saved one-, two-, and three-period regressors
were compared with the archived panel values at precisely 14, 28, and 42 days before the reference
start, respectively. The observed outcome was compared against the archived same-period outcome.
No discrepancy was detected at the stored CSV numerical precision. This verifies the supplied lag-
sample transformations but is not a rerun of the model estimator.

 Check                     Records                      Matches                      Failures

 delay_l1 matches          1110                         1110                         0
 exact 14-day prior
 reference

 prices_l1 matches         1110                         1110                         0
 exact 14-day prior
 reference

 prices_l2 matches         1110                         1110                         0
 exact 28-day prior
 reference

 prices_l3 matches         1110                         1110                         0
 exact 42-day prior
 reference

 observed outcome          1110                         1110                         0
 equals archived 15-
 sector full-panel
 value




                      RESEARCH MANUSCRIPT DRAFT • 20 NOVEMBER 2026 • NOT SUBMISSION-READY
<PARSED TEXT FOR PAGE: 23 / 27>
D.3 Exhibit numerical reconciliation
The three separately stored price-lag coefficients sum to 0.12867665, compared with the recorded
cumulative effect of 0.12867665; the discrepancy (1.94e-16) is attributable to display precision. All 15
leave-one-industry-out and 4 leave-one-year-out coefficients in Table 4 are positive, spanning 0.1163–
0.1588 and 0.1022–0.1606, respectively.

Independent arithmetic recalculation from the 900 matched original-versus-corrected forecast rows
reproduces corrected MAE: random forest 1.164515, persistence 1.277333, and fixed-penalty Ridge
1.794405 percentage points. The recalculated random forest advantage is 0.112818 percentage points
(8.8323%). This verifies scoring arithmetic, not original model-fitting reproducibility.

D.4 Editorial audit — avoid overstating the evidence
   Label all regression outcomes as percentages of surveyed employer businesses reporting
    increases, not physical shipment delays, actual input price inflation rates, or small-business-only
    estimates.
   Explicitly identify the 1,110-row distributed-lag complete-case cohort and the three valid survey
    periods removed after the structural gap because of incomplete consecutive lag history.
   Treat the three-lag coefficient sum as a conditional, descriptive association and avoid interpreting
    it as causation or a directly identified cost-pass-through effect.
   Define severe observations by realized supplier-delay percentages (at least 15%), not as an
    advance-knowable high-disruption event classification.
   Keep the corrected period-202520 publication-date sensitivity and the unresolved possibility of
    revised historical data vintages visible; the corrected-date rerun is not a full original-vintage
    replication.
   Acknowledge that original econometric source scripts, all raw Census vintages, fully verified 83-
    position release metadata, and survey-weight/denominator harmonization have not been
    provided for independent complete reproduction.
   Tables 1–4 are reconciled to saved output records and lag-row checks, but model coefficients and
    standard errors have not been regenerated independently from a complete original R pipeline.
   The published 2024 multi-location survey population expansion remains a possible comparability
    break; matching instrument wording does not establish stable populations or denominators.
   Before selecting a journal, normalize titles, figure legends, cited source dates, declarations, and
    journal-specific length and reference style.

D.5 Audit files and scope
Supporting artifacts: phase23_row_level_lag_checks.csv, phase23_recomputed_metrics.csv, and
phase23_dataset_metadata.csv. Calculations use the supplied phase15_distributed_lag_sample.csv,
phase15_calendar_corrected_panel.csv, table3_input_price_models.csv, table4_sensitivity_results.csv,
phase19_matched_forecast_comparison.csv, and corrected BTOS sector panel. No additional
predictive model tuning was performed.




                      RESEARCH MANUSCRIPT DRAFT • 20 NOVEMBER 2026 • NOT SUBMISSION-READY
<PARSED TEXT FOR PAGE: 24 / 27>
Appendix E. Forecast-horizon eligibility and historical training composition
This appendix is a source-based technical audit of the corrected Phase 19 historical backtest. It uses
the archived forecast-information audit (1,125 industry-origin records), the corrected 900 prediction
records, and the released Phase 16 forecasting source script. It does not re-estimate the regression or
machine-learning models.

E.1 Target-horizon construction
The forecasting script first removes survey records with missing publication dates and then
constructs its target calendar from the remaining records. It selects the earliest eligible reference-
period start strictly after each forecast origin. During the 2025 BTOS collection interruption, this
procedure advances to the next available published observation, producing longer-than-usual
horizons for two historical forecast origins.

 Days to target reference start       Feature rows                           Origins

 11                                   1065                                   71

 12                                   30                                     2

 39                                   15                                     1

 53                                   15                                     1

The two longer-horizon origins are September 11, 2025 (53 days) and September 25, 2025 (39 days),
each contributing 15 industry-level feature rows. Both are assigned target period 202524, published
December 4, 2025.

E.2 Effect on the final evaluation and training samples
All 300 unique industry-origin targets in the final 20-origin evaluation begin 11 days after their
respective forecast origins. Thus, the reported 300-prediction-per-model comparison uses a common
11-day horizon. The longer-horizon records are not direct evaluation targets in Tables 5–7. However,
the 30 long-horizon examples had published outcomes by the first final evaluation origin, January 15,
2026, and therefore qualify for inclusion in the expanding model-training histories under the released
training filters.

Consequently, the headline forecast accuracy is directly comparable across final evaluation targets,
but the original fitting sample was not homogeneous in forecast horizon. A subsequent training-only
sensitivity run removed examples with horizons exceeding 14 days while preserving all 300 final
evaluation targets; results are reported in Appendix F.

E.3 Required disclosure and sensitivity
Suggested manuscript wording: “The evaluation targets were uniformly 11 days ahead of the
historical forecast origins. During an earlier interruption in BTOS data collection, the feature-
construction algorithm assigned the next available released survey outcome to two origins 39 and 53
days ahead. These 30 industry-origin examples may enter subsequent expanding training samples;
forecast estimates have not been separately tested for sensitivity to their exclusion.”

A controlled training-only sensitivity analysis was performed after the main corrected evaluation. It
excluded examples with target_start − origin > 14 days while preserving the final evaluation targets,

                       RESEARCH MANUSCRIPT DRAFT • 20 NOVEMBER 2026 • NOT SUBMISSION-READY
<PARSED TEXT FOR PAGE: 25 / 27>
model specifications, random seeds, and corrected release calendar. The experiment is a post hoc
robustness analysis, not an independent confirmatory test.

E.4 Audit boundaries
The inspection also confirms that the code selects the 15-industry cohort using availability computed
over the archived panel; therefore “pre-specified high-coverage cohort” in the script comment should
not be read as prospective selection. The age_days feature is zero throughout the archived features
and adds no cross-record signal. Neither observation establishes leakage on its own. Original-release
data-vintage fidelity and end-to-end independent re-estimation remain unverified.




                       RESEARCH MANUSCRIPT DRAFT • 20 NOVEMBER 2026 • NOT SUBMISSION-READY
<PARSED TEXT FOR PAGE: 26 / 27>
Appendix F. Training-horizon sensitivity and paired uncertainty
This appendix reports a post hoc training-sample sensitivity analysis of the corrected publication-
date-restricted historical backtest. The evaluation outcomes, forecast origins, industry cohort,
algorithm settings, and model labels remain fixed. Historical examples with target reference starts
more than 14 days after their corresponding forecast origins were excluded from training, and the
models were rerun. All numbers below come from the user’s Phase 24 Block A–B R outputs and
accompanying archived CSVs.

F.1. Matched evaluation design
Both experiments contain 900 model-level forecast rows: three competing models × 300 matched
industry-origin targets. Matching by origin, sector, target period, and model returned all 900 rows
with identical realized outcomes. The 300 test targets cover 20 release-date forecast origins across 15
industries. This is a sensitivity analysis on the already-examined evaluation set, not an independent
holdout.

F.2. Accuracy under the training-horizon restriction
 Model                 Original MAE           Restricted MAE         Restricted RMSE          Restricted bias

 Persistence           1.277333               1.277333               1.629990                 −0.073333

 Random forest         1.164515               1.154348               1.497171                 −0.100740

 Ridge (λ=5)           1.794405               1.785210               2.418305                 −0.379262

All loss values are percentage points of the industry-level share of businesses reporting increased
supplier delivery times. The random forest gain against persistence increases from 0.1128185 pp
(8.832345%) to 0.1229851 pp (9.628267%) in the restricted run. This post hoc difference is descriptive
and is not used to select a replacement primary model.

F.3. Prediction-level perturbation
Model                Changed / 300          Mean |Δ                 Max |Δ                   MAE gain
                                            prediction|             prediction|

Persistence          0                      0.000000                0.000000                 0.000000

Random forest        300                    0.126288                1.157177                 0.010167

Ridge (λ=5)          300                    0.036583                0.126262                 0.009195


F.4. Paired forecast-origin bootstrap
Model                      MAE gain                      2.5th percentile            97.5th percentile

Persistence                0.000000                      0.000000                    0.000000

Random forest              0.010167                      −0.009048                   0.029418

Ridge (λ=5)                0.009195                      0.005872                    0.012531

Gain is defined as MAE under the corrected main model minus MAE under the restricted model;
positive values favor exclusion of long-horizon training records. The percentile intervals were
obtained by sampling entire forecast origins with replacement (B = 5,000, R seed 2424), preserving the

                       RESEARCH MANUSCRIPT DRAFT • 20 NOVEMBER 2026 • NOT SUBMISSION-READY
<PARSED TEXT FOR PAGE: 27 / 27>
15-industry dependence within each resampled origin. The random forest interval includes zero.
Ridge’s interval is positive in this historical sample; because the sensitivity was specified after
examination of the test periods, it remains exploratory.

F.5. Implications and boundaries
The main random forest–persistence comparison is not driven by including the identified extended-
horizon records. On the other hand, all 300 random forest predictions shift under the restriction, and
the largest shift exceeds one percentage point. Thus, model outputs can be sensitive even when the
pooled loss metric is relatively stable. The main corrected Phase 19 results remain the primary
specification; the Phase 24 restriction is reported as a robustness test. No claims of prospective
accuracy, causal transmission, or independent vintage replication follow from these experiments.

F.6. Audit trail
Source outputs: Phase24_Horizon_Sensitivity/phase24_model_comparison.csv;
phase24_rf_gain_comparison.csv; phase24_prediction_changes.csv;
phase24_paired_sensitivity_intervals.csv. The final source scripts and input dataset should be
released alongside the manuscript, with relative paths, software versions, and the exact code edit
recorded. Results are conditional on the archived data and the repeated historical evaluation design.




                      RESEARCH MANUSCRIPT DRAFT • 20 NOVEMBER 2026 • NOT SUBMISSION-READY
