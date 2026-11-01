# Computed results

Actual outputs generated on Windows with R 4.4.2, survival 3.7-0. See artifacts/sessionInfo.txt for exact package environment. No patient observations were excluded by this pipeline.

- Patients 686; events 299; censored 387. Median observed follow-up 1084 days (not median survival).
- KM at day 365: .915558, log-log 95% CI .891677–.934369, risk set 602.
- Day 1095: .642620, CI .603302–.679123, risk 333.
- Day 1825: .491645, CI .445797–.535814, risk 123.
- Exploratory log-rank p-values: hormonal therapy .003427; menopausal status .596577; grade .00002627. No multiplicity adjustment or causal interpretation.

| Prespecified Cox contrast | HR | 95% CI |
|---|---:|---:|
| Age per 10 years | 1.0005 | .8898–1.1249 |
| Tumor size per 10 mm | 1.0409 | .9651–1.1227 |
| Grade II vs I | 2.0989 | 1.2936–3.4056 |
| Grade III vs I | 2.6243 | 1.5675–4.3934 |
| Doubling nodes + 1 | 1.5614 | 1.3951–1.7476 |
| Hormonal therapy vs none | .6856 | .5330–.8819 |

Primary PH tests: age p=.003986; grade p=.003541; global p=.002154. Constant HR interpretations are limited. Grade stratification leaves age p=.007149 even though global p=.092871; it is a sensitivity, not full resolution. Covariance condition number 68.03; 49.83 events per fitted coefficient. These diagnostics do not establish validation.

New baseline simulation: coverage .9480 normal, .9585 log-log; MCSE .004965/.004460. Mean widths .203895/.202953. B=2000; no undefined or unsupported baseline intervals. Sample-size n=25 scenario: normal .9185 versus log-log .9505, with 19 raw normal boundary violations. Scenario CSV contains all 14 protocol rows × two methods. The experimental scenarios cannot establish universal superiority.

Historical coursework reported .9450/.9485; source code and seed were not provided. Differences are recorded rather than forced to match. Simulation truth exp(−.5)=.6065307 and theoretical censoring 1/3 are distinct from clinical survival estimates.
