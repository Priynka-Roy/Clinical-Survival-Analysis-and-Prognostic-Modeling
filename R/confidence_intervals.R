# Deliberately conservative boundary policy: undefined algebra stays NA.
# No-event normal interval is [1,1]; log-log is undefined at S=1.
# At S=0 Greenwood's expression is undefined. Beyond max follow-up both are NA.
km_point <- function(time, status, t0, level=.95) {
  stopifnot(length(time)>0,length(time)==length(status),all(is.finite(time)),
    all(time>=0),all(status %in% 0:1),length(t0)==1,is.finite(t0),t0>=0,
    level>0,level<1)
  supported <- t0 <= max(time)
  risk <- sum(time >= t0)
  event_times <- sort(unique(time[status==1 & time<=t0]))
  s <- 1; greenwood <- 0
  for (t in event_times) {
    n <- sum(time>=t); deaths <- sum(time==t & status==1)
    s <- s*(1-deaths/n)
    greenwood <- if (n==deaths) NA_real_ else greenwood+deaths/(n*(n-deaths))
  }
  variance <- s^2*greenwood
  if (!supported) {s <- NA_real_; variance <- NA_real_}
  z <- qnorm((1+level)/2)
  normal <- s+c(-1,1)*z*sqrt(variance)
  loglog <- c(NA_real_,NA_real_)
  if (supported && is.finite(s) && s>0 && s<1 && is.finite(variance)) {
    se_g <- sqrt(variance)/(s*abs(log(s)))
    loglog <- exp(-exp(log(-log(s))+c(1,-1)*z*se_g))
  }
  data.frame(time=t0,survival=s,risk=risk,supported=supported,variance=variance,
    normal_lower=normal[1],normal_upper=normal[2],
    loglog_lower=loglog[1],loglog_upper=loglog[2])
}
