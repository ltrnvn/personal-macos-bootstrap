#!/usr/bin/env bash
# shellcheck shell=bash

configure_dock() {
  local dock_items=(
    "/System/Applications/Mail.app"
    "/Applications/Claude.app"
    "/System/Applications/Messages.app"
    "/Applications/Brave Browser.app"
    "/System/Applications/Notes.app"
    "/Applications/Slack.app"
    "/System/Applications/Calendar.app"
    "/System/Applications/Reminders.app"
    "/Applications/Notion.app"
    "/Applications/Figma.app"
    "/Applications/Warp.app"
    "/Applications/Linear.app"
    "/Applications/Perplexity.app"
    "/Applications/Zed.app"
  )

  if ! command -v dockutil >/dev/null 2>&1; then
    echo "Skipping Dock configuration; dockutil is not available"
    return
  fi

  echo "Configuring Dock..."
  dockutil --remove all --no-restart

  local app_path
  for app_path in "${dock_items[@]}"; do
    if [[ ! -d "${app_path}" ]]; then
      echo "Skipping Dock item ${app_path}; app not found"
      continue
    fi

    dockutil --add "${app_path}" --no-restart
  done

  killall Dock >/dev/null 2>&1 || true
}
