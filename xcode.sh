# macOS
# .xcode

# Remove old theme directory
rm -Rf "${SUBLIME}/Packages/User"

# Symlink theme directory
ln -sF "${HOME}/dotfiles/resources/base16-oceanic-next/xcode4"\
 "${HOME}/Library/Developer/Xcode/UserData/FontAndColorThemes"
