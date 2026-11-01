# Survival analysis guide

The primary clinical endpoint is recurrence or death, with days until first event or last follow-up. A censored patient is known to have no recorded event by last follow-up; their later event time remains unknown.

Kaplan–Meier uses every available risk interval. Censored observations leave future risk sets without being counted as events. Greenwood gives estimated variance, its square root is standard error, and confidence limits express a repeated-sampling procedure. The default clinical curve uses survival-package log-log limits, with censoring ticks. The manual estimator is validated against the package at interior probabilities.

The explorer provides at-risk counts and interval estimates at an explicitly selected day for all patients or predefined groups. A group is unsupported beyond its maximum observed follow-up; estimates are not extrapolated. Small risk sets deserve caution even before the support endpoint.

Clinical groups are treatment, menopause and grade; no outcome-driven grouping. Log-rank tests assess equality of survival functions but do not establish equality when nonsignificant or causal effects when significant. See METHODOLOGY.md for interval formulae and boundary handling; RESULTS.md for actual outputs.
