#!/usr/bin/env bash
# shellcheck shell=bash

# Appends (idempotently, between markers) the shell customizations this
# bootstrap sets up in ~/.zshrc: oh-my-zsh, brew PATH setup, pnpm's
# global bin dir (PNPM_HOME — separate from the Homebrew-installed pnpm
# binary itself, and needed for `pnpm add -g` output to be on PATH), mise
# activation (which also provides Node — see lib/mise.sh), this project's
# Keycloak env vars, and the dashboard-frontend/dashboard-backend workflow
# aliases.
ensure_bootstrap_zshrc_block() {
  local zshrc_path="$1"
  local start_marker="# >>> personal-macos-bootstrap >>>"
  local end_marker="# <<< personal-macos-bootstrap <<<"

  echo "Updating ${zshrc_path}..."
  local tmp_file
  tmp_file="$(mktemp)"

  # Trailing blank lines are buffered and dropped at EOF so the blank line
  # printed before the start marker does not accumulate across reruns.
  awk -v start="${start_marker}" -v end="${end_marker}" '
    BEGIN {
      in_block = 0
      pending = 0
    }
    index($0, start) == 1 {
      in_block = 1
      next
    }
    index($0, end) == 1 {
      in_block = 0
      next
    }
    in_block == 0 {
      if ($0 ~ /^[[:space:]]*$/) {
        blanks[++pending] = $0
        next
      }
      for (i = 1; i <= pending; i++) {
        print blanks[i]
      }
      pending = 0
      print
    }
  ' "${zshrc_path}" > "${tmp_file}"

  cat <<'EOF' >> "${tmp_file}"

# >>> personal-macos-bootstrap >>>
# Remove last login message on terminal startup
printf '\33c\e[3J'

# oh-my-zsh
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME=cloud
plugins=(git)
source $ZSH/oh-my-zsh.sh

# brew
export PATH=/opt/homebrew/bin:$PATH

# poetry
export PATH=$HOME/.local/bin:$PATH

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME/bin:"*) ;;
  *) export PATH="$PNPM_HOME/bin:$PATH" ;;
esac
# pnpm end

# mise
eval "$(mise activate zsh)"

# dashboard-frontend / dashboard-backend env vars
export VITE_KEYCLOAK_URL=http://localhost:8180
export VITE_KEYCLOAK_REALM=patrowl
export VITE_KEYCLOAK_CLIENTID=dashboard

# dashboard-frontend / dashboard-backend aliases
alias gitclean='git fetch origin --prune && git remote update origin --prune && git pull'
alias gcod='git checkout develop && git pull'
alias startback='cd ~/Code/dashboard-backend && uv run python manage.py runserver 0.0.0.0:8005'
alias stopback='pkill -f "manage.py runserver 0.0.0.0:8005"'
alias startbackservices='cd ~/Code/dashboard-backend && docker compose -f compose.yml --profile keycloak-dev up -d --no-build --remove-orphans --scale backend=0 && uv run python manage.py runserver 0.0.0.0:8005'
alias generateschema='cd ~/Code/dashboard-backend && DEBUG=True poetry run python manage.py spectacular --color --file ~/Code/dashboard-frontend/openapi.json --validate --format openapi-json && cd ~/Code/dashboard-frontend && pnpm run generate:client-api'
alias startfront='cd ~/Code/dashboard-frontend && pnpm run dev'

# zed
export LAUNCH_EDITOR="zed"
# <<< personal-macos-bootstrap <<<
EOF

  mv "${tmp_file}" "${zshrc_path}"
}


# oh-my-zsh has no Homebrew formula, so it's installed via its own official
# unattended install script instead.
install_oh_my_zsh() {
  if [[ -d "${HOME}/.oh-my-zsh" ]]; then
    echo "Skipping oh-my-zsh; already installed"
    return
  fi

  echo "Installing oh-my-zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
}

configure_zshrc() {
  local zshrc_path="${HOME}/.zshrc"

  install_oh_my_zsh
  touch "${zshrc_path}"
  ensure_bootstrap_zshrc_block "${zshrc_path}"
}
