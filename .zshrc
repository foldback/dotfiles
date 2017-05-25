# .zshrc

# load Zim
if [[ -s "${ZDOTDIR:-${HOME}}/.zim/init.zsh" ]]; then
  source "${ZDOTDIR:-${HOME}}/.zim/init.zsh"
fi;

# Load the shell dotfiles
# * ${HOME}/.path can be used to extend `$PATH`.
# * ${HOME}/.extra can be used for other settings you don’t want to commit.
for file in ${HOME}/.{path,exports,aliases,functions,extra}; do
  [ -r "${file}" ] && [ -f "${file}" ] && source "${file}"
done;
unset file
