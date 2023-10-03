#!/usr/bin/env bats

setup() {
  source src/check_version_bump.sh
  BATS_LIB_PATH=$(git rev-parse --show-toplevel)/node_modules
  bats_load_library bats-support
  bats_load_library bats-assert
}

@test "Returns non-zero when CHANGELOG.md not in list of changed files" {
  unit_under_test() {
    cat <<- 'End_of_test' | check_for_changed_files
	just me
End_of_test
  }

  run unit_under_test
  assert_failure
}

@test "Returns zero when CHANGELOG.md and version in list of changed files" {
  unit_under_test() {
    cat <<- 'End_of_test' | check_for_changed_files
	just me
	CHANGELOG.md
	lib/imagine_that/version.rb
End_of_test
  }

  run unit_under_test
  assert_success
}
