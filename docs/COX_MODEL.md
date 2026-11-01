# Explanatory Cox model

Formula: Surv(rfstime,status) ~ age/10 + size/10 + factor(grade) + log2(nodes+1) + factor(hormon), expressed through prepared variables. Age contrast = 10 years, size = 10 mm, grade II/III versus I, hormonal therapy versus none. Doubling nodes+1 changes the node term by one. Six coefficients, 299 events, 686 complete observations. No p-value selection or interactions. Menopause overlaps strongly with age conceptually; receptors remain descriptive in this focused model. This is a manageable illustrative explanatory protocol, not a claim to identify every independent prognostic factor.

Efron ties. HR=exp(beta) with Wald 95% intervals. No concordance, Brier score, time-dependent ROC or clinical score is presented. Positive-node skew is handled with log2(nodes+1); linear age/size and log-linear nodes remain assumptions. No formal nonlinear sensitivity has yet been implemented.

Scaled Schoenfeld residuals and cox.zph with KM time transform flag the primary model: age p=0.00399, grade p=0.00354, GLOBAL p=0.00215. Thus constant age/grade HRs are limited summaries. Global nonsignificance would not prove PH.

A simple grade-stratified sensitivity permits grade-specific baseline hazards, removes grade HRs, and retains other covariates. Its global p=0.0929 does not erase age-specific evidence (p=0.00715). This sensitivity is not a repaired or validated final prediction model. A fully specified time-varying age analysis would be needed for stronger time-specific claims; this educational implementation discloses the issue rather than enlarging scope automatically.

Influence is summarized by maximum absolute dfbetas per coefficient; model covariance condition number is recorded. These are diagnostics, not grounds for automatically deleting patients. No patient-level residual downloads are exposed. Confounding and historical selection remain regardless of model p-values.
