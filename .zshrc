# .zshrc

# load Zim
if [[ -s "${ZDOTDIR:-${HOME}}/.zim/init.zsh" ]]; then
  source "${ZDOTDIR:-${HOME}}/.zim/init.zsh"
fi;

# Load the shell dotfiles
# ~/.private can be used for other settings you don’t want to commit.
for Dotfile in ${HOME}/.{exports,aliases,functions,private}; do
  [ -r "${Dotfile}" ] && [ -f "${Dotfile}" ] && source "${Dotfile}"
done;
unset Dotfile

# History settings
# .shell_history is shared with `bash`!
# Filename for history file
export HISTFILE="${HOME}/.shell_history"
# Allow 32³ entries in history buffer
export HISTSIZE="32768"
# Allow 32³ entries in history file
export SAVEHIST="32768"
# Append into history file incrementally instead of write-on-exit
setopt SHARE_HISTORY
# Omit duplicates from history
setopt HIST_IGNORE_DUPS
# Omit commands that begin with a space from history
setopt HIST_IGNORE_SPACE
# Add timestamp for each entry
# Sharing .shell_history with `bash` requires disabled timestamps
unsetopt EXTENDED_HISTORY
