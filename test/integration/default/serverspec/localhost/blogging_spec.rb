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
      response = http_request('http://pikachoun.localdomain/index.php')
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
