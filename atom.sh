# macOS
# atom.sh

# Backup old directory
mv -f "${HOME}/.atom" "${HOME}/.atom_backup"

# Remake directory for symlinking
mkdir "${HOME}/.atom"

# Symlink user configuration into place
ln -sF "${HOME}/dotfiles/.atom/"* "${HOME}/.atom"

apm install\
   busy-signal\
   intentions\
   linter\
   linter-clang\
   linter-eslint\
   linter-ui-default\
   oceanic-next\
   vim-mode-plus\
   vim-mode-plus-keymaps-for-surround
