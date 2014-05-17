#
# Cookbook Name:: blogging
# Recipe:: nginx
# Author ; Julien Berard <jujugrrr@gmail.com>
# Copyright (C) 2014 Julien Berard
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
##

#resources("template[#{node['rackspace_nginx']['config']['dir']}/sites-available/default]").cookbook "blogging"
include_recipe "rackspace_nginx"

#Set up webroot
directory node['blogging']['nginx']['root'] do
  action :create
  owner node['rackspace_nginx']['config']['user']
  group node['rackspace_nginx']['config']['user']
end

file File.join(node['blogging']['nginx']['root'], 'index.php') do
  content '<?php echo "Hello" ?>'
  owner node['rackspace_nginx']['config']['user']
  group node['rackspace_nginx']['config']['user']
end
