#
# Cookbook Name:: hadoop
# Recipe:: default
#
# Copyright 2009, Opscode, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
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

execute key_url do
  not_if "apt-key export 'Cloudera Apt Repository'"
end

package "hadoop"
#Namenode specific packages
package "hadoop-hdfs-namenode"
