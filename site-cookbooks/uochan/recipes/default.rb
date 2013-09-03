#
# Cookbook Name:: uochan
# Recipe:: default
#
# Copyright 2013, @uochan
#
# All rights reserved - Do Not Redistribute
#

git "#{node['uo']['home']}/.dotfiles" do
    repository "git://github.com/liquidz/dotfiles.git"
    reference  "master"
    action     :sync
    user       node['uo']['user']
    group      node['uo']['group']
end

directory "#{node['uo']['home']}/.backup" do
    owner  node['uo']['user']
    group  node['uo']['group']
    mode   0755
    action :create
end

bash "Add symlinks from .dotfiles" do
    cwd   node['uo']['home']
    user  node['uo']['user']
    group node['uo']['group']
    code <<-EOC
        find .dotfiles -maxdepth 1 -type f | xargs -i ln -s {} .
    EOC
    not_if "ls #{node['uo']['home']}/.vimrc"
end

