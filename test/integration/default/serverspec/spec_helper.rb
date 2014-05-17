require 'serverspec'
require 'pathname'
require 'net/http'


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
