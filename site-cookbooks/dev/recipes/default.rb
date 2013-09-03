#
# Cookbook Name:: dev
# Recipe:: default
#
# Copyright 2013, @uochan
#
# All rights reserved - Do Not Redistribute
#

service 'iptables' do
    action [:disable, :stop]
    supports :status => true, :restart => true
end
