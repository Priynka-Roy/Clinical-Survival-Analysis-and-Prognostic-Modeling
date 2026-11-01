load_clinical_data <- function() {
  d <- survival::gbsg
  expected <- c('pid','age','meno','size','grade','nodes','pgr','er','hormon','rfstime','status')
  stopifnot(identical(names(d), expected), !anyNA(d), !anyDuplicated(d$pid),
            all(d$rfstime >= 0), all(d$status %in% 0:1),
            all(d$meno %in% 0:1), all(d$hormon %in% 0:1), all(d$grade %in% 1:3),
            all(d$age > 0), all(d$size > 0), all(d$nodes > 0), all(d$pgr >= 0), all(d$er >= 0))
  d$meno <- factor(d$meno, 0:1, c('Premenopausal','Postmenopausal'))
  d$hormon <- factor(d$hormon, 0:1, c('No hormonal therapy','Hormonal therapy'))
  d$grade <- factor(d$grade, 1:3, c('Grade I','Grade II','Grade III'))
  d$age10 <- d$age / 10
  d$size10 <- d$size / 10
  d$log_nodes <- log2(d$nodes + 1)
  d
}

audit_data <- function(d) {
  data.frame(metric = c('Patients','Unique IDs','Missing cells','Duplicate IDs',
    'Recurrence or death events','Censored','Median observed follow-up (days)',
    'Minimum follow-up (days)','Maximum follow-up (days)','Excluded records'),
    value = c(nrow(d),length(unique(d$pid)),sum(is.na(d)),sum(duplicated(d$pid)),
      sum(d$status),sum(d$status == 0),median(d$rfstime),min(d$rfstime),max(d$rfstime),0))
}

describe_data <- function(d) {
  vars <- c('age','size','nodes','pgr','er','rfstime')
  do.call(rbind, lapply(vars, function(v) data.frame(variable=v, n=sum(!is.na(d[[v]])),
    median=median(d[[v]]),q1=unname(quantile(d[[v]],.25)),
    q3=unname(quantile(d[[v]],.75)),min=min(d[[v]]),max=max(d[[v]]))))
}

group_counts <- function(d, group) {
  do.call(rbind,lapply(split(d,d[[group]],drop=TRUE),function(x)
    data.frame(group=as.character(x[[group]][1]),patients=nrow(x),events=sum(x$status),
      censored=sum(x$status==0),max_followup_days=max(x$rfstime))))
}
