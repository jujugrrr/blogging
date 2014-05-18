require 'serverspec'
require 'pathname'
require 'net/http'
require 'net/ftp'

begin
  Gem::Specification.find_by_name('mysql2')
rescue Gem::LoadError
  require 'rubygems/dependency_installer'
  Gem::DependencyInstaller.new(Gem::DependencyInstaller::DEFAULT_OPTIONS).install('mysql2')
end
require 'mysql2'


include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS

RSpec.configure do |c|
  c.before :all do
    c.os = backend(Serverspec::Commands::Base).check_os
  end
end

def http_request(uri, ip = '127.0.0.1')
  uri = URI.parse(uri)
  http = Net::HTTP.new(ip, uri.port)
  request = Net::HTTP::Get.new(uri.request_uri, {'Host' => uri.host})
  http.request(request)
end

def ftp_write(ip = '127.0.0.1', user = 'user1', password = 'password1', dir = 'test')
  ftp = Net::FTP.new(ip,user,password)
  permission = !! ftp.mkdir(dir)
  ftp.rmdir(dir)
  ftp.close
  permission
end

def mysql_login?(options = {:host => "localhost", :username => "root", :password => "TestRootPassword"})
  !! Mysql2::Client.new(options)
end

def mysql_is_db_there?(dbname = 'wordpress', options = {:host => "localhost", :username => "root", :password => "aaa"})
  client = Mysql2::Client.new(options)
  !client.query("show databases").select { |db| db["Database"] == dbname}.empty?
end
