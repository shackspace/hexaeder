#!/bin/sh

apt-get update
apt-get install -f -y  puppet git
cd /tmp && git clone https://github.com/shackspace/hexaeder.git
puppet apply /tmp/hexaeder/manifests/setup.pp
