# websniffers.sh

# View HTTP traffic
httpsniff() {
  if hash "ngrep" 2>/dev/null; then
    sudo ngrep -d 'en0' -t '^(GET|POST) ' 'tcp and port 80'
  else
    printf "'ngrep' not available!\n"
  fi;
}

# Dump HTTP traffic
httpdump() {
  sudo tcpdump -i en0 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\"
}

# Dump Wi-Fi traffic
# `wifidump 6` to dump channel 6
wifidump() {
  local airport="/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport"
  while [ "${#}" -gt 0 ]; do
  # Check if first argument is an option
    case "${1}" in
    -s|--stop)
      kill "${wifidumpPID}"
      break
    ;;
    -*)
      printf "Invalid option: ${1}\n"
      return 1
    ;;
    *)
    ( sudo "${airport}" "en0" sniff "${1}" ) &
    wifidumpPID="${!}"
    ;;
    esac
  shift
  done
}
