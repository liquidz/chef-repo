#
# Cookbook Name:: underscore.js
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

directory node['underscore']['install_dir'] do
    action    :create
    recursive true
end

git "#{node['underscore']['install_dir']}/underscore" do
    repository node['underscore']['repository']
    reference  node['underscore']['reference']
    action     :sync
    user       node['underscore']['user']
    group      node['underscore']['group']
end
