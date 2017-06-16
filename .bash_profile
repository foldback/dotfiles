# macOS
# .bash_profile

# Load the shell dotfiles, and then some:
# ~/.private can be used for other settings you don’t want to commit.
for Dotfile in ~/.{bash_prompt,exports,aliases,functions,private}; do
  [ -r "${Dotfile}" ] && [ -f "${Dotfile}" ] && source "${Dotfile}"
done;
unset Dotfile

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

# Enable some Bash 4 features when possible:
# `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# Recursive globbing, e.g. `echo **/*.txt`
for Option in autocd globstar; do
  shopt -s "${Option}" 2>/dev/null
done;

# Add tab completion for many Bash commands
# Check for Brew-installed bash completions first
if hash "brew" 2>/dev/null  && \
[ -f "$(brew --prefix)/share/bash-completion/bash_completion" ]; then
  source "$(brew --prefix)/share/bash-completion/bash_completion"
elif [ -f /etc/bash_completion ]; then
  source /etc/bash_completion
fi;

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
if [ -e "${HOME}/.ssh/config" ]; then
  complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | \
  grep -v "[?*]" | cut -d " " -f2- | \
  tr ' ' '\n')" scp sftp ssh
fi;

# History settings
# .shell_history is shared with zsh!
# Filename for history file
export HISTFILE="${HOME}/.shell_history"
# Allow 32³ entries in history `buffer`
export HISTSIZE="32768"
# Allow 32³ entries in history file
export HISTFILESIZE="${HISTSIZE}"
# Omit duplicates and commands that begin with a space from history
export HISTCONTROL="ignoreboth:erasedups"
# Append instead of overwrite history file
shopt -s histappend
