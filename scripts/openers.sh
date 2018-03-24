# macOS
# openers.sh

# Create a new directory and enter it
mkedir() {
  mkdir -p "${@}" && cd "${_}"
}

# Open Finder working directory in shell
# Short for `cdfinder`
cdf() {
  cd "$(osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)')"
}

# Open shell working directory in Finder
fcd() {
  open . -R
}

# `o` with no arguments opens the current directory, otherwise opens the given
# location
o() {
  if [ ${#} -eq 0 ]; then
    open .
  else
    open "${@}"
  fi;
}

# `s` with no arguments opens the current directory in Sublime Text, otherwise
# opens the given location
s() {
  if [ ${#} -eq 0 ]; then
    subl .
  else
    subl "${@}"
  fi;
}

# `v` with no arguments opens the current directory in Vim, otherwise opens the
# given location
v() {
  if [ ${#} -eq 0 ]; then
    vim .
  else
    vim "${@}"
  fi;
}

# `c` with no arguments opens the current directory in Visual Studio Code
# otherwise opens the given location
c() {
  if [ ${#} -eq 0 ]; then
    code .
  else
    code "${@}"
  fi;
}

# `a` with no arguments opens the current directory in Atom, otherwise
# opens the given location
a() {
  if [ ${#} -eq 0 ]; then
    atom .
  else
    atom "${@}"
  fi;
}