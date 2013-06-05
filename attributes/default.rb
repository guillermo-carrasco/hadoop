#Common attributes
default['HADOOP_HOME']															=	'/usr/lib/hadoop/client-0.20/'
default['HADOOP_VERSION']														=	'2.0.0-cdh4.3.0'

#Namenode attributes
default[:hadoop][:namenode][:hdfs]['dfs.permissions.superusergroup']            =   'hadoop'
default[:hadoop][:namenode][:hdfs]['dfs.namenode.name.dir']                     =   "/hdfs/#{node['hostname']}"
default[:hadoop][:namenode][:core]['fs.defaultFS']                              =   "hdfs://#{node['hostname']}/"
default[:hadoop][:namenode][:mapred]['mapred.job.tracker']                      =   "#{node['hostname']}:8021"
default[:hadoop][:namenode][:mapred]['mapreduce.jobtracker.restart.recover']    =   'true'

#Datanode attributes
default[:hadoop][:datanode][:hdfs]['dfs.permissions.superusergroup']            =   'hadoop'
default[:hadoop][:datanode][:hdfs]['dfs.datanode.data.dir']                     =   '/hdfs/data/1,/hdfs/data/2'
default[:hadoop][:datanode][:core]['fs.defaultFS']                              =   "hdfs://namenode/"
default[:hadoop][:datanode][:mapred]['mapred.job.tracker']                      =   "namenode:8021"
default[:hadoop][:datanode][:mapred]['mapred.local.dir']                        =   '/data/1/mapred/local,/data/2/mapred/local'

#HDFS attributes
default[:hdfs]['tmp_dir']														=	'/tmp'
default[:hdfs]['mapred_tmp']													=	'/tmp/mapred/system'
default[:hdfs]['mapred_var']													=	'/var/lib/hadoop-hdfs/cache/mapred'
default[:hdfs]['mapred_staging']												=	'/var/lib/hadoop-hdfs/cache/mapred/mapred/staging'

#Pseudo-distributed mode attributes
default[:hadoop][:pseudo]['user']												=	'travis'