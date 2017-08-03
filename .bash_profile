#!/usr/bin/env bash
# macOS
# .bash_profile

# Load the shell dotfiles
# ~/.private can be used for other settings you don’t want to commit.
for dotfile in ${HOME}/.{bash_prompt,exports,aliases,functions,private}; do
  [ -r "${dotfile}" ] && source "${dotfile}"
done;
unset dotfile

# Load useful scripts
for script in ${HOME}/scripts/*.sh; do
  [ -r "${script}" ] && source "${script}"
done;
unset script

# Add tab completion for many Bash commands
# Check for Brew-installed bash completions first
if hash "brew" 2>/dev/null  && \
[ -f "$(brew --prefix)/share/bash-completion/bash_completion" ]; then
  source "$(brew --prefix)/share/bash-completion/bash_completion"
elif [ -f "/etc/bash_completion" ]; then
  source "/etc/bash_completion"
fi;

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
if [ -e "${HOME}/.ssh/config" ]; then
  complete -o "default" -o "nospace" -W "$(grep "^Host" ${HOME}/.ssh/config | \
  grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh
fi;

# History settings
# Filename for history file
export HISTFILE="${HOME}/.bash_history"
# Allow 32³ entries in history `buffer`
export HISTSIZE="32768"
# Allow 32³ entries in history file
export HISTFILESIZE="${HISTSIZE}"
# Omit duplicates and commands that begin with a space from history
export HISTCONTROL="ignoreboth:erasedups"
# Append instead of overwrite history file
shopt -s histappend

# Set `bash` options
# nocaseglob: Case-insensitive globbing (used in pathname expansion)
# cdspell: Autocorrect typos in path names when using `cd`
# autocd: **/qux` will enter `./foo/bar/baz/qux` <Bash 4 only>
# globstar: `echo **/*.txt` <Bash 4 only>
for option in nocaseglob cdspell autocd globstar; do
  shopt -s "${option}" 2>/dev/null
done;
