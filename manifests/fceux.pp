class fceux {
    package { 'fceux':
        require => Package['xfce4'],
    }
    file { '/home/drone/.fceux':
        ensure => 'directory',
        owner  => 'drone'
    }
    file { '/home/drone/.fceux/fceux.conf':
        require => File['/home/drone/.fceux'],
        ensure  => 'file',
        source  => '/tmp/hexaeder/resources/home/drone/.fceux/fceux.cfg',
        owner   => 'drone'
    }
    file { '/home/drone/xbmcdata/thumbs/nes':
        require => File['/home/drone/xbmcdata/thumbs'],
        ensure  => 'directory'
    }
    file { '/home/drone/xbmcdata/fanart/nes':
        require => File['/home/drone/xbmcdata/fanart'],
        ensure  => 'directory'
    }
}