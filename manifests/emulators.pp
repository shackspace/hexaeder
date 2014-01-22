file { '/home/drone/roms':
    require => User['drone'],
    ensure  => 'directory',
    owner   => 'drone'
}

import 'fceux.pp'
include fceux

import 'zsnes.pp'
include zsnes

import 'mupen64plus.pp'
include mupen64plus

import 'mednafen.pp'
include mednafen

import 'dosbox.pp'
include dosbox

import 'dolphin.pp'
include dolphin