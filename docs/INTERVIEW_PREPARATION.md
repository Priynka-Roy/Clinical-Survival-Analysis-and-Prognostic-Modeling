# Interview guide

## 30 seconds

SurvivalCare explores recurrence-free survival in a historical breast cancer dataset using R and Shiny. I combine Kaplan–Meier curves, uncertainty intervals, group comparisons and an explanatory Cox model with diagnostics, plus reproducible simulations that investigate confidence interval coverage. The analysis explicitly reports a proportional-hazards limitation and makes no individual treatment recommendations.

## 60 seconds

The clinical challenge is incomplete follow-up: a censored observation does not tell us when an event will occur. SurvivalCare uses 686 historical GBSG records and the composite endpoint recurrence or death. It estimates Kaplan–Meier survival with log-log intervals and risk counts, compares predefined groups, and fits a manageable Cox model. Diagnostics flag time-varying age and grade associations, which limits constant HR interpretation. A separate 2000-replicate baseline and fourteen scenarios test normal and log-log interval behavior. The original university coursework contributed the KM simulation foundation; the clinical analysis, diagnostics and Shiny application extend it. Tests check known mathematical examples and compare calculations against the survival package.

## Technical questions

**Why survival analysis rather than ordinary regression?** Follow-up varies and some event times are only known to exceed the last observation. Treating censored follow-up as actual event time biases ordinary regression.

**What is right censoring?** We know an event had not been observed by a certain time, but not its eventual occurrence time. Independent censoring conditional on the analysis is an assumption.

**How does KM work?** At each event time multiply the previous estimate by one minus events divided by the current risk set. Censored patients contribute risk time until censoring.

**Why Greenwood?** It estimates sampling variance of KM using event counts and risk sets; its square root is SE, not a confidence interval.

**Why compare intervals and what is coverage?** Repeated simulated samples reveal how often constructed intervals include the known population survival. A nominal 95% label is an approximation, especially with small risk sets.

**Why log-log?** Normal approximations on a transformed scale invert into probability bounds. At S=0 or 1 the algebra needs explicit handling; transformation is not universally superior.

**What is a log-rank test?** An event-time comparison of predefined group survival functions. A large p-value does not establish equality, nor does a small one establish causality.

**What is a Cox model and HR?** A semiparametric model h0(t)exp(X beta). exp(beta) compares conditional instantaneous hazards for a specified contrast, not event probabilities or risk ratios.

**What does PH mean?** Modeled hazard ratios are constant over follow-up. This dataset/model flags departures for age and grade; grade stratification does not remove age evidence.

**Why Monte Carlo?** Population truth is known under simulated exponential times, so repeated sampling can quantify coverage, uncertainty, boundary failures and missing interval support.

**Main limitations?** Historical selection, node-positive disease, censoring assumptions, confounding, simple covariate functions and non-PH. No external validation or modern patient prediction.

**What did coursework contribute?** KM, Greenwood and normal/log-log interval simulation. The historical coverage numbers are cited as historical; current simulations use a new recorded seed. It did not already include this GBSG analysis.

These are project explanations, not assertions of employment or independent clinical validation.
