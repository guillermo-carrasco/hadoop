#Common attributes

#Namenode attributes
default[:hadoop][:namenode][:hdfs]['dfs.permissions.superusergroup']            =   'hadoop'
default[:hadoop][:namenode][:hdfs]['dfs.namenode.name.dir']                     =   '/hdfs/namenode'
default[:hadoop][:namenode][:core]['fs.defaultFS']                              =   "hdfs://namenode/"
default[:hadoop][:namenode][:mapred]['mapred.job.tracker']                      =   "namenode:8021"
default[:hadoop][:namenode][:mapred]['mapreduce.jobtracker.restart.recover']    =   'true'

#Datanode attributes
default[:hadoop][:datanode][:hdfs]['dfs.permissions.superusergroup']            =   'hadoop'
default[:hadoop][:datanode][:hdfs]['dfs.datanode.data.dir']                     =   '/hdfs/data/1,/hdfs/data/2'
default[:hadoop][:datanode][:core]['fs.defaultFS']                              =   "hdfs://namenode/"
default[:hadoop][:datanode][:mapred]['mapred.job.tracker']                      =   "namenode:8021"
default[:hadoop][:datanode][:mapred]['mapred.local.dir']                        =   '/data/1/mapred/local,/data/2/mapred/local'
