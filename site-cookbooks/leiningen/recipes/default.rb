#
# Cookbook Name:: leiningen
# Recipe:: default
#
# Copyright 2013, @uochan
#
# All rights reserved - Do Not Redistribute
#

directory "#{node['leiningen']['home']}/bin" do
    owner   node['leiningen']['user']
    group   node['leiningen']['group']
    mode    0755
    action  :create
end

bash "self-install leiningen" do
    cwd    "#{node['leiningen']['home']}/bin"
    user   node['leiningen']['user']
    group  node['leiningen']['group']
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
