# Data card

Source: `survival::gbsg`, version recorded in `renv.lock` and `artifacts/sessionInfo.txt`. Load from the installed package, never download on app navigation. Official help: https://stat.ethz.ch/R-manual/R-devel/library/survival/html/gbsg.html . Installed 3.7-0 help was inspected and matched the endpoint and schema.

Historical GBSG trial, 1984–1989: 720 node-positive breast cancer patients originally; 686 with complete prognostic data retained upstream. This selection can bias representativeness. No modern population, Finnish population, consent arrangements or identifiable records are claimed.

| Variable | Definition / encoding |
|---|---|
| pid | Upstream patient identifier; audit uniqueness; never used as predictor |
| age | Years |
| meno | 0 premenopausal, 1 postmenopausal |
| size | Tumor size, mm |
| grade | Tumor grade I, II, III |
| nodes | Positive lymph-node count |
| pgr | Progesterone receptor measurement; fmol/l as documented upstream |
| er | Estrogen receptor measurement; fmol/l as documented upstream |
| hormon | 0 no hormonal therapy, 1 hormonal therapy |
| rfstime | Days to first recurrence, death or last follow-up |
| status | 1 recurrence or death; 0 alive without recorded recurrence at last follow-up |

The audit checks schema, missingness, identifiers, binary status, nonnegative follow-up, valid factor codes and positive/nonnegative clinical measurements. Unexpected records stop the pipeline rather than silently disappear. No imputation or additional exclusion is applied. Distributional summaries are exported as aggregates.

Upstream `survival` declares LGPL (>=2). Dataset-specific consent or a separate data license is not asserted. Raw data are not redistributed in this repository. Preserve upstream attribution and consult source terms for further reuse. MIT applies only to original project code.
