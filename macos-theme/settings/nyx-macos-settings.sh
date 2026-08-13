#!/bin/sh

set -eu

# Native, reversible macOS appearance preferences. These values deliberately
# avoid accessibility, security, Dock-layout, wallpaper, and icon mutations.
# On Tahoe, choose Liquid Glass: Tinted and Icon & widget style: Dark -> Always
# manually in System Settings. Those controls are not stable `defaults` keys.
defaults write NSGlobalDomain AppleInterfaceStyle -string "Dark"
defaults write NSGlobalDomain AppleAccentColor -int 5
defaults write NSGlobalDomain AppleHighlightColor -string "0.713725 0.611765 1.000000 Nyx Violet"
defaults write NSGlobalDomain AppleReduceDesktopTinting -bool false
defaults write NSGlobalDomain AppleShowScrollBars -string "WhenScrolling"
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 2

killall Finder 2>/dev/null || true
killall Dock 2>/dev/null || true

printf '%s\n' "Nyx macOS appearance applied. Sign out and back in if an app keeps its previous accent colour."
