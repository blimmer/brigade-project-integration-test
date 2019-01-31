#!/usr/bin/env bats

# Load test helpers
# https://github.com/ztombol/bats-docs#loading
load "$BATS_TEST_DIRNAME/libs/bats-support/load.bash"
load "$BATS_TEST_DIRNAME/libs/bats-assert/load.bash"

# Globals
GIT_DIR="$BATS_TEST_DIRNAME/.."
BRIGADE_JS="${BRIGADE_JS:-$GIT_DIR/brigade.js}"
FIXTURE_PROJECT_NAME="${FIXTURE_PROJECT_NAME:-blimmer/brigade-project-integration-test}"
BRIG_RUN="$BATS_TEST_DIRNAME/bin/brig run -f $BRIGADE_JS $FIXTURE_PROJECT_NAME"

# Begin Tests

@test "it can schedule a run" {
  run $BRIG_RUN
  assert_success
}
