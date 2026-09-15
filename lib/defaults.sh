#!/usr/bin/env bash
# shellcheck shell=bash

# The macOS defaults this bootstrap applies. A couple of possible tweaks
# (Dock minimize-to-application, not writing .DS_Store on network/USB
# volumes) are intentionally left out — add them below if you want them.
configure_defaults() {
  echo "Configuring macOS defaults..."

  # Finder: default to column view
  defaults write com.apple.finder FXPreferredViewStyle -string "clmv"

  # Finder: show all filename extensions
  defaults write NSGlobalDomain AppleShowAllExtensions -bool true

  # Dock: tile size
  defaults write com.apple.dock tilesize -int 43

  # Dock: hide recent applications
  defaults write com.apple.dock show-recents -bool false

  # Dock: magnification on hover
  defaults write com.apple.dock magnification -bool true
  defaults write com.apple.dock largesize -int 85

  # Dock: don't rearrange Spaces based on most recent use
  defaults write com.apple.dock mru-spaces -bool false

  # Trackpad: tracking speed
  defaults write NSGlobalDomain com.apple.trackpad.scaling -float 2.5

  killall Finder >/dev/null 2>&1 || true
  killall Dock >/dev/null 2>&1 || true
}
