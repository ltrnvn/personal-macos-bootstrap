#!/usr/bin/env bash
# shellcheck shell=bash

# Git identity (user.name/user.email) is derived from your GitHub account
# via gh, instead of being hardcoded here, so this repo doesn't carry
# personal info in plain text. init.defaultBranch / core.ignoreCase are
# intentionally left out rather than force-added — add them below if you
# want them set.
#
# This can require logging in to GitHub twice in the browser the first
# time: the default `gh auth login` scopes don't include `user:email`, and
# GitHub only returns your (possibly private) email to a token that
# explicitly holds that scope. So if the first login didn't grant it, a
# second consent screen (`gh auth refresh -s user:email`) is needed before
# your email can be read.
ensure_gh_identity_auth() {
  if ! command -v gh >/dev/null 2>&1; then
    echo "Skipping git identity setup; gh is not on PATH (check the Brewfile install)"
    return 1
  fi

  if ! gh auth status >/dev/null 2>&1; then
    echo "Not logged in to GitHub; opening browser to log in..."
    gh auth login --hostname github.com --git-protocol https --web
  fi

  if ! gh auth status 2>&1 | grep -q "'user:email'"; then
    echo "Missing the user:email scope (needed to read your GitHub email);"
    echo "opening browser again to grant it..."
    gh auth refresh --hostname github.com --scopes user:email --web
  fi
}

configure_git_defaults() {
  echo "Configuring git defaults..."

  if ensure_gh_identity_auth; then
    local gh_name gh_email
    gh_name="$(gh api user --jq '.name // .login' 2>/dev/null || true)"
    gh_email="$(gh api user/emails --jq '[.[] | select(.primary)][0].email' 2>/dev/null || true)"

    if [[ -n "${gh_name}" && "${gh_name}" != "null" ]]; then
      git config --global user.name "${gh_name}"
    else
      echo "Could not read a name from GitHub; set user.name manually"
    fi

    if [[ -n "${gh_email}" && "${gh_email}" != "null" ]]; then
      git config --global user.email "${gh_email}"
    else
      echo "Could not read an email from GitHub; set user.email manually"
    fi
  fi

  git config --global push.autoSetupRemote true
  git config --global pull.rebase false
  git config --global core.editor "zed --wait"
}
