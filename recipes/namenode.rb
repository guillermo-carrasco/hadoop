#
# Cookbook Name:: hadoop
# Recipe:: default
#
# Copyright 2009, Opscode, Inc.
#

include_recipe "hadoop"

#Namenode specific packages
package "hadoop-hdfs-namenode"
package "hadoop-0.20-mapreduce-jobtracker"
package "hadoop-client"

#Create soft link to hadoop lib
link "#{node['HADOOP_HOME']}/lib" do
    to "#{node['HADOOP_HOME']}/../lib"
    link_type :symbolic
    action :create
end

#Configure core-site.xml
core_site_vars = { :options => node[:hadoop][:namenode][:core] }
template '/etc/hadoop/conf.my_cluster/core-site.xml' do
    source 'site.xml.erb'
    mode 0644
    owner "root"
    group "root"
    action :create
    variables core_site_vars
end

#Configure hdfs-site.xml
hdfs_site_vars = { :options => node[:hadoop][:namenode][:hdfs] }           
template '/etc/hadoop/conf.my_cluster/hdfs-site.xml' do                         
    source 'site.xml.erb'                                                       
    mode 0644                                                                   
    owner "root"                                                                
    group "root"                                                                
    action :create                                                              
    variables hdfs_site_vars                                               
end

#Configure mapred-site
mapred_site_vars = { :options => node[:hadoop][:namenode][:mapred] }           
template '/etc/hadoop/conf.my_cluster/mapred-site.xml' do                         
    source 'site.xml.erb'                                                       
    mode 0644                                                                   
    owner "root"                                                                
    group "root"                                                                
    action :create                                                              
    variables mapred_site_vars                                               
end

#Create HDFS directory
directory "#{node[:hadoop][:namenode][:hdfs]['dfs.namenode.name.dir']}" do
    mode 0755
    owner "hdfs"
    group "hdfs"
    action :create
    recursive true
end

#Format HDFS
execute "Format HDFS" do
    command "sudo -u hdfs hadoop namenode -format"
end

#Start and enable the HDFS services
service "hadoop-hdfs-namenode" do
    action [ :start, :enable]
end

#Create /tmp directory for mapreduce
pre = 'sudo -u hdfs hadoop fs -'
execute 'Creating tmp directory' do
    command "#{pre}mkdir #{node[:hdfs]['tmp_dir']}"
end

execute 'Change permissions of tmp' do
    command "#{pre}chmod -R 1777 #{node[:hdfs]['tmp_dir']}"
end

#Create tmp directory for mapreduce
execute 'Creating tmp directory for mapred' do
    command "#{pre}mkdir #{node[:hdfs]['mapred_tmp']}"
end

#Create /var directories for MapReduce
execute 'Creating var directories for mapred' do
    command "#{pre}mkdir #{node[:hdfs]['mapred_staging']}"
end

execute 'Changing permissions' do
    command "#{pre}chmod 1777 #{node[:hdfs]['mapred_staging']}"
end
execute 'Changing permissions' do
    command "#{pre}chown -R mapred #{node[:hdfs]['mapred_var']}"
end
execute 'Changing permissions' do
    command "#{pre}chown mapred:hadoop #{node[:hdfs]['mapred_tmp']}"
end
