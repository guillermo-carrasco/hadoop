#
# Cookbook Name:: hadoop
# Recipe:: default
#
# Copyright 2009, Opscode, Inc.
#

include_recipe "hadoop::yarn"

#Datanode specific packages
package "hadoop-yarn-nodemanager"
package "hadoop-hdfs-datanode"
package "hadoop-mapreduce"
package "hadoop-client"
package "hadoop-mapreduce-historyserver"
package "hadoop-yarn-proxyserver"
