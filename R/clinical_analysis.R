fit_km <- function(d, group=NULL) {
  f <- if(is.null(group)) survival::Surv(rfstime,status) ~ 1 else
    as.formula(paste('survival::Surv(rfstime,status) ~',group))
  survival::survfit(f,data=d,conf.type='log-log')
}

compare_groups <- function(d, group) {
  f <- as.formula(paste('survival::Surv(rfstime,status) ~',group))
  x <- survival::survdiff(f,data=d)
  data.frame(group=group,chisq=x$chisq,df=length(x$n)-1,
    p_value=pchisq(x$chisq,length(x$n)-1,lower.tail=FALSE))
}

fit_cox <- function(d) {
  # Prespecified explanatory model. No selection by significance.
  survival::coxph(survival::Surv(rfstime,status) ~ age10 + size10 + grade +
    log_nodes + hormon, data=d,x=TRUE,y=TRUE,model=TRUE,ties='efron',na.action=na.fail)
}

cox_table <- function(fit) {
  s <- summary(fit)
  data.frame(term=rownames(s$coefficients),beta=s$coefficients[,'coef'],
    HR=s$conf.int[,'exp(coef)'],lower=s$conf.int[,'lower .95'],
    upper=s$conf.int[,'upper .95'],p_value=s$coefficients[,'Pr(>|z|)'],row.names=NULL)
}

diagnose_cox <- function(fit) {
  z <- survival::cox.zph(fit,transform='km')
  influence <- residuals(fit,type='dfbetas')
  list(zph=z,table=data.frame(term=rownames(z$table),z$table,row.names=NULL),
    stability=data.frame(term=names(coef(fit)),
      max_absolute_dfbeta=apply(abs(influence),2,max)),
    condition_number=kappa(fit$var),events=fit$nevent,n=fit$n)
}
