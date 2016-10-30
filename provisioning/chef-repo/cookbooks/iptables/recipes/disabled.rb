bash 'test script' do
  user 'root'
  code <<-EOH
    echo "chef-client has been running."  >> /root/text
  EOH
end
