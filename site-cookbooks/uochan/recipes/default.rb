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

git "/home/vagrant/.dotfiles" do
    #repository "https://github.com/liquidz/dotfiles.git"
    repository "git://github.com/liquidz/dotfiles.git"
    reference "master"
    action :sync
end

bash "setting dot files" do
    cwd "/home/vagrant"
    #not_if "ls .vimrc"

    code <<-EOC
        ln -s .dotfiles/.gemrc     .
        ln -s .dotfiles/.tmux.conf .
        ln -s .dotfiles/.vimrc     .
        ln -s .dotfiles/.zshrc     .
    EOC
end
