class xbmc {
    package { 'xbmc' :
        require => Package['xfce4'],
    }
    file { '/home/drone/.config/autostart':
        require => File['/home/drone/.config'],
        ensure  => 'directory',
        source  => '/vagrant/resources/home/drone/.config/autostart',
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
}