#
# Cookbook Name:: hadoop
# Recipe:: default
#

include_recipe "hadoop::yarn"

#Secondary-namenode specific packages
package "hadoop-hdfs-secondarynamenode"
package "hadoop-yarn-nodemanager"
package "hadoop-hdfs-datanode"
package "hadoop-mapreduce"
