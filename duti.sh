# macOS
# duti.sh
# Sets UTI (= file type) associations

# Requires Homebrew!
# Set macOS file associations (UTI) via Terminal

# Preparation
brew install duti
sed -n 35,66p duti.sh > "/tmp/duti_list.txt"

# Set associations
duti "/tmp/duti_list.txt"

# Cleanup
brew uninstall duti

# Exit
echo "File types succesfully associated!"
exit 0

# Data below this is ignored and written to a temporary file

# Bundle id              UTI/.ext/MIME-type  role

# Visual Studio Code
com.microsoft.VSCode     public.source-code  editor

# The Unarchiver
cx.c3.theunarchiver      public.archive      all
#cx.c3.theunarchiver     .7z                 all
#cx.c3.theunarchiver     .cab                all
#cx.c3.theunarchiver     .gtar               all
#cx.c3.theunarchiver     .gz                 all
#cx.c3.theunarchiver     .hqx                all
#cx.c3.theunarchiver     .jar                all
#cx.c3.theunarchiver     .msi                all
#cx.c3.theunarchiver     .rar                all
#cx.c3.theunarchiver     .sit                all
#cx.c3.theunarchiver     .tar                all
#cx.c3.theunarchiver     .tar.gz             all
#cx.c3.theunarchiver     .tar.xz             all
#cx.c3.theunarchiver     .tgz                all
#cx.c3.theunarchiver     .zip                all

# Disk Image Mounter
# Stops The Unarchiver from opening .dmg files
com.apple.DiskImageMounter  .dmg             all

# Transmission
org.m0k.transmission        .torrent         all

# VLC
org.videolan.vlc         public.movie        all
#org.videolan.vlc        .avi                all
#org.videolan.vlc        .mkv                all
#org.videolan.vlc        .mov                all
#org.videolan.vlc        .mp4                all
