#!/usr/bin/env bash
set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

check_env() {
  local current_context=`kubectl config current-context`

  if [ "$current_context" != "minikube" ]; then
    echo "WARNING: kubectl is not pointing at your minikube! Exiting."
    exit 1
  fi
}

run_tests() {
  "$SCRIPT_DIR"/setup/setup_brigade.sh
  "$SCRIPT_DIR"/libs/bats/bin/bats test
}

check_env
run_tests
