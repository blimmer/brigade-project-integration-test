#!/usr/bin/env bash
set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
BRIG_LOCATION="$SCRIPT_DIR"/../bin/brig
BRIG_VERSION="v0.18.0"
FIXTURE_PROJECT_NAME=blimmer/brigade-project-integration-test

check_helm() {
  if ! command -v helm; then
    echo "ERROR: you need to install helm to continue."
    exit 1
  fi
}

init_helm() {
  helm init --wait
}

install_brigade() {
  helm repo add brigade https://azure.github.io/brigade

  if ! helm status brigade; then
    helm install -n brigade brigade/brigade --set rbac.enabled=true
  fi
}

install_brig_cli_tool() {
  local brig_github_release

  case `uname` in
    'Linux')
      brig_github_release="https://github.com/Azure/brigade/releases/download/$BRIG_VERSION/brig-linux-amd64"
      ;;
    'Darwin')
      brig_github_release="https://github.com/Azure/brigade/releases/download/$BRIG_VERSION/brig-darwin-amd64"
      ;;
  esac

  if [ ! -f "$BRIG_LOCATION" ]; then
    curl -f -Lo "$BRIG_LOCATION" "$brig_github_release"
    chmod +x "$BRIG_LOCATION"
  fi
}

setup_project() {
  if ! $BRIG_LOCATION project get $FIXTURE_PROJECT_NAME; then
     $BRIG_LOCATION project create -x -f "$SCRIPT_DIR"/../fixtures/project-fixture.json
  fi
}

echo 'Setting up test environment...'

check_helm
init_helm
install_brigade
install_brig_cli_tool
setup_project

echo 'Done!'
