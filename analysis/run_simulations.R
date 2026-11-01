source('R/confidence_intervals.R'); source('R/simulation.R')
dir.create('artifacts',showWarnings=FALSE)
baseline <- run_simulation()
write.csv(baseline$summary,'artifacts/baseline_simulation.csv',row.names=FALSE)
scenarios <- rbind(
  data.frame(family='sample_size',n=c(25,50,100,200,500),t0=5,theta=.05),
  data.frame(family='evaluation_time',n=100,t0=c(1,3,5,10,15),theta=.05),
  data.frame(family='censoring',n=100,t0=5,theta=c(.025,.05,.1,.2)))
results <- lapply(seq_len(nrow(scenarios)),function(i) {
  s <- scenarios[i,]; x <- run_simulation(n=s$n,theta=s$theta,t0=s$t0,seed=20261101+i)$summary
  x$family <- s$family; x
})
write.csv(do.call(rbind,results),'artifacts/simulation_scenarios.csv',row.names=FALSE)
cat('Baseline and 14 scenarios computed at 2000 replicates each.\n')
