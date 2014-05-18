require 'spec_helper'

describe 'blogging::mysql' do
    let(:chef_run) {
      ChefSpec::Runner.new(platform: 'ubuntu', version: '12.04') do |node|
        node.set[:rackspace_mysql][:server_debian_password] = 'TestDebianPassword'
        node.set[:rackspace_mysql][:server_root_password] = 'TestRootPassword'
        node.set[:rackspace_mysql][:server_repl_password] = 'TestReplicationPassword'
      end.converge(described_recipe)
    }

    it 'include rackspace_mysql::server recipe' do
      expect(chef_run).to include_recipe('rackspace_mysql::server')
    end
    it 'include rackspace_mysql::client recipe' do
      expect(chef_run).to include_recipe('rackspace_mysql::client')
    end

    it 'installs mysqlclient libs' do
      expect(chef_run).to install_package('mysql-client')
      expect(chef_run).to install_package('libmysqlclient-dev')
      expect(chef_run).to install_package('ruby-mysql')
    end

end
