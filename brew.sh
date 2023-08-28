#!/usr/bin/env bash

# Install command-line tools using Homebrew.

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Check for Homebrew,
# Install if we don't have it
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade --all

# Install GNU core utilities (those that come with OS X are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
sudo ln -s /usr/local/bin/gsha256sum /usr/local/bin/sha256sum

# Install some other useful utilities like `sponge`.
brew install moreutils
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
brew install findutils
# Install GNU `sed`, overwriting the built-in `sed`.
brew install gnu-sed
# Install Bash 4.
brew install bash
brew install bash-completion2
# We installed the new shell, now we have to activate it
echo "Adding the newly installed shell to the list of allowed shells"
# Prompts for password
sudo bash -c 'echo /usr/local/bin/bash >> /etc/shells'
# Change to the new shell, prompts for password
chsh -s /usr/local/bin/bash


# Install Python
brew install python
brew install python3

# Install more recent versions of some OS X tools.
brew install vim --override-system-vi
brew install homebrew/dupes/grep
brew install homebrew/dupes/openssh
brew install homebrew/dupes/screen


# Install git and git-gui
brew install git
brew install git-gui
# Install tldr - nice utility for concise man pages
brew install tldr
# Install R
brew install R


# Install Casks
brew install --cask flux
brew install --cask gimp
brew install --cask spectacle
brew install --cask vlc
brew install --cask awareness
brew install --cask anaconda
brew install --cask handbrake
brew install --cask omnidisksweeper
brew install --cask syncthing
brew install --cask little-snitch
brew install --cask rstudio
brew install --cask firefox
brew install --cask skype
brew install --cask the-unarchiver
brew install --cask tor-browser
brew install --cask protonvpn
brew install --cask virtualbox
brew install --cask itsycal
brew install --cask brave
brew install --cask eqmac
brew install --cask visual-studio-code
brew install --cask amethyst
brew install --cask notunes
brew install --cask sync
brew install --cask anki
brew install --cask openaudible
brew install --cask google-chrome
brew install --cask openmtp
brew install --cask thunderbird
brew install --cask gpg-suite
brew install --cask protonmail-bridge
brew install --cask transmission
brew install --cask calibre
brew install --cask itsycal
brew install --cask cryptomator
brew install --cask joplin
brew install --cask signal
brew install --cask cyberduck
brew install --cask libreoffice
brew install --cask whatsapp
brew install --cask logseq
brew install --cask dash
brew install --cask exodus
brew install --cask spotify
brew install --cask fanny
brew install --cask zwift


# Remove outdated versions from the cellar.
brew cleanup
