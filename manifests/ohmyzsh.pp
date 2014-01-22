define powerline-font($sourcedir = 'SourceCodePro') {
    file { "/usr/local/share/fonts/${name}.otf":
        require => [File['/usr/local/share/fonts'], Exec['powerline-fonts::download'] ],
        ensure  => present,
        source  => "/tmp/powerline-fonts/${sourcedir}/${name}.otf"
    }
}

class ohmyzsh {
    if(!defined(Package['git'])) {
        package { 'git':
            ensure => present,
        }
    }
    
    if(!defined(Package['zsh'])) {
        package { 'zsh':
            ensure => present,
        }
    }
    
    exec { 'powerline-fonts::download':
        require  => Package['git'],
        creates  => "/tmp/powerline-fonts",
        command  => "/usr/bin/git clone https://github.com/Lokaltog/powerline-fonts.git",
        cwd      => "/tmp"
    }
    
    file { '/usr/local/share/fonts':
        ensure => directory
    }
    
    powerline-font {'Sauce Code Powerline Black': }
    powerline-font {'Sauce Code Powerline Bold': }
    powerline-font {'Sauce Code Powerline ExtraLight': }
    powerline-font {'Sauce Code Powerline Light': }
    powerline-font {'Sauce Code Powerline Medium': }
    powerline-font {'Sauce Code Powerline Regular': }
    powerline-font {'Sauce Code Powerline Semibold': }
}

define ohmyzsh::install($homebase = '/home') {
    exec { "ohmyzsh::git clone ${name}":
        creates => "${homebase}/${name}/.oh-my-zsh",
        command => "/usr/bin/git clone git://github.com/robbyrussell/oh-my-zsh.git ${homebase}/${name}/.oh-my-zsh",
        user    => $name,
        require => [Package['git'], Package['zsh']]
    }
    
    exec { "ohmyzsh::cp .zshrc ${name}":
        creates => "${homebase}/${name}/.zshrc",
        command => "/bin/cp ${homebase}/${name}/.oh-my-zsh/templates/zshrc.zsh-template ${homebase}/${name}/.zshrc",
        user    => $name,
        require => Exec["ohmyzsh::git clone ${name}"],
    }
    
    exec { "ohmyzsh::theme ${name}":
        require => Exec["ohmyzsh::cp .zshrc ${name}"],
        command => "/bin/sed -i -r -e 's/robbyrussell/agnoster/' ${homebase}/${name}/.zshrc",
        user    => $name
    }
    
    exec { "ohmyzsh::defaultuser ${name}":
        require => Exec["ohmyzsh::cp .zshrc ${name}"],
        command => "/bin/echo 'DEFAULT_USER=${name}\n' >> ${homebase}/${name}/.zshrc",
        user    => $name
    }
}