# macOS
# webbrowsers.sh

# Launch a DuckDuckGo search from the shell
# `ddg 'fruity loops' or `ddg 'fruity loops' youtube` or `ddg 'fruity loops' yt`
ddg() {
  if [ ${#} -gt 1 ]; then
    open "https://duckduckgo.com/?q=${1}"
  elif [ ${#} -gt 2 ]; then
    open "https://duckduckgo.com/?q=${1}\!${2}"
  else
    printf "Invalid input!\n"
  fi;
}

# Use Chrome from shell
chrome() {
  # Prevent shell from foregrounding `chrome`
  if ! pgrep "Chrome" >/dev/null 2>&1; then
    open -a "Google Chrome" >/dev/null 2>&1 && \
    osascript -e 'tell app "Google Chrome" to close front window'
  fi;
  # Open Chrome binary with arguments, then switch to created window
  "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" ${@} 2>/dev/null \
  && open -a "Google Chrome" >/dev/null 2>&1
}

# Kill all the tabs in Chrome to free up memory
# `grep [C]hrome` explained: tinyurl.com/c7uq9x
ctabkill() {
  ps ux | grep '[C]hrome Helper --type=renderer' | grep -v extension-process |\
  tr -s ' ' | cut -d ' ' -f2 | xargs kill
}

# Open all Safari tabs in Chrome
tabsaco() {
  open -a "Google Chrome"
  osascript \
  -e 'tell application "Chrome" to activate' \
  -e 'set list_Tabs to {}' \
  -e 'tell application "Safari"' \
    -e 'set the_Tabs to (tabs of every window)' \
    -e 'repeat with the_Tab in the_Tabs' \
      -e 'set the_Items to (every item of the_Tab)' \
      -e 'repeat with the_Item in the_Items' \
        -e 'copy URL of the_Item to end of list_Tabs' \
      -e 'end repeat' \
    -e 'end repeat' \
  -e 'end tell' \
  -e 'tell application "Google Chrome"' \
    -e 'repeat with list_Tab in list_Tabs' \
      -e 'set myTab to make new tab at end of tabs of window 1' \
      -e 'set URL of myTab to list_Tab' \
    -e 'end repeat' \
  -e 'end tell' \
  -e 'tell application "System Events" to set visible of process "Safari" to false'
}

# Open all Chrome tabs in Safari
tabcosa() {
  open -a "Safari"
  osascript \
  -e 'set list_Tabs to {}' \
  -e 'tell application "Google Chrome"' \
    -e 'set the_Tabs to (tabs of every window)' \
    -e 'repeat with the_Tab in the_Tabs' \
      -e 'set the_Items to (every item of the_Tab)' \
      -e 'repeat with the_Item in the_Items' \
        -e 'copy URL of the_Item to end of list_Tabs' \
      -e 'end repeat' \
    -e 'end repeat' \
  -e 'end tell' \
  -e 'tell application "Safari"' \
    -e 'repeat with list_Tab in list_Tabs' \
      -e 'set myTab to make new tab at end of tabs of window 1' \
      -e 'set URL of myTab to list_Tab' \
    -e 'end repeat' \
  -e 'end tell' \
  -e 'tell application "System Events" to set visible of process "Google Chrome" to false'
}
