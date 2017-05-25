# macOS
# setup.sh
# Fresh setup script

# Ask for the administrator password upfront if needed
if [ ! "${UID}" = 0 ]; then
  sudo -v
fi;

# Keep-alive: update existing 'sudo' time stamp until script has finished
while true;do sudo -n true;sleep 60;kill -0 "$$" || exit;done 2>/dev/null &

# The order of these scripts matters!
"${HOME}/dotfiles/brew.sh"
"${HOME}/dotfiles/node.sh"
"${HOME}/dotfiles/python.sh"
"${HOME}/dotfiles/ruby.sh"
"${HOME}/dotfiles/zsh.sh"
"${HOME}/dotfiles/sublimetext.sh"
"${HOME}/dotfiles/vim.sh"
"${HOME}/dotfiles/vscode.sh"
"${HOME}/dotfiles/vlc.sh"
"${HOME}/dotfiles/utildotfiles.sh"
"${HOME}/dotfiles/macos.sh"
"${HOME}/dotfiles/duti.sh"

echo "Remember to run the Dropbox script after you've logged in to Dropbox!"
echo "Done! You should probably reboot now.."
