# macOS
# vim.sh
# Symlinks Vim configs into place
# Can't place symlink in repo due to way GitHub handles symlinks

# Backup pre-existing directories
mv -f "${HOME}/.vim" "${HOME}/.vim_backup"

# Symlink Vim
ln -sF "${HOME}/dotfiles/.vim" "${HOME}/.vim"

echo "Vim configured!"
