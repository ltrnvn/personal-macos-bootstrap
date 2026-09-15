# personal-macos-bootstrap Brewfile
# Run: brew bundle --file=Brewfile
#
# Goal: every app on this Mac is installed/updated through Homebrew, so a
# fresh machine never needs manually downloading apps one by one.

# Formulae
brew "defaultbrowser" # lib/browser.sh uses this to set Brave as the default
brew "dockutil"       # needed by lib/dock.sh (not installed yet, but required for it to work)
brew "gh"
brew "mas"            # Mac App Store installs below need this
brew "mise"
brew "pnpm"
brew "rtk"            # Rust Token Killer — see ~/.claude/RTK.md

# git itself is NOT listed here on purpose: this Mac uses Apple's system git
# (/usr/bin/git via Xcode Command Line Tools), not a Homebrew-managed one.

# Apps
cask "brave-browser"
cask "claude"       # desktop app — distinct from the "claude-code" CLI below
cask "claude-code"
cask "discord"
cask "figma"
cask "google-chrome"
cask "linear"
cask "nordvpn"
cask "notion"
cask "perplexity"
cask "proton-pass"
cask "rectangle"
cask "slack"
cask "visual-studio-code"
cask "warp"
cask "whatsapp"
cask "wkhtmltopdf"
cask "zed"

# Fonts (open-source ones with an official cask; Operator Mono is commercial
# and has no cask — lib/fonts.sh installs it from your own iCloud backup)
cask "font-cascadia-code"
cask "font-fira-code"
cask "font-geist"
cask "font-geist-mono"

# Mac App Store (needs `mas` above, and being signed in to the App Store)
mas "Intermission - Breaks For Eyes", id: 1439431081
