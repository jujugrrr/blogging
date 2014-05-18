# blogging-cookbook

This cookbook installs a blogging platform, based on nginx, php, wordpress, pure-ftpd, mysql and phpmyadmin.

This is still a WIP. The goal here was to follow the following restriction :

* Nginx latest stable version servicing /opt/www
* PHP-FPM module
* FTP Server in order to access their files to update/upload/remove content
* MySQL 5.x stable
* PHPMyAdmin responding to “something” like “pma.localdomain”

* The entire development should happen in git/github where commits will be reviewed.
* It should be tested (preferred) or performed with testing in mind.
* (optional) If chef is used, please consider using the following cookbooks:
Github.com/Rackspace-cookbooks

## Descriptions

This cookbook is using Berkshelf to download all the required dependencies. It is using standard cookbooks and only change the minimal paramaters to provide a Wordpress platform.

## Supported Platforms

* Debian, Ubuntu
* CentOS, Red Hat (WIP)

## Cookbooks dependency

* depends 'rackspace_nginx', '>= 3.2.0'
* depends 'rackspace_php', '>= 2.3.1'
* depends 'pure-ftpd' , '0.1.0'
* depends 'rackspace_mysql', '>= 6.1.0'
* depends 'wordpress', '>= 2.1.4

## Attributes

### nginx

* ```default['rackspace_nginx']['templates']['default_site'] = 'blogging'```` # change the template cookbook
* ```default['blogging']['nginx']['config_name'] = 'blogging.conf'``` # nginx configuration filename
* ```default['blogging']['nginx']['root'] = '/opt/www'``` # nginx webroot
* ```default['blogging']['nginx']['servername'] = 'pikachoun.localdomain'``` # nginx servername

### pure-ftpd

```default[:pure_ftpd][:users] = [{
    :login => 'user1',
    :password => 'password1'
}]``` # user having access to default['blogging']['nginx']['root']

### mysql
* ```default['rackspace_mysql']['client']['packages'] = ["mysql-client", "libmysqlclient-dev","ruby-mysql"]``` # packages installed by the mysql::client

### wordpress
* ```default['wordpress']['db']['name'] = "wordpressdb"``` # db name
* ```default['wordpress']['db']['user'] = "wordpressuser"``` # wordpress db username
* ```default['wordpress']['db']['pass'] = nil``` # wordpress db password

## Usage

### blogging::default

Include `blogging` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[blogging::default]"
  ]
}
```

Edit the password attributes :

```
default['wordpress']['db']['pass']
default[:pure_ftpd][:users] = [{
    :login => 'user1',
    :password => 'password1'
}]
```



## Tests
```
bundle install
```

chef-spec
```
bundle exec rspec
Finished in 24.61 seconds
19 examples, 0 failures
```

Test-kitchen
```
bundle exec kitchen test
Php
  Process "php5-fpm"
    should be running

Web server
  Port "80"
    should be listening
  Process "nginx"
    should be running
  should return a HTTP 200
    should eq "200"

FTP server
  Process "pure-ftpd"
    should be running
  we should be able to write
    should be true

Database server
  i can login
  Port "3306"
    should be listening
  Process "mysqld"
    should be running

Wordpress
  the wordpress DB is there
  i can login as Wordpress user

PhpMyAdmin
  the phpmyadmin DB is there
    is a pending example (PENDING: Not yet implemented)

Pending:
  PhpMyAdmin the phpmyadmin DB is there is a pending example
    # Not yet implemented
    # /tmp/busser/suites/serverspec/localhost/blogging_spec.rb:73

Finished in 0.55313 seconds
12 examples, 0 failures, 1 pending
       Finished verifying <default-ubuntu-1204> (0m7.08s).
-----> Destroying <default-ubuntu-1204>...
       [default] Forcing shutdown of VM...
       [default] Destroying VM and associated drives...
       Vagrant instance <default-ubuntu-1204> destroyed.
       Finished destroying <default-ubuntu-1204> (0m6.84s).
       Finished testing <default-ubuntu-1204> (5m40.13s).
-----> Kitchen is finished. (5m40.72s)
```

## Contributing

1. Fork the repository on Github
2. Create a named feature branch (i.e. `add-new-recipe`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request

## License and Authors

Author:: Julien Berard (<jujugrrr@gmail.com>)
