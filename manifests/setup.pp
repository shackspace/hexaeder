exec { 'move to testing':
    command => "/bin/sed -i -r -e 's/wheezy/jessie/' /etc/apt/sources.list",
}

# some stuff is 32bit-only
exec { 'add-architecture i386':
    command => '/usr/bin/dpkg --add-architecture i386',
}

exec { 'apt-get update':
    require => [Exec['move to testing'], Exec['add-architecture i386']],
    command => "/usr/bin/apt-get update"
}

exec { 'apt-get dist-upgrade':
    require => Exec['apt-get update'],
    command => "/usr/bin/apt-get dist-upgrade -y",
    timeout => 0
}

# install ALL the packages
Package {
    require  => Exec['apt-get dist-upgrade'],
    ensure   => "installed"
}

$basicPackages = ['git', 'vim', 'ntp']

package { $basicPackages : }

user { 'drone' :
    require => Package['zsh'],
    ensure  => present,
    shell   => '/usr/bin/zsh',
    home    => '/home/drone',
    password => 'drone',
    gid     => "42",
    uid     => "42",
    managehome => true
}

file { '/home/drone/.config':
    require => User['drone'],
    ensure  => 'directory',
    owner   => 'drone'
}

import 'neo.pp'
include neo

import 'ohmyzsh.pp'
include ohmyzsh
ohmyzsh::install { 'root': 
    homebase => ''
}
ohmyzsh::install { 'drone':
    require => User['drone']
}

import 'desktopEnvironment.pp'
include desktopenvironment

import 'xbmc.pp'
include xbmc

import 'emulators.pp'
