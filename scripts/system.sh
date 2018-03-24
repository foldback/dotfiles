# macOS
# system.sh


# Get updates for macOS, Homebrew, NPM, Ruby and their respective packages
updateall() {
  printf "Updating packages: "
  printf "macOS "
  ( sudo softwareupdate -i -a ) >/dev/null 2>&1
  printf "Homebrew "
  ( brew update && brew upgrade && brew cleanup ) >/dev/null 2>&1
  printf "Node "
  ( npm install npm@latest -g && npm update -g && npm cache clean --force ) >/dev/null 2>&1
  printf "Ruby "
  ( sudo gem update --system && sudo gem update && sudo gem cleanup ) >/dev/null 2>&1
  printf "done!\n"
}

# Easy volume manipulation
vol() {
  osascript \
  -e 'on run(argv)' \
    -e 'set volume output volume (item 1 of argv)' \
  -e 'end run' "${1}"
}

# For Linux
#vol() {
#  pactl set-sink-volume 0 "${1}%"
#}

# Spoof MAC address
# Spoofed until reboot
spoofmac() {
  local airport="/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport"
  local random_mac_address="$(printf '%02x:%02x:%02x:%02x:%02x:%02x\n' $((RANDOM%256)) $((RANDOM%256)) $((RANDOM%256)) $((RANDOM%256)) $((RANDOM%256)) $((RANDOM%256)))"
  sudo ifconfig en0 ether "${random_mac_address}" && printf "MAC spoofed!\n" || printf "Couldn't spoof MAC!\n"
  # Disassociating from network is necessary to propogate our new MAC
  sudo "${airport}" -z
}

# Test internet speeds
speedtest() {
  # Output to /dev/null ignores disk IO
  local downspeed=$(curl --progress-bar -w "%{speed_download}" http://cachefly.cachefly.net/100mb.test -o /dev/null)
  # `curl` outputs speed as a float
  local int_downspeed=${downspeed%.*}
  # in bytes per second, we want megabit
  printf "Your current download speed is ~$((int_downspeed / 125000 )) Mbps! \n"
}

# Supercleaner
# http://tinyurl.com/bksb7br
emptyall() {
  # Empty the Trash on all mounted volumes
  sudo rm -Rfv /Volumes/*/.Trashes
  sudo rm -Rfv "${HOME}/.Trash"
  # Clear Apple’s System Logs to improve shell startup speed
  sudo rm -Rfv /private/var/log/asl/*.asl
  # Clear download history from quarantine
  sqlite3 ${HOME}/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* \
  'delete from LSQuarantineEvent'
}

# Delete all '.DS_Store' files
# Resets folder-specific UI preferences
ds_clean() {
  sudo find / -name ".DS_Store" -depth -exec rm {} \;
}

# Clean up duplicate 'open with' entries
ls_clean() {
  /System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user
}

lockscr() {
  if [ "$(defaults read com.apple.screensaver askForPasswordDelay 2>/dev/null)" ]; then
    local Olddelay="$(defaults read com.apple.screensaver askForPasswordDelay)"
    defaults write com.apple.screensaver askForPasswordDelay -int 0 && \
    pmset displaysleepnow
    printf "Screen locked!\n"
    defaults write com.apple.screensaver askForPasswordDelay -int "${Olddelay}"
  else
    defaults write com.apple.screensaver askForPasswordDelay -int 0 && \
    pmset displaysleepnow
    printf "Screen locked!\n"
    defaults delete com.apple.screensaver askForPasswordDelay
  fi;
}

# Fix `Address Book` wakelock
#fixab() {
#  ( pmset -g | grep "AddressBookSourceSync" && \
#  setopt rmstarsilent # `rmstarsilent` prevents zsh nagging
#  rm -Rf "${HOME}/Library/Caches/com.apple.AddressBookSourceSync/"* && \
#  rm -Rf "${HOME}/Library/Application Support/AddressBook/"* && \
#  unsetopt rmstarsilent # but it's a nice safety feature
#  killall "AddressBookSourceSync" ) >/dev/null 2>&1 && \
#  printf "Address Book wakelock fixed!\n" || printf "Fixing Address Book wakelock failed!\n"
#}

# Get an application its bundle identifier (com.apple.keychainaccess)
# Usage: `bundleid "Keychain Access"`
bundleid() {
  # Conditional is needed because non-existing apps will otherwise cause 'where is App located?' popups
  if [ "$(find -L "/Applications" -maxdepth 3 -type d -name "${1}.app" -print -quit)" ] \
  || [ "$(find -L "/System/Library/CoreServices" -maxdepth 2 -type d -name "${1}.app" -print -quit)" ]; then
    osascript \
      -e 'on run(argv)' \
        -e 'id of application (item 1 of argv)' \
      -e 'end run' "${1}"
  else
    printf "Application '${1}' could not be located!\n"
  fi;
}

# Make bootable USB
# Usage: `mkusb ~/Downloads/fedora.iso disk2`
#mkusb() {
#  # Unmount disk if still mounted
#  if [ "$(mount | grep "${2}")" ]; then umount -f ${2}; fi;
#  # Use OS-compatible 'bs'
#  if [ "$(uname)" = "Linux" ]; then bs=1M; else bs=1m; fi;
#  sudo dd if="${1}" of="/dev/r${2}" bs=${bs}
#}

# Set firmware password
# Usage: 'fwpwd'
fwpwd() {
  # Mount recovery disk
  diskutil mount "Recovery HD" 1>/dev/null && wait
  hdiutil attach -quiet -nobrowse "/Volumes/Recovery HD/com.apple.recovery.boot/BaseSystem.dmg" && wait
  # Ask for new firmware password
  printf "Please enter new firmware password..\n"
  printf "Password:" && read -s Newpassword && printf "\n"
  printf "Confirm new firmware password..\n"
  printf "Password:" && read -s Confirmpassword && printf "\n"
  if [ ! "${Newpassword}" = "${Confirmpassword}" ]; then
    printf "Entered passwords don't match!\n"
  fi;
  # Ask for admin password up front
  if [ ! "${UID}" = 0 ]; then
    printf "Please enter your user password..\n"
    sudo -v
  fi;
  # Set firmware password
  sudo "/Volumes/OS X Base System/Applications/Utilities/Firmware Password Utility.app/Contents/Resources/setregproptool" -m "command" -p "${Confirmpassword}"
  # Unmount recovery disk
  diskutil unmount force "Recovery HD" 1>/dev/null && wait
  printf "New firmware password set!\n"
}
