# macOS
# vscode.sh
# Sets up Visual Studio Code

# Open Visual Studio Code to create User directory
open -a "Sublime Text" && osascript -e 'quit app "Sublime Text"' && sleep 5

# Remove old User directory
rm -Rf "${HOME}/Library/Application Support/Code/User"
# Symlink User directory
ln -sF "${HOME}/dotfiles/.vscode/User" "${HOME}/Library/Application Support/\
Code/User"

# Install extensions
code --install-extension dbaeumer.vscode-eslint
code --install-extension donjayamanne.python
code --install-extension joshpeng.theme-charcoal-oceanicnext
code --install-extension ms-vscode.cpptools
code --install-extension vscodevim.vim

# Use a more modern icon
npm install -g fileicon
fileicon rm '/Applications/Visual Studio Code.app'
fileicon set '/Applications/Visual Studio Code.app' resources/vscode.icns
npm uninstall -g fileicon

echo "Visual Studio Code configured!"
