import os
import argparse
from subprocess import check_call as ck

import pydoop.hdfs as hdfs


def _configure(command, opts=None):

    s3 = 'http://scilifelabgenomics.s3.amazonaws.com/seal_data/{file}'
    test_files = ['ecoli.tar', 'test.prq']

    chef_recipe = """
    sed -i 's/repo/{type}/g' node.json
    """

    execute_recipe = """
    sudo chef-solo -c solo.rb -j node.json
    """

    if command == 'namenode':
        #Set the recipe to execute
        chef_recipe = chef_recipe.format(type='namenode')
        ck(chef_recipe, shell=True)
        print 'Executing recipe hadoop::' + str(command) + '...'
        ck(execute_recipe, shell=True)
        

    elif command == 'datanode':
        chef_recipe = chef_recipe.format(type='datanode')
        ck(chef_recipe, shell=True)
        if not opts:
            raise AttributeError('Please specify the internal name of the namenode in this cluster.')

        change_attributes = """
        sed -i 's/namenode\//{ops}\//g' cookbooks/hadoop/attributes/default.rb
        """.format(ops=str(opts))
        ck(change_attributes, shell=True)
        change_attributes = """
        sed -i 's/namenode:/{ops}:/g' cookbooks/hadoop/attributes/default.rb
        """.format(ops=str(opts))
        ck(change_attributes, shell=True)
        ck(execute_recipe, shell=True)
        services = """
        for s in /etc/init.d/hadoop-*; do sudo $s restart; done
        """
        ck(services, shell=True)

    else:
        print 'Downloading test data from S3...'
        for f in test_files:
            cl = ['wget', s3.format(file=f)]
            ck(cl)
        print 'Moving data to HDFS...'
        hdfs.mkdir('reference_genomes')
        hdfs.mkdir('input_seal')
        hdfs.put('ecoli.tar', 'reference_genomes')
        hdfs.put('test.prq', 'input_seal')


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description = 'Script to configure Amazon hadoop nodes')
    #Positional arguments (mutual exclusive)
    sp = parser.add_subparsers(dest = 'command')
    sp.add_parser('namenode', help = "Run hadoop::namenode recipe")
    sp.add_parser('datanode', help = "Modifies attributes to point")
    sp.add_parser('get_data', help = "Get test data and copy it to the HDFS")
    #Optional arguments
    parser.add_argument('-n', '--namenode', help = "When installing in a datanode, specify the namenode")

    args = parser.parse_args()
    _configure(args.command, args.namenode)