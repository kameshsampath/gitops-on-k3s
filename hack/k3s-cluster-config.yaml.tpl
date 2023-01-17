apiVersion: k3d.io/v1alpha4
kind: Simple
metadata:
  name: ${K3D_CLUSTER_NAME}
servers: 1
agents: 1
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
options:
  # https://k3d.io/v5.4.6/faq/faq/#pods-evicted-due-to-lack-of-disk-space
  k3s:
    extraArgs: # additional arguments passed to the `k3s server|agent` command; same as `--k3s-arg`
      - arg: "--kubelet-arg=eviction-hard=imagefs.available<1%,nodefs.available<1%"
        nodeFilters:
          - agent:*
      - arg: "--kubelet-arg=eviction-minimum-reclaim=imagefs.available=1%,nodefs.available=1%"
        nodeFilters:
          - agent:*