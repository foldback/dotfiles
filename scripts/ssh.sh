# ssh.sh


# Add public SSH key from machine to remote
# Example: `ssh-cp-id username server`
ssh-cp-id() {
  cat "${HOME}/.ssh/id_rsa.pub" | \
  ssh -o PreferredAuthentications=password -o ConnectTimeout=5 "${1}@${2}" \
  'mkdir "${HOME}/.ssh" 2>/dev/null; cat >> "${HOME}/.ssh/authorized_keys"'
}

# Reboot WRT routers from the shell
# Only works if your SSH public key has been added to the router
rbwrt() {
  for IP in ${@}; do
    ssh -o PreferredAuthentications=publickey -o ConnectTimeout=5 \
    "root@${IP}" 'reboot'
  done;
}
