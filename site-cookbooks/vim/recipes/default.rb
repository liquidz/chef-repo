#
# Cookbook Name:: vim
# Recipe:: default
#
# Copyright 2013, @uochan
#
# All rights reserved - Do Not Redistribute
#

package 'vim' do
    action :remove
end

%w{mercurial lua lua-devel}.each do |pkg_name|
    package pkg_name do
        action :install
    end
end

git "/usr/local/src/luajit" do
    repository "http://luajit.org/git/luajit-2.0.git"
    reference "master"
    action :sync
end

bash "build luajit" do
    cwd "/usr/local/src/luajit"
    code <<-EOT
make
make install
EOT
end

bash "clone vim source" do
    cwd "/usr/local/src"
    code <<-EOT
hg clone https://vim.googlecode.com/hg/ vim
EOT
end

bash "build vim from source" do
    cwd "/usr/local/src/vim"
    code <<-EOT
./configure --prefix=/usr/local --with-features=huge --enable-multibyte --enable-luainterp --with-luajit --enable-fail-if-missing
make
make install
EOT
end

