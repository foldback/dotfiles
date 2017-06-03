# macOS
# .xcode

# Remove old theme directory
rm -Rf "${HOME}/Library/Developer/Xcode/UserData/FontAndColorThemes"

# Remake directory for symlinking
mkdir "${HOME}/Library/Developer/Xcode/UserData/FontAndColorThemes"

# Symlink theme directory
ln -sF "${HOME}/dotfiles/resources/themes/Oceanic_Next_Xcode.dvtcolortheme"\
 "${HOME}/Library/Developer/Xcode/UserData/FontAndColorThemes/Oceanic_Next_Xcode.dvtcolortheme"
