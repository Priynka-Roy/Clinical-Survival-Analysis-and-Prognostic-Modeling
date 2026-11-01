# Run once from a fresh checkout; then use renv::restore() for locked installs.
options(repos=c(CRAN='https://cloud.r-project.org'))
.libPaths(c('renv/library',.libPaths()))
if(!requireNamespace('renv',quietly=TRUE)) install.packages('renv')
renv::settings$use.cache(FALSE)
renv::init(bare=TRUE,restart=FALSE)
packages <- c('survival','shiny','bslib','ggplot2','testthat','rmarkdown','rsconnect','renv','withr')
renv::hydrate(packages=packages,prompt=FALSE)
renv::snapshot(packages=packages,prompt=FALSE)
