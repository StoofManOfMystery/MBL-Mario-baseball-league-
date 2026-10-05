#!/bin/sh
# Builds index.html (the GitHub Pages site) from league.html (the page source).
set -e
cd "$(dirname "$0")"
{
  printf '<!doctype html><html lang="en"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1,viewport-fit=cover"><style>body{margin:0}</style><script src="config.js"></script></head><body>'
  cat league.html
  printf '</body></html>\n'
} > index.html
echo "built index.html"
