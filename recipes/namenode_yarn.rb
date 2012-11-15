#
# Cookbook Name:: hadoop
# Recipe:: default
#
# Copyright 2009, Opscode, Inc.
#

include_recipe "hadoop::yarn"

#Namenode specific packages
package "hadoop-hdfs-namenode"
package "hadoop-yarn-nodemanager"
package "hadoop-hdfs-datanode"
package "hadoop-mapreduce"
