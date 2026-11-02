# Coefficients of the Normalized Laplacian Characteristic Polynomial — code and results

Reference implementation and result files for the paper

> **Coefficients of the Normalized Laplacian Characteristic Polynomial with
> Applications to Graph Anomaly Detection and Over-Smoothing**

This repository contains the **code** and the **result files** behind every
table and figure of the paper. The graph datasets themselves are third-party
and are **not** redistributed here; see [Getting the data](#getting-the-data).

---

## Repository layout

```
code/       all experiment scripts (Python)
results/    result files (JSON) produced by the scripts, plus the full run log
figures/    the three vector figures included in the paper
REPRODUCE.md  table/figure  →  script  →  result file  map
```

## Requirements

```
python >= 3.8
numpy
networkx
scipy
torch        (only for code/e9_oversmoothing.py)
```

Install:

```bash
pip install -r requirements.txt
```

`code/e9_oversmoothing.py` additionally needs, on Windows:

```powershell
$env:KMP_DUPLICATE_LIB_OK = "TRUE"
```

## Getting the data

Download the public graphs and place them in `data/` **without decompressing**
the `.gz` / `.tgz` files (the loaders in the scripts do that themselves):

```bash
bash download_data.sh          # or: powershell -File download_data.ps1
```

| file in `data/` | source | used for |
|---|---|---|
| `facebook_combined.txt.gz` | https://snap.stanford.edu/data/facebook_combined.txt.gz | collaboration/social experiments |
| `ca-AstroPh.txt.gz` | https://snap.stanford.edu/data/ca-AstroPh.txt.gz | ditto |
| `wiki-Vote.txt.gz` | https://snap.stanford.edu/data/wiki-Vote.txt.gz | ditto |
| `email-Enron.txt.gz` | https://snap.stanford.edu/data/email-Enron.txt.gz | ditto |
| `cora.tgz`, `cora/` | https://linqs-data.soe.ucsc.edu/public/lbc/cora.tgz | node-level benchmark, over-smoothing |
| `citeseer.tgz`, `citeseer/` | https://linqs-data.soe.ucsc.edu/public/lbc/citeseer.tgz | ditto |

Every graph is reduced to its largest connected component and treated as
undirected, as described in Section VI-A of the paper.

## Reproducing the experiments

See **[REPRODUCE.md](REPRODUCE.md)** for the exact command behind each table and
figure, together with the result file it writes.

Quick start (all synthetic experiments, no downloads needed):

```bash
cd code
python verify_closedwalk.py     # machine-precision check of the closed-walk identity
python core_experiments.py      # synthetic detection and same-density/different-structure
python e3_camouflage.py         # truncation ablation
```

---

## ⚠️ Known discrepancy: `e7_benchmark.py` vs. Table IX

This is the one place where the archived code does **not** reproduce the published
numbers, and it is worth stating explicitly.

- The `ours` column of **Table IX** of the paper (52.3 / 43.6 / 58.7 / 41.4) is
  computed from the **un-binned** score `−log α(S)`.
- `code/e7_benchmark.py` was later modified so that its `ours_scores()` uses a
  **degree-binned z-score**. Running it today therefore yields
  **0.463 / 0.377 / 0.547 / 0.369**, and `results/results_e7.json` archives that
  binned variant.
- Degree binning is **not** a monotone transform in the pooled ranking, so it
  changes the AUC; the paper's Table IX is nonetheless reproducible
  bit-for-bit from the un-binned score with `code/e20_attribution.py`, which is
  provided precisely for this purpose.

So: **Table IX is correct, the script default drifted.** If you want to
regenerate Table IX, run `code/e20_attribution.py` (un-binned statistic), not
`code/e7_benchmark.py`.

The β = 0 column of Table X is computed from the same un-binned statistic and is
consistent with Table IX.

## Licensing

- **Code** — MIT, see [LICENSE](LICENSE).
- **Result files and figures** — CC BY 4.0.
- **Third-party datasets** — remain under their own terms (SNAP: research use,
  see the SNAP terms of use; Cora/CiteSeer: the Linqs release terms). They are
  linked, not redistributed.

## Citation

If you use this code, please cite the paper (see [CITATION.cff](CITATION.cff)).
