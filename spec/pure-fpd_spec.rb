require 'spec_helper'

describe 'blogging::pure-ftpd' do
    let(:chef_run) { ChefSpec::Runner.new(platform: 'ubuntu', version: '12.04').converge(described_recipe) }

    it 'include pure-ftpd recipe' do
      expect(chef_run).to include_recipe('pure-ftpd::default')
    end

    it 'creates a virtual user' do
      user_create_command = '(echo password1; echo password1) | pure-pw useradd user1 -u www-data -g www-data -d /opt/www'
      expect(chef_run).to run_execute(user_create_command)
    end

    it 'allows a virtual user to have the www-data uid' do
      expect(chef_run).to render_file('/etc/pure-ftpd/conf/MinUID').with_content('33')
    end

end
