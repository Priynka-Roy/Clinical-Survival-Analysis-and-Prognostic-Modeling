# Internal technical review

This is a structured self-review across five professional perspectives, not independent external review or clinical validation.

| Perspective | Finding and disposition |
|---|---|
| Clinical biostatistics | Verified package help against installed schema. Endpoint consistently recurrence OR death, not overall survival. Independent censoring stated. Upstream 686/720 selection disclosed. No new exclusions or treatment recommendations. |
| Applied statistics | Known-answer risk sets, Greenwood, log-log inversion and ties tested. Raw normal limits remain untruncated. Undefined and unsupported replicates tracked with explicit denominators and MCSE. Non-PH disclosed; grade-stratified sensitivity retains age limitation. |
| R engineering | Isolated renv lock with 76 packages including renv; portable relative source paths; no raw data or secrets. R 4.4.2 binaries load with R 4.4.3 build warnings. renv::status reports consistency. Linux execution awaits remote CI. |
| Shiny development | Six navigation sections initialize. Server tests cover group reactivity and bounded simulation rejection. Browser exposed compressed cards/plot margins; switched navbar to document scrolling. Explicit-button, bounded and session-cached simulation verified. Responsive breakpoints need broader device testing. |
| Healthcare analytics recruiting | README, executable report, interview guide, actual results and portfolio metadata prepared. Historical coursework distinguished from new clinical work. Public hosting and CI are not claimed before verification. |

Resolved implementation findings: unnamed dfbetas columns in survival 3.7-0; incorrect test expectation for no-event package log-log interval (actual NA); inaccessible sandbox-only user libraries (hydrated into renv); report image path rewriting; compressed fill layouts; overly wide simulation tables; inconsistent unused publishing dependency declaration.

Material statistical limitation retained explicitly: time-varying age and grade associations. No fabricated improvement or external validation. Optional Weibull extension, full nonlinearity/time-varying analysis and individual predictions intentionally absent.
