#Common attributes
default[:hadoop][:common][:hdfs]['dfs.permissions.superusergroup']              =   'hadoop'

#Namenode attributes
default[:hadoop][:namenode]['name']                                             =   'namenode'
default[:hadoop][:namenode]['port']                                             =   '8021'
default[:hadoop][:namenode][:hdfs]['dfs.namenode.name.dir']                     =   '/hdfs/namenode'
default[:hadoop][:namenode][:core]['fs.defaultFS']                              =   "hdfs://#{node[:hadoop][:namenode]['name']}"
default[:hadoop][:namenode][:mapred]['mapred.job.tracker']                      =   "#{node[:hadoop][:namenode]['name']}:#{node[:hadoop][:namenode]['port']}"
default[:hadoop][:namenode][:mapred]['mapreduce.jobtracker.restart.recover']    =   'true'

#Datanode attributes
default[:hadoop][:datanode][:hdfs]['dfs.datanode.data.dir']                     =   '/hdfs/data/1,/hdfs/data/2'
default[:hadoop][:datanode][:core]['fs.defaultFS']                              =   "hdfs://#{node[:hadoop][:namenode]['name']}"
default[:hadoop][:datanode][:mapred]['mapred.job.tracker']                      =   "#{node[:hadoop][:namenode]['name']}:#{node[:hadoop][:namenode]['port']}"
default[:hadoop][:datanode][:mapred]['mapred.local.dir']                        =   '/data/1/mapred/local,/data/2/mapred/local'
