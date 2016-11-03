#
# Cookbook Name:: anyenv
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

bash 'test script' do
  user 'root'
  code <<-EOH
    echo "chef-client has been running."  >> /root/text
  EOH
end

# install for root
git '/root/.anyenv' do
  repository 'https://github.com/riywo/anyenv'
  revision 'master'
  action :sync
end

# edit profile for root
bash 'edit_profile' do
  user 'root'
  not_if "grep '# ADDED' /root/.profile"
  code <<-EOH
    echo 'export PATH="$HOME/.anyenv/bin:$PATH" # ADDED' >> /root/.profile
    echo 'eval "$(anyenv init -)"' >> /root/.profile
    source /root/.profile
  EOH
end
