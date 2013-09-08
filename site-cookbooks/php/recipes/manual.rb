manual_home = node['php']['manual_home']
manual      = node['php']['manual']
manual_name = node['php']['manual_name']
user        = node['php']['user']
group       = node['php']['group']

directory manual_home do
    action    :create
    recursive true
    owner     user
    group     group
end

bash "get php manual html" do
    cwd manual_home
    code <<-EOC
        wget -O #{File.basename(manual)} #{manual}
        tar xvf #{File.basename(manual)}
        /bin/rm -f #{File.basename(manual)}
    EOC
    user  user
    group group
    not_if do File.exists?("#{manual_home}/#{manual_name}") end
end
