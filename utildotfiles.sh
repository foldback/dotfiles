# macOS
# utildotfiles.sh
# Places utility dotfiles

# Symlink dotfiles into place
for DOTFILE in ${HOME}/dotfiles/.{aliases,curlrc,editorconfig,eslintrc,exports\
,functions,gitattributes_global,gitignore_global,hushlogin,wgetrc}; do
  ln -sf "${FILE}" "${HOME}/"
done;
unset DOTFILE

# Modified by .extra so can't be a symlink
cp -f "${HOME}/dotfiles/.gitconfig" "${HOME}/.gitconfig"

echo "All utility dotfile symlinks in place!"
