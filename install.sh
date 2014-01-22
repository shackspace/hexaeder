#!/bin/sh

apt-get install puppet
git clone https://github.com/shackspace/hexaeder.git /tmp/hexaeder
puppet apply /tmp/hexaeder/manifests/setup.pp