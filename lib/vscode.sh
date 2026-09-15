#!/usr/bin/env bash
# shellcheck shell=bash

install_vscode_extensions() {
  local extensions=(
    "aaron-bond.better-comments"
    "abierbaum.vscode-file-peek"
    "adpyke.codesnap"
    "apollographql.vscode-apollo"
    "bradlc.vscode-tailwindcss"
    "christian-kohler.npm-intellisense"
    "christian-kohler.path-intellisense"
    "cweijan.dbclient-jdbc"
    "cweijan.vscode-mysql-client2"
    "daltonmenezes.aura-theme"
    "davidanson.vscode-markdownlint"
    "dbaeumer.vscode-eslint"
    "docker.docker"
    "donjayamanne.githistory"
    "eamodio.gitlens"
    "ecmel.vscode-html-css"
    "editorconfig.editorconfig"
    "enkia.tokyo-night"
    "esbenp.prettier-vscode"
    "formulahendry.auto-rename-tag"
    "github.copilot"
    "github.copilot-chat"
    "github.vscode-github-actions"
    "hollowtree.vue-snippets"
    "kisstkondoros.vscode-gutter-preview"
    "mechatroner.rainbow-csv"
    "mikestead.dotenv"
    "ms-azuretools.vscode-containers"
    "ms-azuretools.vscode-docker"
    "ms-ceintl.vscode-language-pack-fr"
    "ms-playwright.playwright"
    "ms-python.debugpy"
    "ms-python.python"
    "ms-python.vscode-pylance"
    "ms-python.vscode-python-envs"
    "ms-vscode-remote.remote-containers"
    "nataliefruitema.modern-purple-theme"
    "naumovs.color-highlight"
    "pkief.material-icon-theme"
    "pranaygp.vscode-css-peek"
    "sdras.night-owl"
    "sdras.vue-vscode-snippets"
    "steoates.autoimport"
    "streetsidesoftware.code-spell-checker"
    "unifiedjs.vscode-mdx"
    "visualstudioexptteam.intellicode-api-usage-examples"
    "visualstudioexptteam.vscodeintellicode"
    "vivaxy.vscode-conventional-commits"
    "vue.volar"
    "wallabyjs.console-ninja"
    "whizkydee.material-palenight-theme"
    "wix.vscode-import-cost"
    "xabikos.javascriptsnippets"
    "xdebug.php-debug"
    "xdebug.php-pack"
    "yoavbls.pretty-ts-errors"
    "zobo.php-intellisense"
  )

  if ! command -v code >/dev/null 2>&1; then
    echo "Skipping VS Code extensions; install the VS Code CLI and rerun ./init.sh"
    return
  fi

  local installed_extensions=""
  installed_extensions="$(code --list-extensions 2>/dev/null || true)"

  local extension
  for extension in "${extensions[@]}"; do
    if grep -Fqix "${extension}" <<< "${installed_extensions}"; then
      echo "Skipping ${extension}; already installed"
      continue
    fi

    code --install-extension "${extension}"
  done
}
