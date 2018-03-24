# pasteofcode.sh

# Paste code online via PasteOfCode.org
# Takes either clipboard or file as input
# Example: `poc cpp` or `poc "cpp ~/project/test_c++_project.cpp"`
# Full language list: git.io/poclanguages
poc() {
  if [ ${#} -eq 1 ]; then
    if [ ! -z "$(pbpaste)" ]; then
      local Code="$(pbpaste)"
    else
      printf "Your clipboard is empty!"
      return 1
    fi;
  elif [ ${#} -eq 2 ]; then
    if [ -f "${2}" ]; then
      local Code="$(cat "${2}" 2>/dev/null)"
    else
      printf "Wrong filepath!\n"
      return 1
    fi;
  else
    printf "Too many paramaters!\n"
    return 1
  fi;
  local Language="${1}"
  local Pastelink="$(curl -s -L --form-string code="${Code}" \
    --form-string language="${Language}" --form-string notabot="most_likely" \
    -w "%{url_effective}\n" "https://paste.ofcode.org/" -o /dev/null)"
  if [ "${Pastelink}" = "https://paste.ofcode.org/" ]; then
    printf "Invalid code or language!\n"
    return 1
  fi;
  printf '%s' "${Pastelink}" | pbcopy
  printf '%s\n' "${Pastelink} copied to clipboard!"
}
