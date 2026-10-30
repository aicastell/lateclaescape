#!/bin/bash
set -euo pipefail

cd "$(dirname "$0")"
source scripts/common.sh

setup_dart_sass
build_site
build_search_index development

echo "Arrancando Hugo en http://localhost:1313 ..."
hugo server -D
