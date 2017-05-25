# macOS
# utildotfiles.sh
# Symlinks utility dotfiles into place

# Ask for the administrator password upfront if needed
if [ ! "${UID}" = 0 ]; then
  sudo -v
fi;

# Keep-alive: update existing 'sudo' time stamp until script has finished
while true;do sudo -n true;sleep 60;kill -0 "$$" || exit;done 2>/dev/null &

# Symlink dotfiles into place
ln -sf "${HOME}/dotfiles/.aliases" "${HOME}/.aliases"
ln -sf "${HOME}/dotfiles/.curlrc" "${HOME}/.curlrc"
ln -sf "${HOME}/dotfiles/.editorconfig" "${HOME}/.editorconfig"
ln -sf "${HOME}/dotfiles/.eslintrc" "${HOME}/.eslintrc"
ln -sf "${HOME}/dotfiles/.exports" "${HOME}/.exports"
ln -sf "${HOME}/dotfiles/.functions" "${HOME}/.functions"
ln -sf "${HOME}/dotfiles/.gitconfig" "${HOME}/.gitconfig"
ln -sf "${HOME}/dotfiles/.gitignore_global" "${HOME}/.gitignore_global"
ln -sf "${HOME}/dotfiles/.gitattributes_global" "${HOME}/.gitattributes_global"
ln -sf "${HOME}/dotfiles/.gpg_a" "${HOME}/.gpg_a"
ln -sf "${HOME}/dotfiles/.hushlogin" "${HOME}/.hushlogin"
ln -sf "${HOME}/dotfiles/.wgetrc" "${HOME}/.wgetrc"

echo "All utility dotfile symlinks in place!"
