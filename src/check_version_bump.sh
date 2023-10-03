#!/bin/bash

exec 19> >( sed -e's/^/::debug::/g' )
BASH_XTRACEFD=19
export DEBUG=api

function files_changed() {
  local pr="$1"
  gh api repos/"${{ github.repository }}/pulls/$pr/files" --jq .[].filename 2>&19
}

echo ::group::Changed files
files_changed "${{ inputs.pr-number }}" | tee files_changed.log
echo ::endgroup::

grep -q -f CHANGELOG.md files_changed.log && grep -q 'lib/.*/version[.][^.]*$' files_changed.log
