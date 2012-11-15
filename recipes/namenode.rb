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
