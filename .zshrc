#!/usr/bin/env zsh
# .zshrc

# load Zim
if [[ -s "${ZDOTDIR:-${HOME}}/.zim/init.zsh" ]]; then
  source "${ZDOTDIR:-${HOME}}/.zim/init.zsh"
fi;

# Load the shell dotfiles
# ~/.private can be used for other settings you don’t want to commit.
for dotfile in ${HOME}/.{exports,aliases,functions,private}; do
  [ -r "${dotfile}" ] && source "${dotfile}"
done;
unset dotfile

# Load useful scripts
for script in ${HOME}/scripts/*.sh; do
  [ -r "${script}" ] && source "${script}"
done;
unset script

# History settings
# Filename for history file
export HISTFILE="${HOME}/.zsh_history"
# Allow 32³ entries in history buffer
export HISTSIZE="32768"
# Allow 32³ entries in history file
export SAVEHIST="${HISTSIZE}"
# Append into history file incrementally instead of write-on-exit
setopt SHARE_HISTORY
# Omit duplicates from history
setopt HIST_IGNORE_DUPS
# Omit commands that begin with a space from history
setopt HIST_IGNORE_SPACE
# Add timestamp for each entry
setopt EXTENDED_HISTORY

# CORRECT: try to correct the spelling of commands.
# CHECK_JOBS: report status of background jobs before exiting a shell
# MARK_DIRS: append trailing '/' to directory names resulting from filename generation.
# COMPLETE_ALIASES: Don't internally substitute alias before completion. Makes aliases a distinct command
# MENU_COMPLETE: on ambiguous completion insert-cycle through options. This option overrides AUTO_MENU.
for option in CORRECT CHECK_JOBS MARK_DIRS MENU_COMPLETE; do
  setopt "${option}" 2>/dev/null
done;
