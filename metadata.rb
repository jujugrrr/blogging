name             'blogging'
maintainer       'Julien Berard'
maintainer_email 'jujugrrr@gmail.com'
license          'Apache 2.0'
description      'Installs/Configures blogging platform'
long_description 'installs a blogging platform, based on nginx, php, wordpress, pure-ftpd, mysql and phpmyadmin
'
version          '0.1.0'

depends 'rackspace_nginx', '>= 3.2.0'
depends 'rackspace_php', '>= 2.3.1'
depends 'pure-ftpd' , '0.1.0'
depends 'rackspace_mysql', '>= 6.1.0'
depends 'wordpress', '>= 2.1.4'
