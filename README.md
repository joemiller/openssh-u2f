openssh-u2f
===========

> UPDATED: 2020/06/12 - U2F support is now shipping in OpenSSH 8.2+ !!
>
> The demo has been updated based on the latest macOS homebrew openssh package which ships
> U2F support out of the box now. Making this entire process much easier.
>
> Also the demo docker ssh server image was remade to use ubuntu 20.04 with ships
> with openssh 8.2
>
> The original demo from Nov 2019 is available on the "original-demo" git tag

OpenSSH server built with U2F token support (ecdsa-sk keys) for testing out
this new key type.

U2F support was added to OpenSSH in November 2019. The announcement and
details are here: https://marc.info/?l=openssh-unix-dev&m=157259802529972&w=2

SSH Client with U2F support
---------------------------

Tested with OpenSSH 8.3.

```console
brew install openssh
```

Generate key of type `ecdsa-sk`, this is the new keytype ssh introduced to support u2f keys
The command will appear to pause. Your yubikey should start blinking because it wants to be touched, touch it.

```console
ssh-keygen -t ecdsa-sk
```

Docker Container Usage
----------------------

Start the server. This assumes you have already initialized your U2F key and its
pubkey exists in `~/.ssh/id_ecdsa_sk.pub`.

```console
docker run --rm -it -p 2222:22 -e "AUTHORIZED_KEY=$(cat ~/.ssh/id_ecdsa_sk.pub)" joemiller/openssh-u2f:ubuntu-20.04
```

Then SSH:

```console
ssh -p 2222 user@localhost
```
