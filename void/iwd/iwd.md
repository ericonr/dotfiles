# Setting up IWD

IWD is a very quick and overall simple wi-fi daemon, and a replacement for
wpa_supplicant.

Connection files go in `/var/lib/iwd`, and I chose to store certs in
`/etc/certs`.

The connection file for eduroam is stored here because it's the most complicated
one, otherwise running

```
iwctl station wlan0 connect NetworkName
```

will give you a password prompt and is enough.
