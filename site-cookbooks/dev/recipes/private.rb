git "#{node['dev']['home']}/.dotfiles" do
    repository "git://github.com/liquidz/dotfiles.git"
    reference  "master"
    action     :sync
    user       node['dev']['user']
    group      node['dev']['group']
end

directory "#{node['dev']['home']}/.backup" do
    owner  node['dev']['user']
    group  node['dev']['group']
    mode   0755
    action :create
end

bash "Add symlinks from .dotfiles" do
    cwd   node['dev']['home']
    user  node['dev']['user']
    group node['dev']['group']
    code <<-EOC
        find .dotfiles -maxdepth 1 -type f | xargs -i ln -s {} .
    EOC
    not_if "ls #{node['dev']['home']}/.vimrc"
end

