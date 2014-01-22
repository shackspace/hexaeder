class dolphin {
    $deps = ['cmake', 'g++', 'libgtk2.0-dev', 'libsdl1.2-dev', 'libxrandr-dev', 'libxext-dev',
             'libao-dev', 'libasound2-dev', 'libpulse-dev', 'libbluetooth-dev', 'libreadline-gplv2-dev',
             'libavcodec-dev', 'libavformat-dev', 'libswscale-dev']
    package { $deps :
    }
    exec { 'dolphin::repo':
        creates => '/tmp/dolphin-emu',
        command => "/usr/bin/git clone https://code.google.com/p/dolphin-emu/",
        cwd     => '/tmp'
    }
    file {'/tmp/dolphin-emu/Build':
        require => Exec['dolphin::repo'],
        ensure  => 'directory'
    }
    exec { 'dolphin::prepare-compile':
        require  => [File['/tmp/dolphin-emu/Build'], Package[$deps] ],
        command  => "/usr/bin/cmake ..",
        cwd      => '/tmp/dolphin-emu/Build'
    }
    exec { 'dolphin::compile':
        require => Exec['dolphin::prepare-compile'],
        command => "/usr/bin/make",
        cwd     => "/tmp/dolphin-emu/Build",
        timeout => 0
    }
    exec { 'dolphin::install':
        require => Exec['dolphin::compile'],
        command => "/usr/bin/make install",
        cwd     => "/tmp/dolphin-emu/Build"
    }
    file { '/home/drone/roms/GameCube':
        require => File['/home/drone/roms'],
        ensure  => 'directory',
        owner   => 'drone'
    }
    file { '/home/drone/roms/Wii':
        require => File['/home/drone/roms'],
        ensure  => 'directory',
        owner   => 'drone'
    }
}