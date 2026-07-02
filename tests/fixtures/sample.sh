#!/usr/bin/env bash
set -euo pipefail

greet() {
  echo "hello $1"
}

greet "world"
