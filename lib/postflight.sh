#!/usr/bin/env bash
# shellcheck shell=bash

print_postflight_steps() {
  cat <<'EOF'

Bootstrap finished. Manual steps:

- Sign in to Proton Pass
- Restart your terminal (or `source ~/.zshrc`) to pick up mise and the
  other shell changes
- Open VS Code once if you need to finish CLI setup
- Open Zed once and run "Install CLI" from its command palette so the `zed`
  binary (used as `core.editor` and `$LAUNCH_EDITOR`) is on PATH
- Sign in to the Mac App Store before running (or rerunning) this script if
  you want the `mas` entries in Brewfile to install; if you're not signed
  in, brew bundle skips them and prints a message instead of failing
  outright

EOF
}
