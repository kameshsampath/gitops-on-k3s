#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# shellcheck source=/dev/null
. "${SCRIPT_DIR}/check-registry"

## Installs
# shellcheck source=/dev/null
. "${SCRIPT_DIR}/install-gitea"
# shellcheck source=/dev/null
. "${SCRIPT_DIR}/check-gitea"

# shellcheck source=/dev/null
. "${SCRIPT_DIR}/install-argocd"
# shellcheck source=/dev/null
. "${SCRIPT_DIR}/check-argocd"


