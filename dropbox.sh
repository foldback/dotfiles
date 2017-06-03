# dropbox.sh
# Copies Dropbox folders to $HOME, then symlinks them back
# this is done to keep permisions of the local files intact

# Lazy
DROPBOX="${HOME}/Dropbox"

# Check if Dropbox folder doesn't exist or is empty
# An empty macOS folder can be up to 532kB
SIZE_E="$(du -d0 ${DROPBOX} | grep -o '[0-9]*')"
if [ ! -d "${DROPBOX}" ] || [ "${SIZE_E}" < "533" ]; then
  echo "Please log in to Dropbox!"
  exit 1
fi;
unset SIZE_E

# Check if Dropbox is still syncing
SIZE_A="$(du -d0 -k "${DROPBOX}" | grep -o '[0-9]*')"
sleep 3
SIZE_B="$(du -d0 -k "${DROPBOX}" | grep -o '[0-9]*')"
if [ ! "${SIZE_A}" = "${SIZE_B}" ]; then
  echo "Your Dropbox is still syncing, please wait.."
    while [ ! "${SIZE_A}" = "${SIZE_B}" ]; do
      SIZE_A="$(du -d0 -k "${DROPBOX}" | grep -o '[0-9]*')"
      sleep 3
      SIZE_B="$(du -d0 -k "${DROPBOX}" | grep -o '[0-9]*')"
    done;
  echo "Dropbox has finished syncing. Creating symlinks now.."
fi;
unset SIZE_A
unset SIZE_B

# Keep `Documents` backed up
# Copy Dropbox directory to local directory
cp -Rn "${DROPBOX}/Documents" "${HOME}"
# Delete pre-existing directory because it can't be overwritten
rm -Rf "${DROPBOX}/Documents"
# Symlink Dropbox-cloned local directory back into Dropbox
ln -sF "${HOME}/Documents" "${DROPBOX}/Pictures"

# Keep `Pictures` backed up
# Move `Photo library` to $HOME. Otherwise battery = kill
mv -i "${HOME}/Pictures/Photos Library.photoslibrary"\
 "${HOME}/Photos Library.photoslibrary"
# Copy Dropbox directory to local directory
cp -Rn "${DROPBOX}/Pictures" "${HOME}"
# Delete pre-existing directory because it can't be overwritten
rm -Rf "${DROPBOX}/Pictures"
# Symlink Dropbox-cloned local directory back into Dropbox
ln -sF "${HOME}/Pictures" "${DROPBOX}/Pictures"

# Create Calibre symlink so the default Calibre setup works
cp -Rn "${DROPBOX}/eBooks" "${HOME}/Calibre Library"
rm -Rf "${DROPBOX}/eBooks"
ln -sF "${HOME}/Calibre Library" "${DROPBOX}/eBooks"

# Create `.extra` symlink to apply private settings
cp -n "${DROPBOX}/dev/dotfiles/.extra" "${HOME}/.extra"
rm -f "${DROPBOX}/dev/dotfiles/.extra"
ln -sf "${HOME}/.extra" "${DROPBOX}/dev/dotfiles/.extra"

# Symlink SSH keys
cp -Rn "${DROPBOX}/dev/dotfiles/.ssh" "${HOME}"
rm -Rf "${DROPBOX}/dev/dotfiles/.ssh"
chown -R $(id un) "${HOME}/.ssh"
chmod 700 "${HOME}/.ssh"
chmod 600 "${HOME}/.ssh/id_rsa"
chmod 644 "${HOME}/.ssh/id_rsa.pub"
ln -sF "${HOME}/.ssh" "${DROPBOX}/dev/dotfiles/.ssh"

# Symlink GPG keys
# https://superuser.com/a/954536
cp -Rn "${DROPBOX}/dev/dotfiles/.gnupg" "${HOME}"
rm -Rf "${DROPBOX}/dev/dotfiles/.gnupg"
chown -R $(id -un) "${HOME}/.gnupg"
chmod 600 "${HOME}/.gnupg/"*
chmod 700 "${HOME}/.gnupg/private-keys-v1.d/"
ln -sF "${HOME}/.gnupg" "${DROPBOX}/dev/dotfiles/.gnupg"

unset DROPBOX

echo "Dropbox folders symlinked!"
