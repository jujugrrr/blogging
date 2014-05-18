require 'spec_helper'

describe 'blogging::mysql' do
    let(:chef_run) { ChefSpec::Runner.new(platform: 'ubuntu', version: '12.04').converge(described_recipe) }

    it 'include rackspace_mysql recipe' do
      expect(chef_run).to include_recipe('rackspace_mysql::server')
    end

end
