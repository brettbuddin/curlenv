#!/usr/bin/env bash

set -euo pipefail

readonly root_path="$(dirname "$(readlink -f "$0")")/.."

now=$(date --iso-8601=seconds --date="-10 minutes")

jsonnet -A now=$now "$root_path/data/example.jsonnet" \
| curl -K "$root_path/request/example_post_json.txt" $@ \
| jq
