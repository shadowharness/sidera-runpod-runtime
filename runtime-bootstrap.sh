set -eu
install -d -m 0700 /root/.ssh
install -d -m 0755 /run/sshd
printf '%s\n' "$PUBLIC_KEY" > /root/.ssh/authorized_keys
printf '%s' "$SHADOW_POD_HOST_KEY_B64" | base64 -d > /etc/ssh/ssh_host_ed25519_key
chmod 600 /root/.ssh/authorized_keys /etc/ssh/ssh_host_ed25519_key
unset SHADOW_POD_HOST_KEY_B64 PUBLIC_KEY
exec /usr/sbin/sshd -D -e -h /etc/ssh/ssh_host_ed25519_key -o PasswordAuthentication=no -o KbdInteractiveAuthentication=no -o PermitRootLogin=prohibit-password
