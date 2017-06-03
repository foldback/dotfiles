# macOS
# brew.sh
# installs Homebrew package manager & packages

# Ask for the administrator password upfront if needed
if [ ! "${UID}" = 0 ]; then
  sudo -v
fi;

# Keep-alive: update existing 'sudo' time stamp until script has finished
while true;do sudo -n true;sleep 60;kill -0 "$$" || exit;done 2>/dev/null &

# Install Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/\
install/master/install)"

# Disable Homebrew (Google-powered) analytics
#brew analytics off

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed packages.
brew upgrade

# Binaries
# Install Brew packages
brew install \
  # ADB and Fastboot
  android-platform-tools \
  # with unicode URL support
  wget --with-iri \
  # GPG and keychain bridge
  gnupg \
  pinentry-mac

# Update macOS CLI utilities
brew install \
  # Vim 8.0 for async support
  vim --with-override-system-vi

# Install up-to-date language frameworks
brew install \
  npm \
  perl \
  python \
  python3 \
  ruby

# Apps
# Tap apps
brew tap caskroom/cask
# Install apps
brew cask install \
  1password \
  airparrot \
  calibre \
  dropbox \
  etcher \
  fork \
  google-chrome \
  iterm2 \
  spectacle \
  spotify \
  sublime-text \
  the-unarchiver \
  transmission \
  viscosity \
  vlc \
  visual-studio-code \
  whatsapp
echo "macOS apps installed!"

# Tap fonts
brew tap caskroom/fonts
# Install `Source Code Pro` font
brew cask install font-source-code-pro

# Remove outdated versions from the cellar.
brew cleanup

echo "Homebrew and packages installed!"
