default[:pure_ftpd][:users] = [{
    :login => 'user1',
    :password => 'password1',
    :home => '/opt/www',
    :system_user => 'www-data',
    :system_group => 'www-data'
}]
default[:pure_ftpd][:options][:MinUID] = "33"
