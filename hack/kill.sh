#!/usr/bin/env bash

set -euo pipefail

k3d cluster delete "${K3D_CLUSTER_NAME}" || true

k3d registry delete "${REGISTRY_NAME}" --port "${REGISTRY_PORT}" || true