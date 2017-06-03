# macOS
# setup.sh
# Fresh setup script

# Ask for the administrator password upfront if needed
if [ ! "${UID}" = 0 ]; then
  sudo -v
fi;

# Keep-alive: update existing 'sudo' time stamp until script has finished
while true; do
  sudo -n true
  sleep 60
  kill -0 "$$" || exit
done; 1>/dev/null &

# Execute scripts
for SCRIPT in ${HOME}/dotfiles/{brew,node,python,ruby,zsh,spectacle,\
,vscode,xcode,vlc,utildotfiles,macos,duti}.sh; do
  ${SCRIPT}
done;
unset SCRIPT

echo "Remember to run the Dropbox script after you've logged in to Dropbox!"
echo "Done! You should probably reboot now.."
