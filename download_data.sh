#!/usr/bin/env bash
set -e
DIR="$(cd "$(dirname "$0")" && pwd)/data"
mkdir -p "$DIR"
for f in facebook_combined.txt.gz ca-AstroPh.txt.gz wiki-Vote.txt.gz email-Enron.txt.gz; do
  [ -f "$DIR/$f" ] || curl -fL "https://snap.stanford.edu/data/$f" -o "$DIR/$f"
done
for f in cora.tgz citeseer.tgz; do
  [ -f "$DIR/$f" ] || curl -fL "https://linqs-data.soe.ucsc.edu/public/lbc/$f" -o "$DIR/$f"
done
echo "done. files in $DIR"
