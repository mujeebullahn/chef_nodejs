#
# Cookbook:: node
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.

package "nginx"  #to install nginx
#package is one provision
include_recipe 'nodejs'

#enable and start are another test
service 'nginx' do
  action :enable
end

service 'nginx' do
  action :start
end
