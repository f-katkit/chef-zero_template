service 'iptables' do
  only_if { File.exist?("/etc/init.d/iptables") }
  supports :status => true, :start => true, :stop => true, :restart => true
  action [ :disable, :stop ]
end
