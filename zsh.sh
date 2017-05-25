# macOS
# zsh.sh
# Installs zim and symlinks zsh settings into place

# Install zim
sh -c "$(curl -fsSL --proto-redir -all,https https://raw.githubusercontent.com/jorvi/zim/master/tools/zim_install)"

# Change theme to `pure`
sed -i "" 's/steeef/pure/g' "${HOME}/.zimrc"

# Symlink .zshrc
ln -sf "${HOME}/dotfiles/.zshrc" "${HOME}/.zshrc"

echo "zsh & zim configured!"
echo "Switch to 'Source Code Pro' font and 'B16 Ocean Next' theme in Terminal"
