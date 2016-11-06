#
# Cookbook Name:: anyenv
# Recipe:: rbenv
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# install rbenv for root
# edit profile for root
bash 'install_rbenv_for_root' do
  user 'root'
  not_if { File.exists?("/root/.anyenv/envs/rbenv/bin/rbenv") }
  code <<-EOH
    /root/.anyenv/bin/anyenv install rbenv
    source /root/.profile
  EOH
  notifies :run, 'bash[install_ruby]', :delayed
end

bash 'install_ruby_for_root' do
  user 'root'
  environment 'HOME' => '/root'
  action :nothing
  code <<-EOH
    source /root/.profile
    /root/.anyenv/envs/rbenv/bin/rbenv install #{node['ruby']['version']}
    /root/.anyenv/envs/rbenv/bin/rbenv global #{node['ruby']['version']}
  EOH
end
