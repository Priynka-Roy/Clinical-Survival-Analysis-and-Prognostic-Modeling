plot_km <- function(fit) {
  cols <- c('#147d80','#476aa0','#b27843')
  cols <- cols[seq_len(if(is.null(fit$strata)) 1L else length(fit$strata))]
  plot(fit,col=cols,lwd=2,mark.time=TRUE,conf.int=TRUE,
    xlab='Follow-up (days)',ylab='Recurrence-free survival probability',ylim=c(0,1))
  grid(col='#e6edf2')
  if(!is.null(fit$strata)) legend('bottomleft',names(fit$strata),col=cols,lwd=2,bty='n')
}

forest_plot <- function(tab) {
  labels <- c(age10='Age (per 10 years)',size10='Tumor size (per 10 mm)',
    'gradeGrade II'='Grade II vs I','gradeGrade III'='Grade III vs I',
    log_nodes='Doubling of nodes + 1','hormonHormonal therapy'='Hormonal therapy vs none')
  tab$term <- unname(labels[tab$term])
  ggplot2::ggplot(tab,ggplot2::aes(x=HR,y=term,xmin=lower,xmax=upper))+
    ggplot2::geom_vline(xintercept=1,linetype=2,color='gray50')+
    ggplot2::geom_errorbar(orientation='y',width=.15,color='#147d80')+
    ggplot2::geom_point(size=3,color='#147d80')+ggplot2::scale_x_log10()+
    ggplot2::labs(x='Adjusted hazard ratio (95% CI; logarithmic scale)',y=NULL)+
    ggplot2::theme_minimal(base_size=13)
}
