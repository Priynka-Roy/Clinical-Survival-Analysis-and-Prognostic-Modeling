for(f in list.files('R',pattern='\\.R$',full.names=TRUE)) source(f)
dir.create('artifacts',showWarnings=FALSE)
d <- load_clinical_data(); fit <- fit_cox(d); diag <- diagnose_cox(fit)
write.csv(audit_data(d),'artifacts/data_audit.csv',row.names=FALSE)
write.csv(describe_data(d),'artifacts/descriptive.csv',row.names=FALSE)
write.csv(cox_table(fit),'artifacts/cox_hazard_ratios.csv',row.names=FALSE)
write.csv(diag$table,'artifacts/ph_tests.csv',row.names=FALSE)
write.csv(diag$stability,'artifacts/influence_summary.csv',row.names=FALSE)
# Simple sensitivity: allow separate baseline hazards by grade. Grade HRs are
# intentionally unavailable; this does not by itself repair age non-PH.
strata <- survival::strata
sensitivity <- survival::coxph(survival::Surv(rfstime,status) ~ age10 + size10 +
  log_nodes + hormon + strata(grade),data=d,x=TRUE,y=TRUE,ties='efron')
write.csv(cox_table(sensitivity),'artifacts/cox_grade_stratified.csv',row.names=FALSE)
zs <- survival::cox.zph(sensitivity)
write.csv(data.frame(term=rownames(zs$table),zs$table,row.names=NULL),
  'artifacts/ph_grade_stratified.csv',row.names=FALSE)
write.csv(do.call(rbind,lapply(c(365,1095,1825),function(t) km_point(d$rfstime,d$status,t))),
  'artifacts/overall_survival.csv',row.names=FALSE)
write.csv(do.call(rbind,lapply(c('hormon','meno','grade'),function(g) compare_groups(d,g))),
  'artifacts/logrank.csv',row.names=FALSE)
write.csv(do.call(rbind,lapply(c('hormon','meno','grade'),function(g) {
  x <- group_counts(d,g); x$variable <- g; x
})),'artifacts/group_counts.csv',row.names=FALSE)
png('artifacts/kaplan_meier.png',width=1200,height=780,res=140); plot_km(fit_km(d)); dev.off()
png('artifacts/hazard_ratios.png',width=1200,height=700,res=140); print(forest_plot(cox_table(fit))); dev.off()
png('artifacts/schoenfeld.png',width=1500,height=1100,res=130)
par(mfrow=c(2,3)); plot(diag$zph); dev.off()
capture.output(sessionInfo(),file='artifacts/sessionInfo.txt')
writeLines(c(paste('R:',R.version.string),paste('survival:',packageVersion('survival')),
  paste('Events per coefficient:',fit$nevent/length(coef(fit))),
  paste('Covariance condition number:',diag$condition_number)), 'artifacts/model_metadata.txt')
cat('Clinical artifacts generated.\n')
