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
