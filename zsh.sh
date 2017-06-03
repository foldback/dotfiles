# macOS
# zsh.sh
# Installs zim and symlinks zsh settings into place

# Install zim
git clone --recursive -j8 "https://github.com/jorvi/zim.git" "~/.zim" &&\
 sh -c "~/.zim/tools/zim_install"

# Symlink .zshrc
ln -sf "${HOME}/dotfiles/.zshrc" "${HOME}/.zshrc"

echo "zsh & zim configured!"
echo "Switch to 'Source Code Pro' font in Terminal!"
