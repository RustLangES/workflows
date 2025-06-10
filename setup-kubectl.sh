#!/bin/env bash

set -e

VERSION="latest"
TOKEN=""
CERTIFICATE=""
HOST=""
VALIDATE_ACCESS="true"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --version|-v)
      VERSION="$2"
      shift 2
      ;;
    --token|-t)
      TOKEN="$2"
      shift 2
      ;;
    --certificate|-c)
      CERTIFICATE="$2"
      shift 2
      ;;
    --host|-h)
      HOST="$2"
      shift 2
      ;;
    --validate-access|-a)
      VALIDATE_ACCESS="$2"
      shift 2
      ;;
    *)
      echo "Unknown option: $1"
      exit 1
      ;;
  esac
done

install_kubectl() {
  if [ "$VERSION" = "latest" ] || [ -z "$VERSION" ]; then
    VERSION=$(curl -L -s https://dl.k8s.io/release/stable.txt)
  else
    VERSION="v$VERSION"
  fi

  ARCH=$(uname -m)
  case $ARCH in
    x86_64) ARCH="amd64" ;;
    aarch64) ARCH="arm64" ;;
    armv7l) ARCH="arm" ;;
    *) echo "Not supported Arch: $ARCH"; exit 1 ;;
  esac

  curl -LO "https://dl.k8s.io/release/${VERSION}/bin/linux/${ARCH}/kubectl"
  sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
}

validate_installation() {
  kubectl version --client
}

configure_access() {
  mkdir -p ~/.kube

  cat <<EOF > ~/.kube/config
apiVersion: v1
kind: Config
clusters:
- name: remote-cluster
  cluster:
    server: ${HOST}
    certificate-authority-data: ${CERTIFICATE}
contexts:
- name: remote-context
  context:
    cluster: remote-cluster
    user: remote-user
current-context: remote-context
users:
- name: remote-user
  user:
    token: ${TOKEN}
EOF
}

validate_access() {
  if [ "$VALIDATE_ACCESS" = "true" ]; then
    kubectl cluster-info
  fi
}

install_kubectl
validate_installation
configure_access
validate_access
