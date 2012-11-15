#
# Cookbook Name:: hadoop
# Recipe:: default
#
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "hadoop::yarn"

#Datanode specific packages
package "hadoop-yarn-nodemanager"
package "hadoop-hdfs-datanode"
package "hadoop-mapreduce"
package "hadoop-client"
