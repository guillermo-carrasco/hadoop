#
# Cookbook Name:: hadoop
# Recipe:: Pseudo
#
#

include_recipe "hadoop"

#Install Hadoop in pseudo-distributed mode
package "hadoop-0.20-conf-pseudo"

#Point to pseudo distributed mode configuration
execute "Removing soft link to distributed mode configuration" do
	command "rm /etc/hadoop/conf"
end

#Create soft link to hadoop lib
link "/etc/hadoop/conf" do
    to "/etc/hadoop/conf.pseudo.mr1"
    link_type :symbolic
    action :create
end

#Prepare HDFS
execute "Format namenode" do
    command "sudo -u hdfs hdfs namenode -format"
end

execute "Start HDFS" do
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
	command "for x in /etc/init.d/hadoop-0.20-mapreduce-* ; do $s start ; done"
end

user = node[:hadoop][:pseudo]['user']
execute "Create user directories" do
	command "sudo -u hdfs hadoop fs -mkdir /user/#{user} && sudo -u hdfs hadoop fs -chown  /user/#{user}"
end

