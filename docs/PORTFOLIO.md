# Future portfolio entry

**Title:** SurvivalCare

**Subtitle:** Clinical Survival Analysis & Prognostic Modeling

**Summary:** An R Shiny exploration of historical breast cancer recurrence-free survival, explanatory prognostic associations and Monte Carlo interval reliability.

**Verified technical highlights:**
- Manual Greenwood and log-log calculations agree with survival-package estimates away from boundaries on known synthetic and clinical examples.
- Audited 686 patient records and computed Kaplan–Meier, predefined log-rank comparisons, Cox associations and disclosed PH violations.
- Reproduced a 2000-replicate baseline and ran fourteen sample-size/time/censoring scenarios with explicit interval availability and MCSE.

**Tags:** R, Shiny, bslib, ggplot2, survival, Kaplan–Meier, Cox regression, Monte Carlo, testthat, renv.

**Case study:** Follow-up incompleteness creates a statistical challenge: observed event proportions cannot substitute for survival probabilities at a common time. This project uses a historical complete-record GBSG subset to explain risk sets, censoring and uncertainty. A focused explanatory Cox model illustrates prognostic associations while its Schoenfeld diagnostics reveal a key limitation: constant HRs do not fit every covariate. An offline simulation protocol examines interval coverage, and the interactive lab exposes defined/undefined interval denominators. Reproducible aggregate artifacts and tests support technical discussion without presenting a patient-level clinical tool.

GitHub target: https://github.com/Priynka-Roy/Clinical-Survival-Analysis-and-Prognostic-Modeling (publication status in STATUS.md).

Live application URL: null (deployment unverified). Use only authentic screenshots in artifacts; existing portfolio remains untouched.
