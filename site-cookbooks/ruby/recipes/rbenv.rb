version         = node['ruby']['version']
rbenv_home      = node['rbenv']['home']
ruby_build_home = node['ruby-build']['home']

git "/usr/local/rbenv" do
    repository node['rbenv']['repository']
    reference  node['rbenv']['reference']
    action     :checkout
end

%w{shims versions}.each do |dir|
    directory "#{rbenv_home}/#{dir}" do
        action :create
    end
end

git ruby_build_home do
    repository node['ruby-build']['repository']
    reference  node['ruby-build']['reference']
    action     :checkout
end

bash "install ruby-build" do
    cwd   ruby_build_home
    code  "/bin/sh install.sh"
    not_if do File.exists?("/usr/local/bin/ruby-build") end
end

bash "generate rbenv.sh" do
    cwd "/etc/profile.d"
    code <<-EOC
        echo 'export RBENV_ROOT="#{rbenv_home}"' > rbenv.sh
        echo 'export PATH="/usr/local/rbenv/bin:$PATH"' >> rbenv.sh
        echo 'eval "$(rbenv init -)"' >> rbenv.sh
    EOC
    not_if do File.exists?("/etc/profile.d/rbenv.sh") end
end

bash "install ruby2" do
    cwd "#{rbenv_home}/bin"
    code <<-EOC
        ./rbenv install #{version}
        ./rbenv global  #{version}
        ./rbenv rehash
    EOC
    environment "RBENV_ROOT" => rbenv_home
    not_if do
        File.exists?("#{rbenv_home}/versions/#{version}")
    end
end
