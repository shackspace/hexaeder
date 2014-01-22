class dosbox {
    package { 'dosbox':
        require => Package['xfce4']
    }
}