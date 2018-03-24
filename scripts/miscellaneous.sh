# miscellaneous.sh


# Determine size of a file or total size of a directory
size() {
  if du -b /dev/null >/dev/null 2>&1; then
    local Arg=-sbh
  else
    local Arg=-sh
  fi;
  if [ -n "${1}" ]; then
    du ${Arg} -- "${1}"
  else
    du ${Arg} .[^.]* ./*
  fi;
}

# Use Git’s colored diff when available
if hash git >/dev/null 2>&1; then
  diff() {
    git diff --no-index --color-words "${@}"
  }
fi;

# `trees` is `tree` with hidden files and color enabled, ignoring
# the `.git` directory, listing directories first. The output gets piped into
# `less` with options to preserve color and line numbers, unless the output is
# small enough for one screen.
trees() {
  tree -aC -I '.git | node_modules | bower_components' --dirsfirst "${@}" | less -FRNX
}


# Syntax-highlight JSON strings or files
# Usage: `json '{"foo":42}'` or `echo '{"foo":42}' | json`
json() {
  if [ -t 0 ]; then # argument
    python -mjson.tool <<< "$*" | pygmentize -l javascript
  else # pipe
    python -mjson.tool | pygmentize -l javascript
  fi;
}
