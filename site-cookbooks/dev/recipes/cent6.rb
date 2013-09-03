bash 'Enable single-request-reopen' do
    cwd '/etc'
    code <<-EOC
        echo 'options single-request-reopen' >> resolv.conf
    EOC
    not_if 'grep single-request-reopen /etc/resolv.conf'
end
