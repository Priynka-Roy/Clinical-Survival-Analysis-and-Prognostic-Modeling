library(shiny)
library(bslib)
library(ggplot2)
for (f in list.files('R',pattern='\\.R$',full.names=TRUE)) source(f,local=TRUE)
d <- load_clinical_data()
cox <- fit_cox(d)
diagnostics <- diagnose_cox(cox)
panel <- function(title,...) card(card_header(title),...)

ui <- page_navbar(
  title='SurvivalCare',id='navigation',fillable=FALSE,
  theme=bs_theme(version=5,bg='#f3f6fa',fg='#132b45',primary='#147d80',
    secondary='#476aa0',base_font=font_collection('Segoe UI','Arial','sans-serif')),
  header=tags$div(class='container-fluid',style='padding:20px 28px 8px',
    tags$h2('Clinical Survival Analysis & Prognostic Modeling'),
    tags$p('Historical clinical evidence • uncertainty • reproducible statistical methods'),
    tags$p(style='color:#53657a','Educational analysis. Not a validated patient-level prognostic or treatment tool.')),
  nav_panel('Clinical overview',
    layout_columns(
      value_box('Historical patients',nrow(d),theme='primary'),
      value_box('Recurrence or death',sum(d$status),theme='primary'),
      value_box('Censored observations',sum(d$status==0),theme='secondary')),
    layout_columns(
      panel('The research question',tags$p('How can researchers estimate recurrence-free survival and investigate prognostic factors when follow-up is incomplete?'),
        tags$p('GBSG: a 1984–1989 trial of node-positive breast cancer. The package retains 686 of 720 patients with complete prognostic data. No further records are excluded here.'),
        tags$p(paste('Median observed follow-up:',median(d$rfstime),'days. This is the median of observed event/censoring times, not median survival.'))),
      panel('Data quality audit',tableOutput('audit'))),
    panel('Clinical measurements',tableOutput('descriptive')),
    panel('Predefined patient groups',tableOutput('categories'))),
  nav_panel('Survival explorer',
    layout_sidebar(sidebar=sidebar(
      selectInput('group','Predefined comparison',c('All patients'='all','Hormonal therapy'='hormon','Menopausal status'='meno','Tumor grade'='grade')),
      sliderInput('time','Evaluate survival at day',min=0,max=max(d$rfstime),value=1095,step=1),
      tags$p('Event = recurrence or death. A censoring mark means event-free at the last recorded follow-up.'),
      tags$p('Log-rank null: the group survival functions are equal. A large p-value does not prove equality. These exploratory comparisons do not establish treatment effects.')),
      panel('Kaplan–Meier survival with log-log 95% intervals',plotOutput('km',height='430px'),
        tags$p('Tick marks indicate censoring. Confidence limits widen as information decreases. Follow-up is in days.')),
      panel('Number at risk and survival at the selected day',tableOutput('risk')),
      panel('Group sizes and observed events',tableOutput('groups')),
      panel('Log-rank comparison',tableOutput('logrank')),
      panel('Overall interval comparison',tableOutput('intervals'),
        tags$p('Direct-normal limits are untruncated. NA means undefined or beyond observed support.')))),
  nav_panel('Prognostic factors',
    panel('Prespecified explanatory Cox model',
      tags$p('Age per 10 years; tumor size per 10 mm; grade II/III versus grade I; log2(nodes + 1); hormonal therapy versus no hormonal therapy.'),
      tags$p('A one-unit change in log2(nodes + 1) doubles nodes + 1. Menopausal status and receptors are summarized descriptively but omitted from this manageable model. No p-value selection or interactions.'),
      tags$p(paste('Analysis population:',cox$n,'patients;',cox$nevent,'events. Efron handling of ties.')),
      plotOutput('forest',height='360px'),tableOutput('hazards')),
    panel('Interpretation',tags$p('Hazard ratios describe conditional instantaneous event hazard, not recurrence probability or risk ratios. Associations depend on covariate coding, functional form, and proportional hazards. No individual prediction or treatment recommendations are provided.'))),
  nav_panel('Model diagnostics',
    panel('Proportional hazards tests',tableOutput('ph'),
      tags$p('Scaled Schoenfeld residual tests use the Kaplan–Meier time transform. Small p-values flag time variation; large values do not prove proportional hazards. Violations limit a constant hazard-ratio interpretation.'),
      tags$p(style='font-weight:600','This model flags non-proportional hazards globally and for age and grade. Treat the reported constant hazard ratios as limited summaries, not stable effects throughout follow-up. See the documented sensitivity analysis.')),
    panel('Scaled Schoenfeld residuals',selectInput('ph_term','Model term',choices=rownames(diagnostics$zph$table)[-nrow(diagnostics$zph$table)]),plotOutput('schoenfeld',height='400px')),
    panel('Influence and stability',tableOutput('stability'),
      tags$p('Maximum absolute standardized coefficient change on deletion (dfbetas), aggregated without exposing patient records. Linear age and size effects and log-linear node effects are assumptions; the model is explanatory and not externally validated.'))),
  nav_panel('Statistical reliability lab',
    layout_sidebar(sidebar=sidebar(
      numericInput('sim_n','Sample size',100,min=25,max=500,step=25),
      numericInput('lambda','Event rate',.1,min=.01,max=1,step=.01),
      numericInput('theta','Independent censoring rate',.05,min=.005,max=1,step=.025),
      numericInput('t0','Evaluation time (simulation units)',5,min=0,max=30,step=1),
      numericInput('B','Replicates (bounded)',200,min=50,max=500,step=50),
      actionButton('simulate','Run simulation',class='btn-primary'),
      tags$p('Exponential event and censoring times; fixed seed 20261101; nominal 95% intervals. Simulated time units are separate from clinical days.')),
      panel('Coverage and computational support',tableOutput('simulation'),
        tags$p('Coverage_defined uses only defined intervals. Success_all counts undefined intervals as unsuccessful, with all replicates in the denominator. MCSE uses the matching denominator. Unsupported means evaluation beyond the last observed follow-up. These denominators answer different questions.')),
      panel('Coverage comparison',plotOutput('coverage',height='300px')),
      panel('Coursework foundation',tags$p('Original University of Turku coursework: Kaplan–Meier, Greenwood variance and exponential simulations. Reported historical baseline coverage: 0.9450 normal and 0.9485 log-log. Newly computed results are in artifacts/baseline_simulation.csv; equality is not expected without the original seed and implementation.')))),
  nav_panel('Methods & limitations',
    panel('Survival methods',
      tags$p('Right censoring: follow-up ends before a recorded recurrence/death. Kaplan–Meier multiplies (1 − events / number at risk) at each event time, under independent, non-informative censoring.'),
      tags$p('Greenwood variance is S² × sum[d / {n(n−d)}]. Standard error is the square root of variance. Normal limits are S ± 1.96 SE; log-log limits transform log(−log(S)) and invert in reversed order.'),
      tags$p('At S=1 the log-log transformation is undefined; at S=0 this implementation leaves Greenwood-based intervals undefined. Normal [1,1] with no events is a degenerate approximation. Neither method extrapolates past observed follow-up.'),
      tags$p('Cox: h(t|X)=h0(t) exp(Xβ). Reported hazard ratios assume constant covariate contrasts over time. Log-rank tests compare predefined groups and are exploratory without multiplicity correction.')),
    panel('Provenance, ethics and reproducibility',
      tags$p('Source: survival::gbsg; historical German node-positive breast cancer study, 686 complete records selected from 720. The composite endpoint is recurrence or death, not overall survival or recurrence alone. No modern Finnish representativeness, consent history, or external validation is claimed.'),
      tags$p('Selection, historical care, potential confounding, incomplete follow-up and model misspecification limit interpretation. No identifiable inputs or raw-patient downloads are accepted.'),
      tags$p(paste('Installed survival version:',packageVersion('survival'))),
      tags$a(href='https://stat.ethz.ch/R-manual/R-devel/library/survival/html/gbsg.html','Official dataset documentation'),tags$br(),
      tags$p('Royston & Altman (2013), BMC Medical Research Methodology 13:33. The present analysis does not reproduce that paper’s external model validation.'),
      tags$p('See README, docs and reports for the protocol, package lockfile and current completion status.')))
)

