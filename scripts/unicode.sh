# unicode.sh

# Encode a Unicode character to its escape sequence
uce() {
  printf "\\\x%s" $(printf "${1}" | xxd -p -c1 -u)
  # print a newline unless we’re piping the output to another program
  if [ -t 1 ]; then
    printf "\n"
  fi;
}

# Decode a Unicode escape sequence to its character
ucd() {
  perl -e "binmode(STDOUT, ':utf8'); print \"${1}\"";
  # print a newline unless we’re piping the output to another program
  if [ -t 1 ]; then
    printf "\n"
  fi;
}

# Get a character its Unicode code point
ucp() {
  perl -e "use utf8; print sprintf('U+%04X', ord(\"${1}\"))";
  # print a newline unless we’re piping the output to another program
  if [ -t 1 ]; then
    printf "\n"
  fi;
}
