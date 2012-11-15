#
# Cookbook Name:: hadoop
# Recipe:: default
#

include_recipe "hadoop"

#Secondary-namenode specific packages
package "hadoop-hdfs-secondarynamenode"
