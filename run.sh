#!/bin/sh

if [ -z "$AUTHORIZED_KEY" ]; then
  echo "Missing env var 'AUTHORIZED_KEY'"
  exit 1
fi

cat <<EOF >/home/user/.ssh/authorized_keys
$AUTHORIZED_KEY
EOF

exec /usr/local/openssh-u2f/sbin/sshd -D -e
