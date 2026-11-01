testthat::test_that('Shiny initializes and all six navigation sections are present', {
  withr::local_dir('../..')
  app <- source('app.R',local=new.env(parent=globalenv()))$value
  testthat::expect_s3_class(app,'shiny.appobj')
  # Source UI is independently inspectable without a browser connection.
  src <- paste(readLines('app.R'),collapse='\n')
  for(label in c('Clinical overview','Survival explorer','Prognostic factors',
    'Model diagnostics','Statistical reliability lab','Methods & limitations'))
    testthat::expect_true(grepl(label,src,fixed=TRUE))
})
