#
# Cookbook:: node
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.
apt_update 'update_sources' do
  action:update
end

package "nginx"  #to install nginx
#package is one provision
include_recipe 'apt'
include_recipe 'nodejs'

nodejs_npm 'pm2'

#enable and start are another test
service 'nginx' do
  action :enable
end

service 'nginx' do
  action :start
end

template '/etc/nginx/sites-available/proxy.conf' do
  source 'proxy.conf.erb'
  variables proxy_port: node['nginx']['proxy_port']  #take this proxy_port along with proxy.conf file
  notifies :restart, 'service[nginx]'  #to restart nginx once proxy_port is changed
end

link '/etc/nginx/sites-enabled/proxy.conf' do
  to '/etc/nginx/sites-available/proxy.conf'
end

link '/etc/nginx/sites-enabled/default' do
  action :delete
  notifies :restart, 'service[nginx]'  #restart nginx when provision file is changed
end
