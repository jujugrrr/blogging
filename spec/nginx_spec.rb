require 'spec_helper'

describe 'blogging::nginx' do
    let(:chef_run) { ChefSpec::Runner.new(platform: 'ubuntu', version: '12.04').converge(described_recipe) }


    it 'include rackspace_nginx recipe' do
      expect(chef_run).to include_recipe('rackspace_nginx::default')
    end

    it 'create a config file for blogging' do
      expect(chef_run).to render_file('/etc/nginx/sites-available/default').with_content('root /opt/www;')
      expect(chef_run).to render_file('/etc/nginx/sites-available/default').with_content('server_name pikachoun.localdomain;')
    end

    it "create the root directory" do
      expect(chef_run).to create_directory('/opt/www')
    end
    it 'creates an hello world' do
      expect(chef_run).to render_file('/opt/www/index.php').with_content('Hello')
    end

end
