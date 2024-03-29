require 'spec_helper'

describe 'Php' do

  describe process("php5-fpm") do
    it { should be_running }
  end

end

describe 'Web server' do

  describe port(80) do
    it { should be_listening }
  end

  describe process('nginx') do
    it { should be_running }
  end

  describe 'should return a HTTP 200' do
    it do
      response = http_request('http://pikachoun.localdomain/wordpress/wp-admin/install.php
')
      expect(response.code).to eq '200'
    end
  end

end

describe 'FTP server' do

  describe process('pure-ftpd') do
    it { should be_running }
  end

  describe 'we should be able to write' do
    it do
      expect(ftp_write).to be_true
    end
  end

end

describe 'Database server' do

  describe port(3306) do
    it { should be_listening }
  end
  describe process('mysqld') do
    it { should be_running }
  end
  it "i can login" do
    expect(mysql_login?).to be_true
  end

end

describe 'Wordpress' do
  it "the wordpress DB is there" do
    expect(mysql_is_db_there?).to be_true
  end

  it "i can login as Wordpress user" do
    expect(mysql_login?({:host => "localhost", :username => "TestWordUser", :password => "TestWordPassword"})).to be_true
  end

end

describe 'PhpMyAdmin' do
  describe "the phpmyadmin DB is there" do
    #TODO
    it "is a pending example"
    #  expect(mysql_is_db_there?('phpmyadmin')).to be_true
  end
end
