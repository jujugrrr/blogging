require 'spec_helper'

describe 'blogging::default' do
    let(:chef_run) { ChefSpec::Runner.new(platform: 'ubuntu', version: '12.04').converge(described_recipe) }

    it 'include rackspace_nginx recipe' do
      expect(chef_run).to include_recipe('rackspace_nginx::default')
    end
    it 'include rackspace_php recipe' do
      expect(chef_run).to include_recipe('rackspace_php::default')
    end
    it 'include rackspace_php::fpm recipe' do
      expect(chef_run).to include_recipe('rackspace_php::fpm')
    end

end
