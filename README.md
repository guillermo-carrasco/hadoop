Description
===========

Installs Apache hadoop and sets up a basic distributed cluster per the
quick start documentation.

Requirements
============

## Platform:

* Debian/Ubuntu

Tested on Ubuntu 12.04, though should work on most Linux distributions.

## Cookbooks:

* java

Attributes
==========
* Namenode attributes
	* `default[:hadoop][:namenode][:hdfs]['dfs.permissions.superusergroup']`: Define
	user to run HDFS daemons
	* `default[:hadoop][:namenode][:hdfs]['dfs.namenode.name.dir']`: Directory to store
	namenode HDFS data
	* `default[:hadoop][:namenode][:core]['fs.defaultFS']`: HDFS namenode URI
	* `default[:hadoop][:namenode][:mapred]['mapred.job.tracker']`: JobTracker hostname and port
	* `default[:hadoop][:namenode][:mapred]['mapreduce.jobtracker.restart.recover']`

* Datanode attributes
	* `default[:hadoop][:datanode][:hdfs]['dfs.permissions.superusergroup']`: Define
	user to run HDFS daemons
	* `default[:hadoop][:datanode][:hdfs]['dfs.datanode.data.dir']`: HDFS data dir
	(here is where HDFS stores the actual blocks of data)
	* `default[:hadoop][:datanode][:core]['fs.defaultFS']`: HDFS namenode URI
	* `default[:hadoop][:datanode][:mapred]['mapred.job.tracker']`: JobTracker hostname and port
	* `default[:hadoop][:datanode][:mapred]['mapred.local.dir']`: Local dirs for mapred temporal data

__IMPORTANT__: Change all appearances of "namenode" in the datanode attributed for
the proper hostname of the namenode

You may wish to add more attributes for tuning the configuration file templates.

Usage
=====
Thic cookbook installs the corresponding hadoop packages and daemons depending
on which node you specify. It uses [Cloudera's distribution][o1]. You can specify
which node are you installing:

* hadoop::namenode
* hadoop::datanode
* hadoop::namenode_yarn
* hadoop::datanode_yarn

The recipe also tune the configurations files. The installation will end up with
a ready-to-go hadoop cluster.

[o1]:http://www.cloudera.com/content/cloudera/en/products/cdh.html

License and Author
==================

Author:: Joshua Timberman (<joshua@opscode.com>)

Copyright:: 2009, Opscode, Inc

Contributions: Guillermo Carrasco (<guillermo.carrasco@scilifelab.se>)


you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
