#!/usr/bin/env bash
# shellcheck shell=bash

# Léon uses mise (installed via the Brewfile) for tool version management,
# including Node — pinned globally in ~/.config/mise/config.toml (currently
# `poetry` and `node = "lts"`) and loaded via `mise activate` in .zshrc.
# This only ensures mise's global pins are installed; add tools to that
# config file to have them installed here too.
setup_mise() {
  if ! command -v mise >/dev/null 2>&1; then
    echo "Skipping mise setup; mise is not on PATH (check the Brewfile install)"
    return
  fi

  echo "Installing mise-pinned tools..."
  mise install
}
