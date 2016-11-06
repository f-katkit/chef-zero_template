#
# Cookbook Name:: anyenv
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# install for users
node['anyenv']['user'].each do |user|
  git "/home/#{user}/.anyenv" do
    user user
    repository 'https://github.com/riywo/anyenv'
    revision 'master'
    action :sync
  end

  # edit profile for users
  bash 'edit_profile_for_users' do
    user user
    not_if "grep '# ADDED' /home/#{user}/.profile"

    code <<-EOH
      echo 'export PATH="$HOME/.anyenv/bin:$PATH" # ADDED' >> /home/#{user}/.profile
      echo 'eval "$(anyenv init -)"' >> /home/#{user}/.profile
      source /home/#{user}/.profile
    EOH
  end
end
