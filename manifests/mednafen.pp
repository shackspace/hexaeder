class mednafen {
    package { 'mednafen':
        require => Package['xfce4']
    }
}