directory "#{node['vim']['home']}#{node['vim']['bundle']}" do
    owner     node['vim']['user']
    group     node['vim']['group']
    mode      0755
    action    :create
    recursive true
end

git "#{node['vim']['home']}#{node['vim']['bundle']}/neobundle.vim" do
    repository node['vim']['neobundle']['repository']
    reference  node['vim']['neobundle']['reference']
    user       node['vim']['user']
    group      node['vim']['group']
    action     :sync
end
