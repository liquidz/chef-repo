#
# Cookbook Name:: uochan
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# パッケージインストール
%w{vim zsh git}.each do |pkg|
    package pkg do
        action :install
    end
end

# private setting {{{
git "/home/vagrant/.dotfiles" do
    repository "git://github.com/liquidz/dotfiles.git"
    reference  "master"
    action     :sync
    user       "vagrant"
    group      "vagrant"
end
directory "/home/vagrant/.backup" do
    owner  "vagrant"
    group  "vagrant"
    mode   0755
    action :create
end
bash "add symlinks from .dotfiles" do
    cwd   "/home/vagrant"
    user  "vagrant"
    group "vagrant"
    code <<-EOC
        find .dotfiles -maxdepth 1 -type f | xargs -i ln -s {} .
    EOC
    not_if 'ls /home/vagrant/.vimrc'
end
# }}}

# neobundle {{{
directory "/home/vagrant/.vim/bundle" do
    owner     "vagrant"
    group     "vagrant"
    mode      0755
    action    :create
    recursive true
end

git "/home/vagrant/.vim/bundle/neobundle.vim" do
    repository "git://github.com/Shougo/neobundle.vim.git"
    reference  "master"
    action     :sync
    user       "vagrant"
    group      "vagrant"
end
# }}}

# java {{{
%w{java-1.7.0-openjdk java-1.7.0-openjdk-devel}.each do |pkg|
    package pkg do
        action :install
    end
end
# }}}

# leiningen {{{
directory "#{node['leiningen']['home']}/bin" do
    owner     node['leiningen']['user']
    group     node['leiningen']['group']
    mode      0755
    action    :create
end

bash "self-install leiningen" do
    cwd   "#{node['leiningen']['home']}/bin"
    user  node['leiningen']['user']
    group node['leiningen']['group']
    environment "HOME"        => node['leiningen']['home'],
                "HTTP_CLIENT" => node['leiningen']['http_client'],
                "HTTPS_PROXY" => node['leiningen']['https_proxy']
    code <<-EOC
        wget #{node['leiningen']['script']}
        chmod +x /home/vagrant/bin/lein
        #{node['leiningen']['home']}/bin/lein self-install
    EOC
    not_if "ls #{node['leiningen']['home']}/bin/lein"
end
# }}}

