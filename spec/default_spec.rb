require 'spec_helper'

describe 'blogging::default' do
    let(:chef_run) {
      ChefSpec::Runner.new(platform: 'ubuntu', version: '12.04') do |node|
        node.set[:rackspace_mysql][:server_debian_password] = 'TestDebianPassword'
        node.set[:rackspace_mysql][:server_root_password] = 'TestRootPassword'
        node.set[:rackspace_mysql][:server_repl_password] = 'TestReplicationPassword'
      end.converge(described_recipe)
    }

    before do
      stub_command("egrep 'mirror.rackspace.com/ubuntu/? precise' /etc/apt/sources.list").and_return(false)
      stub_command("egrep 'mirror.rackspace.com/ubuntu/? precise-updates' /etc/apt/sources.list").and_return(false)
      stub_command("egrep 'mirror.rackspace.com/ubuntu/? precise-backports' /etc/apt/sources.list").and_return(false)
      stub_command("egrep 'mirror.rackspace.com/ubuntu/? precise-security' /etc/apt/sources.list").and_return(false)
      stub_command('test -f /var/lib/apt/periodic/update-success-stamp').and_return(true)
    end

    it 'include blogging::nginx recipe' do
      expect(chef_run).to include_recipe('blogging::nginx')
    end
    it 'include blogging::php-fpm recipe' do
      expect(chef_run).to include_recipe('blogging::php-fpm')
    end
    it 'include blogging::pure-ftpd recipe' do
      expect(chef_run).to include_recipe('blogging::pure-ftpd')
    end
    it 'include blogging::mysql recipe' do
      expect(chef_run).to include_recipe('blogging::mysql')
    end

end
