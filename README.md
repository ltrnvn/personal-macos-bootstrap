# personal-macos-bootstrap

Personal macOS bootstrap script for setting up a new machine.

Goal: every app gets installed through Homebrew, so setting up a new Mac
never means manually downloading and dragging apps into `/Applications`
one by one.

## Usage

```bash
bash ./init.sh
```

The script is designed to be rerun. It skips installed Homebrew formulae,
casks, and VS Code extensions when possible.

## What it does

- Installs Homebrew if missing, then `brew update` / `brew upgrade`
- Installs every formula/app in [`Brewfile`](Brewfile) via `brew bundle`,
  including Mac App Store apps via `mas` (needs a signed-in App Store account)
- Installs mise-pinned tools ([`lib/mise.sh`](lib/mise.sh)), including Node —
  pins live in `~/.config/mise/config.toml` (currently `poetry` and
  `node = "lts"`)
- Installs the VS Code extensions listed in [`lib/vscode.sh`](lib/vscode.sh)
- Applies the macOS `defaults` this bootstrap sets ([`lib/defaults.sh`](lib/defaults.sh))
- Configures the Dock order ([`lib/dock.sh`](lib/dock.sh))
- Sets Brave as the default browser ([`lib/browser.sh`](lib/browser.sh)) via
  the `defaultbrowser` CLI — macOS may still prompt for a one-time
  confirmation the first time
- Installs Operator Mono ([`lib/fonts.sh`](lib/fonts.sh)) by copying it from
  an iCloud Drive backup — it's a commercial font with no Homebrew cask,
  unlike the open-source dev fonts (Cascadia Code, Fira Code, Geist,
  Geist Mono) which are in the [`Brewfile`](Brewfile) instead
- Sets git config ([`lib/git.sh`](lib/git.sh)) with Zed (`zed --wait`) as
  `core.editor` — `user.name`/`user.email` are read from your GitHub
  account via `gh` rather than hardcoded, which may need logging in to
  GitHub twice in the browser the first time (see the comment in
  `lib/git.sh` for why)
- Installs oh-my-zsh if missing (via its official unattended install script —
  it has no Homebrew formula) ([`lib/zshrc.sh`](lib/zshrc.sh)), then updates
  `.zshrc`: oh-my-zsh, brew PATH, pnpm's global bin dir (`PNPM_HOME`), mise
  activation (Node included), the dashboard-frontend/dashboard-backend env
  vars and aliases
- Prints manual follow-up steps ([`lib/postflight.sh`](lib/postflight.sh))

## Prerequisites

- macOS only
- An internet connection
