#
# Cookbook Name:: hadoop
# Recipe:: default
#


include_recipe "hadoop::repo"

package "hadoop"

#Copy config directory (couldn't find a better way to do it)
execute "Copy default config directory" do
    command "cp -r /etc/hadoop/conf.empty /etc/hadoop/conf.my_cluster"
    command "update-alternatives --install /etc/hadoop/conf hadoop-conf /etc/hadoop/conf.my_cluster/ 50"
    command "update-alternatives --set hadoop-conf /etc/hadoop/conf.my_cluster"
end
