#!/usr/bin/env bash
# shellcheck shell=bash

# Operator Mono is a commercial font with no Homebrew cask, so it's installed
# by copying the .otf files from an iCloud Drive backup (already
# purchased/licensed) into ~/Library/Fonts instead.
install_operator_mono() {
  local source_dir="${HOME}/Library/Mobile Documents/com~apple~CloudDocs/Documents/Dev/Backup/fonts/Operator-Mono-master/Fonts"
  local fonts_dir="${HOME}/Library/Fonts"

  if [[ ! -d "${source_dir}" ]]; then
    echo "Skipping Operator Mono; ${source_dir} not found (is iCloud Drive signed in and synced?)"
    return
  fi

  echo "Installing Operator Mono..."
  mkdir -p "${fonts_dir}"

  local font dest
  for font in "${source_dir}"/*.otf; do
    [[ -e "${font}" ]] || continue
    dest="${fonts_dir}/$(basename -- "${font}")"

    if [[ -e "${dest}" ]]; then
      echo "Skipping $(basename -- "${font}"); already installed"
      continue
    fi

    cp "${font}" "${dest}"
  done
}
