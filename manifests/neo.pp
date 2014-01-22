class neo {
    file { '/etc/vconsole.conf':
        ensure => "present",
        content => "KEYMAP=neo"
    }
    exec { 'default-layout neo':
        command => '/bin/echo "LOCALE=de_DE.utf-8" >> /etc/rc.conf'
    }
}