#
# Cookbook Name:: hadoop
# Recipe:: default
#
# Copyright 2009, Opscode, Inc.
#

include_recipe "hadoop"

#Datanode specific packages
package "hadoop-0.20-mapreduce-tasktracker"
package "hadoop-hdfs-datanode"
package "hadoop-client"

#Configure core-site.xml
core_site_vars = { :options => node[:hadoop][:datanode][:core] }
template '/etc/hadoop/conf.my_cluster/core-site.xml' do
    source "site.xml.erb"
    mode 0644
    owner "root"
    group "root"
    action :create
    variables core_site_vars
end

#Configure hdfs-site.xml
hdfs_site_vars = { :options => node[:hadoop][:datanode][:hdfs] }           
template '/etc/hadoop/conf.my_cluster/hdfs-site.xml' do                         
    source "site.xml.erb"                                                       
    mode 0644                                                                   
    owner "root"                                                                
    group "root"                                                                
    action :create                                                              
    variables hdfs_site_vars                                               
end

#Configure mapred-site
mapred_site_vars = { :options => node[:hadoop][:datanode][:mapred] }           
template '/etc/hadoop/conf.my_cluster/mapred-site.xml' do                         
    source "site.xml.erb"                                                       
    mode 0644                                                                   
    owner "root"                                                                
    group "root"                                                                
    action :create                                                              
    variables mapred_site_vars                                               
end

#Create data directories for HDFS
"#{node[:hadoop][:datanode][:hdfs]['dfs.datanode.data.dir']}".split(',').each do |dir|
    directory "#{dir}" do
        mode 0755
        owner "hdfs"
        group "hdfs"
        action :create
        recursive true
    end
end

#Create data directories for MapReduce
"#{node[:hadoop][:datanode][:mapred]['mapred.local.dir']}".split(',').each do |dir|
    directory "#{dir}" do
        mode 0755
        owner "mapred"
        group "hadoop"
        action :create
        recursive true
    end
end

#Start and enable the HDFS services
service "hadoop-hdfs-datanode" do
    action [ :start, :enable]
end

#Start mapreduce service
service "hadoop-0.20-mapreduce-tasktracker" do
    action [ :start, :enable]
end
