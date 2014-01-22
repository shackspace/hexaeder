class zsnes {
    package {'zsnes:i386':
        require => Package['xfce4']
    }
    file { '/home/drone/xbmcdata/thumbs/snes':
        require => File['/home/drone/xbmcdata/thumbs'],
        ensure  => 'directory'
    }
    file { '/home/drone/xbmcdata/fanart/snes':
        require => File['/home/drone/xbmcdata/fanart'],
        ensure  => 'directory'
    }
}