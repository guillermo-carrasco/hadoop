#
# Cookbook Name:: hadoop
# Recipe:: default
#


include_recipe "hadoop::repo"

package "hadoop"

#Copy config directory (couldn't find a better way to do it)
execute "Copy default config directory" do
    command "cp -r /etc/hadoop/conf.empty /etc/hadoop/conf.my_cluster"
end

#Install and configure update-alternatives
execute "Install update alternatives" do
    command "update-alternatives --install /etc/hadoop/conf hadoop-conf /etc/hadoop/conf.my_cluster 50"
end

execute "Set links properly" do
    command "update-alternatives --set hadoop-conf /etc/hadoop/conf.my_cluster"
end

#Create a file in /etc/profile.d to export HADOOP_HOME variable
directory "/etc/profile.d" do
  mode 00755
end

hadoop_home_and_version = { :value => "#{node['HADOOP_HOME']}", :version => "#{node['HADOOP_VERSION']}" }
template '/etc/profile.d/hadoop_home.sh' do
    source 'hadoop_home.erb'
    mode 0755
    owner "root"
    group "root"
    action :create
    variables hadoop_home_and_version
end

#Set the environment variable for this provess
ruby_block "Setting HADOOP_HOME environment variable for this process" do
  block do
    ENV['HADOOP_HOME'] = "#{node['HADOOP_HOME']}"
  end
end