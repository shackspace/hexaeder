class mupen64plus {
    package { 'mupen64plus':
        require => Package['xfce4']
    }
}