#!/bin/bash

exec 19> >( sed -e's/^/::debug::/g' )
BASH_XTRACEFD=19
export DEBUG=api

files_changed() {
  local repo="$1"
  local pr="$2"
  gh api repos/"$repo"/pulls/"$pr"/files --jq .[].filename 2>&19
}

check_for_changed_files() {
  echo ::group::Changed files
  tee files_changed.log
  echo ::endgroup::

  grep -q -f CHANGELOG.md files_changed.log && grep -q 'lib/.*/version[.][^.]*$' files_changed.log
}

main() {
  local repo="$1"
  local pr="$2"
  files_changed "$repo" "$pr" | check_for_changed_files
}

( return 0 2>/dev/null ) || main "$@"
