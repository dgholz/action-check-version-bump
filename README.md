# Check for version bumps

## Description

This action looks for changes to `CHANGELOG.md` & a `version` file in a PR, and fails if it can't find both.

## Usage

```
name: Remember to bump version & Changelog

on:
  pull_request:

jobs:
  check-for-version-bump:
    runs-on: ubuntu-latest
    steps:
      - name: Check for version bump
        uses: dgholz/action-check-version-bump
```

## Inputs

* `pr-number`
  The PR to check for bumped version files.

## Outputs

None.

## Environment Variables

* `GITHUB_TOKEN`
  A token for interacting with the GitHub API. Pass `${{ secrets.GITHUB_TOKEN }}`!