server <- function(input,output,session) {
  output$audit <- renderTable(audit_data(d),digits=0)
  output$descriptive <- renderTable(describe_data(d),digits=1)
  output$categories <- renderTable(do.call(rbind,lapply(c('hormon','meno','grade'),function(g) {
    x <- group_counts(d,g); x$variable <- g; x
  })),rownames=FALSE)
  km <- reactive(fit_km(d,if(identical(input$group,'all')) NULL else input$group))
  output$km <- renderPlot(plot_km(km()))
  output$risk <- renderTable({
    groups <- if(identical(input$group,'all')) list(All=d) else split(d,d[[input$group]])
    do.call(rbind,lapply(names(groups),function(g) {
      x <- groups[[g]]; p <- km_point(x$rfstime,x$status,input$time)
      data.frame(group=g,day=input$time,at_risk=p$risk,supported=p$supported,
        survival=p$survival,lower=p$loglog_lower,upper=p$loglog_upper)
    }))
  },digits=3)
  output$groups <- renderTable(if(input$group!='all') group_counts(d,input$group) else
    data.frame(group='All',patients=nrow(d),events=sum(d$status),censored=sum(d$status==0)))
  output$logrank <- renderTable(if(input$group!='all') compare_groups(d,input$group))
  output$intervals <- renderTable(km_point(d$rfstime,d$status,input$time),digits=4)
  output$hazards <- renderTable(cox_table(cox),digits=4)
  output$forest <- renderPlot(forest_plot(cox_table(cox)))
  output$ph <- renderTable(diagnostics$table,digits=4)
  updateSelectInput(session,'ph_term',choices=rownames(diagnostics$zph$table)[-nrow(diagnostics$zph$table)])
  output$schoenfeld <- renderPlot({req(input$ph_term); plot(diagnostics$zph,var=match(input$ph_term,rownames(diagnostics$zph$table)))})
  output$stability <- renderTable(diagnostics$stability,digits=3)
  sim <- reactive({
    req(input$simulate>0)
    validate(need(is.finite(input$sim_n)&&input$sim_n>=25&&input$sim_n<=500&&input$sim_n==as.integer(input$sim_n),'Sample size must be an integer from 25 to 500.'),
      need(is.finite(input$B)&&input$B>=50&&input$B<=500&&input$B==as.integer(input$B),'Replicates must be an integer from 50 to 500.'),
      need(is.finite(input$lambda)&&input$lambda>=.01&&input$lambda<=1,'Event rate must be 0.01–1.'),
      need(is.finite(input$theta)&&input$theta>=.005&&input$theta<=1,'Censoring rate must be 0.005–1.'),
      need(is.finite(input$t0)&&input$t0>=0&&input$t0<=30,'Evaluation time must be 0–30.'))
    run_simulation(input$sim_n,input$lambda,input$theta,input$t0,input$B)$summary
  }) |> bindCache(input$sim_n,input$lambda,input$theta,input$t0,input$B,cache='session') |>
    bindEvent(input$simulate)
  output$simulation <- renderTable({
    s <- sim()
    metrics <- c(B='Replicates',true_survival='True survival',defined='Defined intervals',
      undefined='Undefined intervals',unsupported='Unsupported follow-up',
      coverage_defined='Coverage among defined intervals',mcse_defined='Monte Carlo SE (defined)',
      success_all='Successful intervals / all replicates',mcse_all='Monte Carlo SE (all)',
      mean_width='Mean interval width (defined)',boundary_violations='Boundary violations',
      mean_censoring='Mean censoring proportion',theoretical_censoring='Theoretical censoring',
      mean_risk='Mean at risk at evaluation')
    data.frame(Metric=unname(metrics),Normal=as.numeric(s[1,names(metrics)]),
      `Log-log`=as.numeric(s[2,names(metrics)]),check.names=FALSE)
  },digits=4)
  output$coverage <- renderPlot({
    ggplot(sim(),aes(method,coverage_defined,fill=method))+geom_col(width=.5)+
      geom_errorbar(aes(ymin=pmax(0,coverage_defined-1.96*mcse_defined),
        ymax=pmin(1,coverage_defined+1.96*mcse_defined)),width=.15)+
      geom_hline(yintercept=.95,linetype=2)+coord_cartesian(ylim=c(0,1))+
      labs(x=NULL,y='Coverage among defined intervals (±1.96 MCSE)')+theme_minimal()+guides(fill='none')
  })
}
shinyApp(ui,server)
