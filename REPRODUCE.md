# Table / figure  →  script  →  result file

Commands are run from `code/` after placing the datasets in `../data/`.
Relative paths in the scripts assume that layout.

## Tables

| Paper | Content | Script | Result file |
|---|---|---|---|
| Table I | position relative to related work (survey table) | — (no experiment) | — |
| Table II | model validation: edge term / m ≤ 3 / full series | `e4_real_data.py` | `results_e4.json` |
| Table III | end-to-end prediction of the score (R², max error) | `e10_validation.py` | `results_e10.json` |
| Table IV | truncation ablation on 6-regular hosts | `e3_camouflage.py` | `results.json` |
| Table IV (threshold / ρ / ΔT₃ quantities) | `e17_strict_precondition.py`, cross-checked by `e18_verify_e17.py` | `results_e17.json`, `results_e18.json` |
| Table V | fragment detection at the density anchor | `e6_final.py` | `results_e6.json` |
| Table VI | AUC at the anchor with 95 % bootstrap intervals | `e10_validation.py` | `results_e10.json` |
| Table VII | camouflaged fragments, paired bootstrap | `e19_paired_bootstrap.py` (adopted in the paper); `e15_extra.py` is the **independent** variant kept for comparison only | `results_e19.json`, `results_e15.json` |
| Table VIII | sufficient condition vs. camouflage experiment | `e16_threshold.py` | `results_e16.json` |
| Table IX | node-level benchmark, Cora / CiteSeer | `e20_attribution.py` — **not** `e7_benchmark.py`, see the discrepancy note in README | `results_e7.json` (binned variant; the paper's values are the un-binned ones) |
| Table X | normalization ablation (β sweep) | `e12_normalization.py` | `results_e12.json` |
| Table XI | over-smoothing functional and test accuracy vs. depth | `e9_oversmoothing.py` | `results_e9.json` |
| Table XII | cost of one evaluation | `e8_runtime.py` | — (wall-clock, logged) |

## Figures

| Paper | Script | Output |
|---|---|---|
| Fig. 1 (parity plot) | `e10_validation.py` | `figures/fig_e10_parity.pdf` |
| Fig. 2 (sensitivity) | `e10_validation.py` | `figures/fig_e10_sensitivity.pdf` |
| Fig. 3 (over-smoothing) | `e9_oversmoothing.py` | `figures/fig_e9_overmsoothing.pdf` |

## Correctness checks (not tables in the paper)

| Purpose | Script |
|---|---|
| closed-walk identity at machine precision | `verify_closedwalk.py` |
| synthetic detection / same-density different-structure | `core_experiments.py` |
| sign orientation of the score | `direction_check.py` |
| incidence-minor and principal-minor verification | `e13_verify_brief.py`, `e14_verify_review2.py` |
| attribution of the published Table IX values | `e20_attribution.py` |

## Runtime notes

- Everything except `e9_oversmoothing.py` runs on CPU in minutes on the four
  SNAP graphs.
- `e9_oversmoothing.py` trains small GCNs on Cora/CiteSeer; on Windows set
  `KMP_DUPLICATE_LIB_OK=TRUE` first.
- Random seeds are fixed inside each script; the seeds used for the reported
  numbers are recorded in the corresponding `results_*.json`.
