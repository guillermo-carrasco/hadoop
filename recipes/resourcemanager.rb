#
# Cookbook Name:: hadoop
# Recipe:: default
#
# Copyright 2009, Opscode, Inc.
#

include_recipe "hadoop::yarn"

#RecourceManager specific packages
package "hadoop-yarn-resourcemanager"
