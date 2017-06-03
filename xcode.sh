# macOS
# .xcode

# Backup old theme directory
mv -f "${HOME}/Library/Developer/Xcode/UserData/FontAndColorThemes"\
 "${HOME}/Library/Developer/Xcode/UserData/FontAndColorThemes_backup"

# Remake directory for symlinking
mkdir "${HOME}/Library/Developer/Xcode/UserData/FontAndColorThemes"

# Symlink theme directory
ln -sF "${HOME}/dotfiles/resources/themes/Oceanic_Next_Xcode.dvtcolortheme"\
 "${HOME}/Library/Developer/Xcode/UserData/FontAndColorThemes/Oceanic_Next_Xcode.dvtcolortheme"
