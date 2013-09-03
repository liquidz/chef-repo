#
# Cookbook Name:: zsh
# Recipe:: default
#
# Copyright 2013, @uochan
#
# All rights reserved - Do Not Redistribute
#

package 'zsh' do
    action :install
end

bash 'Change login shell to zsh' do
    code <<-EOT
        chsh -s /bin/zsh #{node['zsh']['user']}
    EOT
    not_if 'test "/bin/zsh" = "$(grep ' + node['zsh']['user'] + ' /etc/passwd | cut -d: -f7)"'
end
