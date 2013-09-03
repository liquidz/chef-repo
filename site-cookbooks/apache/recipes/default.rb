#
# Cookbook Name:: apache
# Recipe:: default
#
# Copyright 2013, @uochan
#
# All rights reserved - Do Not Redistribute
#

package 'httpd' do
    action :install
end

service 'httpd' do
    action [:enable, :start]
    supports :status => true, :restart => true
end
