#
# Cookbook Name:: hadoop
# Recipe:: Pseudo
#
#

include_recipe "hadoop::repo"

#Install Hadoop in pseudo-distributed mode
package "hadoop-0.20-conf-pseudo"
package "hadoop-hdfs-datanode"
package "hadoop-client"


#Install and configure update-alternatives
execute "Install update alternatives" do
    command "update-alternatives --install /etc/hadoop/conf hadoop-conf /etc/hadoop/conf.pseudo.mr1 50"
end

execute "Set links properly" do
    command "update-alternatives --set hadoop-conf /etc/hadoop/conf.pseudo.mr1"
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
    ENV['HADOOP_VERSION'] = "#{node['HADOOP_VERSION']}"
  end
end

#Create soft link to hadoop lib
link "#{node['HADOOP_HOME']}/lib" do
    to "#{node['HADOOP_HOME']}/../lib"
    link_type :symbolic
    action :create
end

#Prepare HDFS
execute "Format namenode" do
    command "sudo -u hdfs hdfs namenode -format"
end

#Start and enable the HDFS services
service "hadoop-hdfs-namenode" do
    action :start
end

#Try the traditionas way
execute "Restarting hadoop services" do
    command "for s in /etc/init.d/hadoop-*; do $s restart; done"
end

execute "Create HDFS dirs" do
	command "sudo -u hdfs hadoop fs -mkdir -p /tmp && sudo -u hdfs hadoop fs -chmod -R 1777 /tmp"
end

execute "Create mapreduce system directories" do
	command "sudo -u hdfs hadoop fs -mkdir -p /var/lib/hadoop-hdfs/cache/mapred/mapred/staging"
end

execute "Create mapreduce system directories" do
	command "sudo -u hdfs hadoop fs -chmod 1777 /var/lib/hadoop-hdfs/cache/mapred/mapred/staging"
end

execute "Create mapreduce system directories" do
	command "sudo -u hdfs hadoop fs -chown -R mapred /var/lib/hadoop-hdfs/cache/mapred"
end

execute "Start MapReduce" do
	command "for s in /etc/init.d/hadoop-0.20-mapreduce-* ; do $s start ; done"
end

user = node[:hadoop][:pseudo]['user']
execute "Create user directories" do
	command "sudo -u hdfs hadoop fs -mkdir /user/#{user} && sudo -u hdfs hadoop fs -chown #{user} /user/#{user}"
end

