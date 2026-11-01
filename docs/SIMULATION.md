# Monte Carlo protocol

Generate T~Exponential(lambda), C~Exponential(theta) independently, X=min(T,C), delta=I(T<=C). Truth S(t0)=exp(−lambda*t0); censoring probability theta/(lambda+theta). Times use arbitrary simulation units, not clinical days.

Baseline lambda=.1, theta=.05, n=100, t0=5, B=2000; seed 20261101. Scenarios: n=25/50/100/200/500; t0=1/3/5/10/15; theta=.025/.05/.10/.20. Other settings remain at baseline. The scenario seed is baseline seed plus its 1-based protocol row. R RNG defaults are Mersenne-Twister/Inversion/Rejection; R version is recorded. RNG state is restored after each function call. Both methods use the same samples within each scenario.

Normal intervals are raw and untruncated. Boundary violations are counted among finite intervals. No-event normal intervals [1,1] are defined but generally miss interior truth; log-log is undefined at 1. At terminal S=0 Greenwood variance is undefined. t0 beyond max(X) is unsupported for both methods. Unsupported is counted separately within the undefined total, not discarded.

Coverage_defined = successful intervals / defined intervals, with MCSE sqrt[p(1−p)/N_defined]. Success_all = successful finite intervals / B, counting undefined as unsuccessful, with MCSE sqrt[p(1−p)/B]. This latter diagnostic includes interval availability; it is not pure conditional coverage. Width averages only defined intervals; all-undefined width and conditional coverage remain NA. Report defined/undefined/unsupported counts, risk support, mean censoring and theoretical expectation.

New baseline normal/log-log coverages: .9480/.9585; MCSE .004965/.004460. Mean widths .203895/.202953. All 2000 replicates were supported and defined. Historical user-provided coursework coverage .9450/.9485 is not expected to match exactly: original seed and source were unavailable and boundary protocols may differ. The coursework did not contain this new GBSG analysis.

The UI caps n=500 and B=500 and runs only on explicit request; caching is session-specific and keyed by parameters. Offline scripts run the full protocol. No expensive simulation at app startup. No Weibull extension was added.
