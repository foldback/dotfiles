# macOS
# brew.sh
# installs Homebrew package manager & packages

# Install Homebrew if not yet installed
if [ ! "$(which -s brew)" = 0 ]; then
  # Ask for the administrator password upfront if needed
  if [ ! "${UID}" = 0 ]; then
    sudo -v
  fi;
  # Installation
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi;

# Turn off Homebrew analytics
#brew analytics off

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed packages.
brew upgrade

# Binaries
brew install\
   android-platform-tools\
   wget --with-iri

# GPG
brew install\
   gnupg\
   pinentry-mac

# Update macOS CLI utilities
brew install\
   vim --with-override-system-vi

# Install up-to-date language frameworks
brew install\
   npm\
   perl\
   python\
   python3\
   ruby

# Apps
# Tap apps
brew tap caskroom/cask
# Install apps
brew cask install\
   1password\
   airparrot\
   calibre\
   dropbox\
   etcher\
   fork\
   google-chrome\
   iterm2\
   spectacle\
   spotify\
   the-unarchiver\
   transmission\
   viscosity\
   vlc\
   visual-studio-code\
   whatsapp
echo "macOS apps installed!"

# Tap fonts
brew tap caskroom/fonts
# Install `Source Code Pro` font
brew cask install font-source-code-pro

# Remove outdated versions from the cellar.
brew cleanup

echo "Homebrew and packages installed!"
