#!/usr/bin/env bash
# shellcheck shell=bash

# Sets Brave as the default browser via the `defaultbrowser` CLI (installed
# via the Brewfile: https://github.com/kerma/defaultbrowser). Depending on
# the macOS version, the system may still show a one-time confirmation
# dialog the first time this runs — that's a macOS restriction, not
# something the CLI (or this script) can suppress.
configure_default_browser() {
  if ! command -v defaultbrowser >/dev/null 2>&1; then
    echo "Skipping default browser; defaultbrowser CLI is not available"
    return
  fi

  local handlers=""
  handlers="$(defaultbrowser 2>/dev/null || true)"

  if grep -qiE '^\*.*brave' <<< "${handlers}"; then
    echo "Skipping default browser; Brave is already default"
    return
  fi

  if ! grep -qi brave <<< "${handlers}"; then
    echo "Skipping default browser; Brave wasn't found in 'defaultbrowser' output (is it installed?)"
    return
  fi

  echo "Setting Brave as the default browser..."
  defaultbrowser brave
}
