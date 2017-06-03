# macOS
# sublimetext.sh
# Symlinks Sublime Text user settings into place

# Open Sublime Text to create User directory
open -a "Sublime Text" && sleep 5 && osascript -e 'quit app "Sublime Text"'

# Lazy
SUBLIME="${HOME}/Library/Application Support/Sublime Text 3"

# Backup old User directory
mv -f "${SUBLIME}/Packages/User" "${SUBLIME}/Packages/User_backup"
# Symlink User directory
ln -sF "${HOME}/dotfiles/.sublimetext/User" "${SUBLIME}/Packages"


# Install latest Package Control
mkdir "${SUBLIME}/Installed Packages"
curl -o "${SUBLIME}/Installed Packages/Package Control.sublime-package"\
 "https://packagecontrol.io/Package%20Control.sublime-package"

unset SUBLIME

# Use a more modern icon
npm install -g fileicon
fileicon rm '/Applications/Sublime Text.app'
fileicon set '/Applications/Sublime Text.app' "${HOME}/dotfiles/resources/sublimetext.icns"
npm uninstall -g fileicon

echo "Sublime Text configured!"
