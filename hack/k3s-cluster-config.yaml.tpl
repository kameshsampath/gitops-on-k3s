apiVersion: k3d.io/v1alpha4
kind: Simple
metadata:
  name: ${K3D_CLUSTER_NAME}
servers: 1
# agents: 2
image: rancher/k3s:${K3S_VERSION}
network: ${DOCKER_NETWORK_NAME}
ports:
  # Drone CI
  - port: 0.0.0.0:30980:30980
    nodeFilters:
      - loadbalancer
  # Gitea
  - port: 0.0.0.0:30950:30950
    nodeFilters:
      - loadbalancer
  # Argo CD
  - port: 0.0.0.0:30080:30080
    nodeFilters:
     - loadbalancer