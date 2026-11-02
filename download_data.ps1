# Download the public graph datasets into ..\data
$ErrorActionPreference = 'Stop'
$dir = Join-Path (Split-Path -Parent $PSScriptRoot) 'data'
if (-not (Test-Path $dir)) { New-Item -ItemType Directory $dir | Out-Null }
if (-not (Test-Path $PSScriptRoot)) { }
$base = Split-Path -Parent $PSScriptRoot
$dir = Join-Path $base 'data'
if (-not (Test-Path $dir)) { New-Item -ItemType Directory $dir | Out-Null }

$snap = @(
  'facebook_combined.txt.gz',
  'ca-AstroPh.txt.gz',
  'wiki-Vote.txt.gz',
  'email-Enron.txt.gz'
)
foreach ($f in $snap) {
  $out = Join-Path $dir $f
  if (Test-Path $out) { Write-Host "skip  $f" ; continue }
  Write-Host "fetch $f"
  Invoke-WebRequest -Uri "https://snap.stanford.edu/data/$f" -OutFile $out
}

$linqs = @{ 'cora.tgz' = 'https://linqs-data.soe.ucsc.edu/public/lbc/cora.tgz' ;
            'citeseer.tgz' = 'https://linqs-data.soe.ucsc.edu/public/lbc/citeseer.tgz' }
foreach ($k in $linqs.Keys) {
  $out = Join-Path $dir $k
  if (Test-Path $out) { Write-Host "skip  $k" ; continue }
  Write-Host "fetch $k"
  Invoke-WebRequest -Uri $linqs[$k] -OutFile $out
}
Write-Host "done. Files are in $dir"
