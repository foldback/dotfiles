# macOS
# spectacle.sh
# Symlinks Spectacle shortcuts file into place

# Open Sublime Text to create User directory
open -a "Spectacle" && osascript -e 'quit app "Spectacle"' && sleep 5

# Remove default/old shortcuts
rm -f "${HOME}/Library/Application Support/Spectacle/Shortcuts.json"
# Symlink our shortcuts
ln -sF "${HOME}/dotfiles/resources/Shortcuts.json"\
 "${HOME}/Library/Application Support/Spectacle/Shortcuts.json"

echo "Spectacle shortcuts changed!"
