#
# Cookbook Name:: hadoop
# Recipe:: default
#

include_recipe "java"

execute "apt-get update" do
  action :nothing
end

template "/etc/apt/sources.list.d/cloudera.list" do
  owner "root"
  mode "0644"
  source "cloudera.list.erb"
  notifies :run, resources("execute[apt-get update]"), :immediately
end

#Add correct key depending on the codename
key_url = case node[:lsb][:codename]
  when "lucid" then "curl -s http://archive.cloudera.com/cdh4/ubuntu/lucid/amd64/cdh/archive.key | sudo apt-key add -"
  when "precise" then "curl -s http://archive.cloudera.com/cdh4/ubuntu/precise/amd64/cdh/archive.key | sudo apt-key add -"
  when "squeeze" then "curl -s http://archive.cloudera.com/cdh4/debian/squeeze/amd64/cdh/archive.key | sudo apt-key add -"
end

#Add the repository, the key, and update
execute key_url do
  only_if "apt-key export 'Cloudera Apt Repository'"
  notifies :run, resources("execute[apt-get update]"), :immediately
end
