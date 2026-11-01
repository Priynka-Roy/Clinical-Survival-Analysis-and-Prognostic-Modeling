# Delivery status — 2026-11-01

Local path: `C:\Users\priyn\OneDrive\Desktop\Data-Science-Projects\Clinical-Survival-Analysis-and-Prognostic-Modeling`.

The current writable workspace was used instead of the preferred Documents path. This is a new independent Git repository; the four earlier repositories and portfolio were not edited.

## Implemented and executed

- Detected R 4.4.2, RStudio, Git and Rtools44. No system environment changes.
- Initialized main and configured the requested GitHub remote.
- Loaded and audited real survival::gbsg; endpoint documentation verified.
- Computed descriptive results, KM, manual Greenwood/normal/log-log intervals, predefined group counts and log-rank tests.
- Fitted explanatory Cox model, PH tests, Schoenfeld plots and aggregate influence/stability diagnostics; added grade-stratified sensitivity.
- Reran baseline and 14 simulation scenarios, 2000 replicates each, deterministic seeds, explicit availability denominators.
- Built six-section Shiny app and bounded session-cached interactive lab.
- Created renv.lock and isolated library; renv::status reported no consistency issues.
- Executed automated tests: 63 passing assertions, zero failures, three package-build warnings in test contexts (R 4.4.3 builds on R 4.4.2); testthat also reports its build warning at loading.
- Rendered self-contained HTML report with actual figures and computed tables.
- Created Windows/Linux GitHub Actions workflow, documentation, interview guide, future portfolio copy and internal review.
- Inspected running app locally in browser and captured authentic screenshots.

## Incomplete / unverified

- GitHub publication completed after explicit user authorization: public repository created in Priynka-Roy's signed-in browser and `main` pushed successfully. The earlier browser approval blocker is resolved. Repository: https://github.com/Priynka-Roy/Clinical-Survival-Analysis-and-Prognostic-Modeling .
- Remote GitHub Actions has not run. Linux clean restoration/build is therefore unverified, despite a configured workflow and portable scripts.
- Posit Connect Cloud publishing requires user account access. Files and documented workflow are prepared; no public app URL exists.
- Narrow-screen and broader-device testing is incomplete. Local desktop interactions do not establish cross-device performance.
- The original coursework seed/source were not available; the new protocol and numerical differences are documented.
- R 4.4.2 is the installed development version, not the latest R release. Patch-build warnings are recorded; a newer R environment should rerun lock restoration and checks before release.

Reproduce with renv::restore(), tests/run_tests.R, analysis/run_analysis.R and analysis/run_simulations.R. Render reports/clinical_report.Rmd and run shiny::runApp() from the root. See DEPLOYMENT.md for publishing. No independent external clinical review is claimed.
