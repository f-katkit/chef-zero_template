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
node['ruby']['user'].each do |user|
  bash 'install_rbenv_for_users' do
    user user
    environment 'HOME' => "/home/#{user}"
    not_if { File.exists?("/home/#{user}/.anyenv/envs/rbenv/bin/rbenv") }
    code <<-EOH
      source /home/#{user}/.profile
      /home/#{user}/.anyenv/bin/anyenv install rbenv
    EOH
    notifies :run, 'bash[install_ruby]', :delayed
  end

  bash 'install_ruby_for_users' do
    user user
    environment 'HOME' => "/home/#{user}"
    action :nothing
    code <<-EOH
      source /home/#{user}/.profile
      /home/#{user}/.anyenv/envs/rbenv/bin/rbenv install #{node['ruby']['version']}
      /home/#{user}/.anyenv/envs/rbenv/bin/rbenv global #{node['ruby']['version']}
      /home/#{user}/.anyenv/envs/rbenv/bin/rbenv rehash
    EOH
  end
end
