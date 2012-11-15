#
# Cookbook Name:: hadoop
# Recipe:: default
#

include_recipe "hadoop::repo"

package "hadoop-yarn"

