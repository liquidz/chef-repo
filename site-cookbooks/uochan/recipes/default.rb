#
# Cookbook Name:: uochan
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# パッケージインストール
%w{vim zsh}.each do |pkg|
    package pkg do
        action :install
    end
end

# グループ作成
group "uochan" do
    group_name   "uochan"
    gid          999
    action       [:create]
end

# ユーザ作成
user "uochan" do
    comment ""
    home       "/home/uochan"
    uid        999
    group      "uochan"
    shell      "/bin/zsh"
    password   nil
    supports   :manage_home => true
end
