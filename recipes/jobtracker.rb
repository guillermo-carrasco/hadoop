#
# Cookbook Name:: hadoop
# Recipe:: default
#
# Copyright 2009, Opscode, Inc.
#

include_recipe "hadoop"

#Jobtracker specific packages
package "hadoop-0.20-mapreduce-jobtracker"
