# Posit Connect Cloud

Official requirements checked 2026-11-01: https://docs.posit.co/connect-cloud/how-to/r/shiny-r.html . GitHub deployment requires an R Shiny application and `renv.lock` or `manifest.json` listing packages. No live deployment is claimed.

1. Publish this independent repository as Priynka-Roy/Clinical-Survival-Analysis-and-Prognostic-Modeling (public); branch main. Do not modify the portfolio repository.
2. Sign in to Posit Connect Cloud and connect the GitHub account. Select this repository and branch.
3. Select Shiny for R and primary file `app.R` in the repository root. Use the committed renv.lock for dependencies; inspect build logs and select a supported compatible R version.
4. Deploy; verify all six sections, survival group selectors, diagnostics and bounded simulations. Check cold start and narrow-screen layout before sharing.
5. Only then record the real public app URL in the portfolio metadata and README.

The app needs no API keys, live database, private records or simulation at startup. `renv/library`, private rsconnect configuration and local secrets are ignored. CI rebuilds clinical outputs and runs small deterministic tests on Windows and Linux; expensive scenarios run manually.

If using RStudio publishing instead, `rsconnect` is locked as tooling. Account credentials and publishing tokens must remain outside Git. Deployment authorization was not available during local implementation; perform the account connection interactively. No alternate hosting provider was configured.
