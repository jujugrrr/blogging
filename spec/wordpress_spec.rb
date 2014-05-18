require 'spec_helper'

describe 'blogging::wordpress' do
    let(:chef_run) {
      ChefSpec::Runner.new(platform: 'ubuntu', version: '12.04') do |node|
        node.set[:rackspace_sysql][:server_debian_password] = 'TestDebianPassword'
        node.set[:rackspace_mysql][:server_root_password] = 'TestRootPassword'
        node.set[:rackspace_mysql][:server_repl_password] = 'TestReplicationPassword'
        node.set[:rackspace_mysql][:server_repl_password] = 'TestReplicationPassword'
      end.converge(described_recipe)
    }

    it 'include wordpress::default recipe' do
      expect(chef_run).to include_recipe('wordpress::default')
    end

    it 'creates a config file for wordpress' do
      expect(chef_run).to render_file('/opt/www/wordpress/wp-config.php').with_content('WordPress')
    end

end
