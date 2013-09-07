home = node['ruby']['home']

gem_package "refe2" do
    action :upgrade
end

bash "setup bitclust" do
    code        "bitclust setup"
    user        node['ruby']['user']
    group       node['ruby']['group']
    environment "HOME" => home
    not_if do File.exists?("#{home}/.bitclust/config") end
end
