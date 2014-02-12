class xbmc {
    package { 'xbmc' :
        require => Package['xfce4'],
    }
    file { '/home/drone/.config/autostart':
        require => File['/home/drone/.config'],
        ensure  => 'directory',
        source  => '/tmp/hexaeder/resources/home/drone/.config/autostart',
        recurse => true,
        owner   => 'drone'
    }
    file { '/home/drone/xbmcdata':
        require => User['drone'],
        ensure  => 'directory'
    }
    file { '/home/drone/xbmcdata/thumbs':
        require => File['/home/drone/xbmcdata'],
        ensure  => 'directory'
    }
    file { '/home/drone/xbmcdata/fanart':
        require => File['/home/drone/xbmcdata'],
        ensure  => 'directory'
    }
    
    exec { 'xbmc::git-clone::skin.cirrus.extended.v3':
        require => Package['xbmc', 'git'],
        creates => '/home/drone/.xbmc/addons/skins.cirrus.extended.v3',
        command => '/usr/bin/git clone https://github.com/paradix/skin.cirrus.extended.v3.git',
        cwd     => '/home/drone/.xbmc/addons'
    }
    
    exec { 'xbmc::git-clone::plugin.program.advanced.launcher':
        require => Package['xbmc', 'git'],
        creates => '/home/drone/.xbmc/addons/plugin.program.advanced.launcher',
        command => '/usr/bin/git clone https://github.com/Angelscry/plugin.program.advanced.launcher.git',
        cwd     => '/home/drone/.xbmc/addons'
    }
}
