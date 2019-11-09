openssh-u2f
===========

OpenSSH server built with U2F token support (ecdsa-sk keys) for testing out
this new key type.

U2F support was added to OpenSSH in November 2019. The announcement and
details are here: https://marc.info/?l=openssh-unix-dev&m=157259802529972&w=2

SSH Client with U2F support
---------------------------

As of 2019/11/09 support for U2F exists only on the master branch of OpenSSH.

macOS (and maybe linuxbrew) users can use this [formula](https://github.com/joemiller/homebrew-taps/blob/master/Formula/openssh-u2f.rb)
to compile OpenSSH from master branch with support for U2F. This also builds the
necessary middlware library (libsk-libfido2.so) for yubikeys:

This will install openssh as a "keg only" formula so it will not conflict with
openssh installed by macOS or the official homebrew formula. The binaries are in
`/usr/local/opt/openssh-u2f`.

```console
brew install joemiller/taps/openssh-u2f
```

Set path to the middleware library. This can also be set in `.ssh/ssh_config` as
`SecurityKeyProvider`:

```console
export SSH_SK_PROVIDER=/usr/local/opt/openssh-u2f/lib/libsk-libfido2.so
```

Generate key of type `ecdsa-sk`, this is the new keytype ssh introduced to support u2f keys
The command will appear to pause. Your yubikey should start blinking because it wants to be touched, touch it.

```console
/usr/local/opt/openssh-u2f/bin/ssh-keygen -t ecdsa-sk
```

Docker Container Usage
----------------------

Start the server. This assumes you have already initialized your U2F key and its
pubkey exists in `~/.ssh/id_ecdsa_sk.pub`.

```console
docker run --rm -it -p 2222:22 -e "AUTHORIZED_KEY=$(cat ~/.ssh/id_ecdsa_sk.pub)" joemiller/openssh-u2f:latest
```

Then SSH:

```console
ssh -p 2222 user@locahost
```
