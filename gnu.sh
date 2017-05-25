# macOS
# gnu.sh
# Installs GNU utilities on macOS
# duplicate utilities are aliased with `g` prefixed
# e.g. `ggrep` `gwget`

# Install GNU utilities (the macOS versions are less capable)
brew tap homebrew/dupes
brew install \
  binutils \
  coreutils \
  diffutils \
  findutils \
  ed \
  gawk \
  gnutls \
  grep \
  gzip \
  gnu-indent \
  gnu-sed \
  gnu-tar \
  gnu-which \
  moreutils \
  screen \
  watch \
  wdiff --with-gettext \
  wget

echo "GNU utilties installed!"
