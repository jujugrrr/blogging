#
# Cookbook Name:: blogging
# Recipe:: pure-ftpd
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

#set users parameter to our webuser parameter
web_ftp_user = [{
    :home => node['blogging']['nginx']['root'],
    :system_user => node['rackspace_nginx']['config']['user'],
    :system_group => node['rackspace_nginx']['config']['user']
}]

node.set[:pure_ftpd][:users] = [node[:pure_ftpd][:users].first.merge(web_ftp_user.first)]

include_recipe "pure-ftpd::default"
