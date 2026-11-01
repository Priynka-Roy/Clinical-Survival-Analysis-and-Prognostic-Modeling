# Limitations and responsible use

Historical, node-positive breast cancer cohort, upstream complete-record selection (686/720), historical therapies and follow-up; not representative of current patients or Finnish care. Endpoint combines recurrence and death, with no cause-specific split. No new imputation, clinical recoding or observation deletion.

Independent non-informative censoring is required and cannot be established from observed follow-up alone. Late estimates have few patients at risk. Crude observed events/686 is not survival probability at a given time. Approximate intervals can be degenerate or undefined; the simulation records this explicitly.

Group comparisons are exploratory, multiple and not causally interpreted. The Cox model shows non-PH, particularly age and grade; the grade-stratified sensitivity retains age non-PH evidence. Functional forms and omitted covariates limit associations. There is no external validation or validated individual prognosis. Formal nonlinear and time-varying modeling remain beyond this implementation.

The application is educational analytics, not diagnosis, treatment selection, clinical decision support or a medical device. No patient identifiers or real-patient inputs are requested. Aggregate-only app outputs limit unnecessary record exposure. Independent internal technical review does not constitute external clinical validation.
