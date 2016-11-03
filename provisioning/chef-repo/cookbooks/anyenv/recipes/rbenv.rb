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
bash 'install_rbenv' do
  user 'root'
  not_if { File.exists?("~/.anyenv/envs/rbenv/bin/rbenv") }
  code <<-EOH
    ~/.anyenv/bin/anyenv install rbenv
    source ~/.profile
  EOH
  notifies :run, 'bash[install_ruby]', :delayed
end

bash 'install_ruby' do
  user 'root'
  environment 'HOME' => '/root'
  action :nothing
  code <<-EOH
    source ~/.profile
     ~/.anyenv/envs/rbenv/bin/rbenv install 2.3.1
     ~/.anyenv/envs/rbenv/bin/rbenv global 2.3.1
  EOH
end
