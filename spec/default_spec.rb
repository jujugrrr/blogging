require 'spec_helper'

describe 'blogging::default' do
    let(:chef_run) { ChefSpec::Runner.new(platform: 'ubuntu', version: '12.04').converge(described_recipe) }

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
