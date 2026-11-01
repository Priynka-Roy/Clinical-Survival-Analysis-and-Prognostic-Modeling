# Statistical protocol

Research aim: estimate recurrence-free survival and investigate conditional prognostic associations under incomplete follow-up. Unit: a retained patient. Event: recurrence or death; follow-up in days.

KM uses risk sets immediately before each distinct event time, counting tied events before tied censor removals. Survival is the product of 1−d/n. Independent, non-informative censoring is assumed. No extrapolation past the maximum observed follow-up is presented. At-risk counts use observed follow-up >= the requested time. Subgroup estimates respect each group's maximum follow-up.

Greenwood estimates S² sum[d/{n(n−d)}]. Normal 95% limits use qnorm(.975) times its square root without clipping. Log-log transformation log(−log(S)) has delta-method SE sqrt(var)/(S abs(log(S))); inversion reverses transformed limits. At S=1 log-log is NA; normal degenerates to [1,1]. At S=0 Greenwood algebra is undefined and both intervals are NA. At t beyond maximum follow-up all estimates/intervals are unsupported and NA. These deliberately explicit policies are tested against survival 3.7-0 in the interior and its no-event log-log behavior.

Predefined group comparisons: hormonal treatment, menopausal status, grade. Log-rank tests are exploratory, unadjusted for multiplicity, and do not establish treatment causality. Group sizes, events, censoring and maximum follow-up accompany curves. No data-driven cutpoint searches.

The explanatory Cox protocol and non-PH sensitivity are in COX_MODEL.md. Simulations are separate from the clinical analysis; see SIMULATION.md. Scripts write only aggregate outputs. Every result must derive from a successful execution rather than a historical or hand-entered claim.
