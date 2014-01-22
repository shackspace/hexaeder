class desktopenvironment {
    package {'dbus':
    }
    package {'xfce4':
        require => Package['dbus'],
    }
    package {'xfce4-terminal':
        require => Package['xfce4']
    }
    file {'/home/drone/.config/xfce4/terminal':
        require => Package['xfce4-terminal'],
        ensure  => 'directory',
        owner    => 'drone'
    }
    exec {'desktopenvironment::terminal config':
        creates => '/tmp/xfce4-terminal-colors-solarized',
        command => '/usr/bin/git clone https://github.com/sgerrand/xfce4-terminal-colors-solarized.git',
        cwd     => '/tmp'
    }
    file {'/home/drone/.config/xfce4/terminal/terminalrc':
        require => Exec['desktopenvironment::terminal config'],
        ensure  => 'present',
        source  => '/tmp/xfce4-terminal-colors-solarized/dark/terminalrc'
    }
    
    package {'slim':
        require => Package['xfce4']
    }
    exec {'slim::set_default_user':
        require => Package['slim'],
        command => "/bin/sed -i -r -e 's/#default_user.*/default_user drone/' /etc/slim.conf"
    }
    exec {'slim::set_auto_login':
        require => Package['slim'],
        command => "/bin/sed -i -r -e 's/#auto_login.*/auto_login yes/' /etc/slim.conf"
    }
}
