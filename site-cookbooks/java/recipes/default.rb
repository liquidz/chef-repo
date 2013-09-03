#
# Cookbook Name:: java
# Recipe:: default
#
# Copyright 2013, @uochan
#
# All rights reserved - Do Not Redistribute
#

%w{java-VERSION-openjdk java-VERSION-openjdk-devel}.each do |s|
    pkg = s.sub('VERSION', node['java']['version'])

    package pkg do
        action :install
    end
end

