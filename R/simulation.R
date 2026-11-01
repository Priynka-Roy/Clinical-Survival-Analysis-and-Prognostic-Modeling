generate_followup <- function(n, lambda, theta) {
  stopifnot(n>=2,n==as.integer(n),is.finite(lambda),lambda>0,is.finite(theta),theta>0)
  event <- rexp(n,lambda); censor <- rexp(n,theta)
  data.frame(time=pmin(event,censor),status=as.integer(event<=censor))
}

run_simulation <- function(n=100,lambda=.1,theta=.05,t0=5,B=2000,seed=20261101) {
  stopifnot(n>=2,n<=2000,B>=2,B<=5000,B==as.integer(B),t0>=0,is.finite(t0))
  # Restore caller's random state; deterministic runs do not affect other sessions.
  existed <- exists('.Random.seed',envir=.GlobalEnv)
  if(existed) old <- get('.Random.seed',envir=.GlobalEnv)
  on.exit(if(existed) assign('.Random.seed',old,envir=.GlobalEnv) else
    if(exists('.Random.seed',envir=.GlobalEnv)) rm('.Random.seed',envir=.GlobalEnv))
  set.seed(seed)
  truth <- exp(-lambda*t0)
  draws <- do.call(rbind,lapply(seq_len(B),function(i) {
    d <- generate_followup(n,lambda,theta)
    p <- km_point(d$time,d$status,t0)
    p$censoring <- mean(d$status==0); p
  }))
  summary <- do.call(rbind,lapply(c('normal','loglog'),function(method) {
    lo <- draws[[paste0(method,'_lower')]]; hi <- draws[[paste0(method,'_upper')]]
    valid <- is.finite(lo)&is.finite(hi); hits <- valid & lo<=truth & hi>=truth
    conditional <- if(any(valid)) mean(hits[valid]) else NA_real_
    all_rate <- sum(hits)/B
    data.frame(method=method,n=n,lambda=lambda,theta=theta,t0=t0,B=B,seed=seed,
      true_survival=truth,defined=sum(valid),undefined=sum(!valid),
      unsupported=sum(!draws$supported),coverage_defined=conditional,
      mcse_defined=if(any(valid)) sqrt(conditional*(1-conditional)/sum(valid)) else NA_real_,
      success_all=all_rate,mcse_all=sqrt(all_rate*(1-all_rate)/B),
      mean_width=if(any(valid)) mean((hi-lo)[valid]) else NA_real_,
      boundary_violations=sum(valid & (lo<0|hi>1)),
      mean_censoring=mean(draws$censoring),theoretical_censoring=theta/(lambda+theta),
      mean_risk=mean(draws$risk))
  }))
  list(summary=summary,draws=draws)
}
