require 'spec_helper'

describe 'blogging::default' do

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
