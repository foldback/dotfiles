# macOS
# vlc.sh
# Makes VLC look and behave better

# Open VLC to create vlcrc
open -a "VLC" && sleep 5 && osascript -e 'quit app "VLC"'

# Theme
# Dark theme
sed -i "" 's/#macosx-interfacestyle=0/macosx-interfacestyle=1/g'\
 "${HOME}/Library/Preferences/org.videolan.vlc/vlcrc"
# Hide sidebar
sed -i "" 's/#macosx-show-sidebar=1/macosx-show-sidebar=0/g'\
 "${HOME}/Library/Preferences/org.videolan.vlc/vlcrc"
# Use native OS X fullscreen mode
sed -i "" 's/#macosx-nativefullscreenmode=0/macosx-nativefullscreenmode=1/g'\
 "${HOME}/Library/Preferences/org.videolan.vlc/vlcrc"
# Set default language English
sed -i "" 's/#sub-language=/sub-language=English/g'\
 "${HOME}/Library/Preferences/org.videolan.vlc/vlcrc"

# Subtitles
# Less gigantic size
sed -i "" 's/#freetype-rel-fontsize=16/freetype-rel-fontsize=20/g'\
 "${HOME}/Library/Preferences/org.videolan.vlc/vlcrc"
# Set font to 'Tahoma'. "" instead of '' to prevent whitespace interpretation
sed -i "" "s/#freetype-font=Arial Unicode MS/freetype-font=Tahoma/g"\
 "${HOME}/Library/Preferences/org.videolan.vlc/vlcrc"
# Set encoding to Unicode
sed -i "" 's/#subsdec-encoding=/subsdec-encoding=UTF-8/g'\
 "${HOME}/Library/Preferences/org.videolan.vlc/vlcrc"

# Use a more modern icon
npm install -g fileicon
fileicon rm '/Applications/VLC.app'
fileicon set '/Applications/VLC.app' "${HOME}/dotfiles/resources/vlc.icns"
npm uninstall -g fileicon

# Use a more modern theme
rm -Rf "/Applications/VLC.app/Contents/Resources"
unzip "${HOME}/dotfiles/resources/vlc_theme__os_x_yosemite.zip"\
 -d "/Applications/VLC.app/Contents" >/dev/null
rm -Rf "/Applications/VLC.app/Contents/__MACOSX"

echo "VLC configured!"
