#!/usr/bin/env bats

# Load test helpers
# https://github.com/ztombol/bats-docs#loading
load "$BATS_TEST_DIRNAME/libs/bats-support/load.bash"
load "$BATS_TEST_DIRNAME/libs/bats-assert/load.bash"

# Globals
GIT_DIR="$BATS_TEST_DIRNAME/.."
BRIG_BIN="$BATS_TEST_DIRNAME/bin/brig"
BRIG_PROJECT_NAME="blimmer/brigade-project-integration-test"
BRIG_RUN="$BRIG_BIN run -f $GIT_DIR/brigade.js $BRIG_PROJECT_NAME"

# Begin Tests

@test "it can schedule a run" {
  run $BRIG_RUN
  assert_success
}

@test "it can replace the project" {
  # NOTE: the project is already created in the setup scripts
  run $BRIG_BIN project create -r -x -f "$BATS_TEST_DIRNAME/fixtures/project-fixture.json"
  assert_success
}
