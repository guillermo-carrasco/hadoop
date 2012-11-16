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
directory '/hdfs/namenode' do
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
execute 'Creating /tmp directory' do
    command "#{pre}mkdir /tmp"
end
execute 'Change permissions of /tmp' do
    command "#{pre}chmod -R 1777 /tmp"
end

#Create /var directories for MapReduce
%w{/var/lib/hadoop-hdfs/cache/mapred/mapred/staging /tmp/mapred/system}.each do |dir|
    execute 'Creating /tmp and /var HDFS directories' do
        command "#{pre}mkdir #{dir}"
    end
end

execute 'Changing permissions' do
    command "#{pre}chmod 1777 /var/lib/hadoop-hdfs/cache/mapred/mapred/staging"
end
execute 'Changing permissions' do
    command "#{pre}chown -R mapred /var/lib/hadoop-hdfs/cache/mapred"
end
execute 'Changing permissions' do
    command "#{pre}chown mapred:hadoop /tmp/mapred/system"
end

#Start mapreduce service
service "hadoop-0.20-mapreduce-jobtracker" do
    action [ :start, :enable]
end

#Create directories for the user vagrant
execute 'Creating user directory' do
    command "#{pre}mkdir /user/vagrant"
end
execute 'Changing permissions' do
    command "#{pre}chown vagrant /user/vagrant"
end

execute 'Add the user vagrant to the group hadoop' do
    command 'usermod -a -G hadoop vagrant'
end
