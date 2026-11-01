for(f in list.files('R',pattern='\\.R$',full.names=TRUE)) source(f)
testthat::test_dir('tests/testthat',stop_on_failure=TRUE)
