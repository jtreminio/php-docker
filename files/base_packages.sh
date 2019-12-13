#!/usr/bin/env bash

set -e
set -x

cat > /root/ondrej.pgp << EOF
-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: SKS 1.1.6
Comment: Hostname: keyserver.ubuntu.com

mI0ESX35nAEEALKDCUDVXvmW9n+T/+3G1DnTpoWh9/1xNaz/RrUH6fQKhHr568F8hfnZP/2C
GYVYkW9hxP9LVW9IDvzcmnhgIwK+ddeaPZqh3T/FM4OTA7Q78HSvR81mJpf2iMLm/Zvh89Zs
mP2sIgZuARiaHo8lxoTSLtmKXsM3FsJVlusyewHfABEBAAG0H0xhdW5jaHBhZCBQUEEgZm9y
IE9uZMWZZWogU3Vyw72ItgQTAQIAIAUCSX35nAIbAwYLCQgHAwIEFQIIAwQWAgMBAh4BAheA
AAoJEE9OoKrlJnpsQjYD/jW1NlIFAlT6EvF2xfVbkhERii9MapjaUsSso4XLCEmZdEGX54GQ
01svXnrivwnd/kmhKvyxCqiNLDY/dOaK8MK//bDI6mqdKmG8XbP2vsdsxhifNC+GH/OwaDPv
n1TyYB653kwyruCGFjEnCreZTcRUu2oBQyolORDl+BmF4DjL
=R5tk
-----END PGP PUBLIC KEY BLOCK-----
EOF

# install base requirements
apt-get update &&\
apt-get install --no-install-recommends --no-install-suggests -y \
    ca-certificates\
    curl \
    git \
    gnupg \
    unzip \
    zip &&\
cat /root/ondrej.pgp | apt-key add &&\
printf "deb [arch=amd64] http://ppa.launchpad.net/ondrej/php/ubuntu bionic main\n" \
    >/etc/apt/sources.list.d/ondrej.list &&\
rm -f /root/ondrej.pgp &&\
apt-get update &&\
apt-get -y --purge autoremove &&\
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/{man,doc}
