#!/usr/bin/env bash
set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
BRIG_LOCATION="$SCRIPT_DIR"/../bin/brig
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
  local brig_s3

  # We're using 0.18-prerelease because most tests will likely rely on
  # knowing the exit code from a `brig run`, implemented in this PR:
  # https://github.com/Azure/brigade/pull/415
  case `uname` in
    'Linux')
      brig_s3='https://s3.amazonaws.com/oss-pkg.ibotta.com/brig/0.18-prerelease/brig-linux-amd64'
      ;;
    'Darwin')
      brig_s3='https://s3.amazonaws.com/oss-pkg.ibotta.com/brig/0.18-prerelease/brig-darwin-amd64'
      ;;
  esac

  if [ ! -f "$BRIG_LOCATION" ]; then
    curl "$brig_s3"  > "$BRIG_LOCATION"
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
