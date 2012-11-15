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

* `hadoop[:mirror_url]` - Get a mirror from http://www.apache.org/dyn/closer.cgi/hadoop/core/.
* `hadoop[:version]` - Specify the version of hadoop to install.
* `hadoop[:uid]` - Default userid of the hadoop user.
* `hadoop[:gid]` - Default group for the hadoop user.
* `hadoop[:java_home]` - You will probably want to change this to match where Java is installed on your platform.

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

[o1]:http://www.cloudera.com/content/cloudera/en/products/cdh.html

License and Author
==================

Author:: Joshua Timberman (<joshua@opscode.com>)

Copyright:: 2009, Opscode, Inc

Maintainer of this version: Guillermo Carrasco (<guillermo.carrasco@scilifelab.se>)


you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
