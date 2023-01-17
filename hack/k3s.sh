#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

envsubst < "$SCRIPT_DIR/k3s-cluster-config.yaml.tpl" > "$SCRIPT_DIR/k3s-cluster-config.yaml"

# echo '' > "$SCRIPT_DIR/registries.yaml"
# envsubst < "$SCRIPT_DIR/../config/etc/rancher/k3s/registries.yaml" > "$SCRIPT_DIR/registries.yaml"

k3d registry create "${REGISTRY_NAME}" --port "${REGISTRY_PORT}" || true

k3d cluster create -c "$SCRIPT_DIR/k3s-cluster-config.yaml" \
  --registry-use "k3d-${REGISTRY_NAME}:$REGISTRY_PORT"