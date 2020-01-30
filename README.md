# docker-cdft-uvas

The construction of this docker is an example. Here is built a climatologist environment with the tools: CDO, R 3.6.2 and some packages, and HdfsCLI to load data from a remote Hadoop server. 

A python script is available to list the files in a folder on the remote hdfs.

To be adapted to cases and uses.


# Instructions

Change the IP in the file hdfscli.cfg .

Change the paths in the files hdfs_list.py and run.sh to match those on the HDFS server.

Change the R script to run in the file run.sh .

Change the construction of the file tree structure in the Dockerfile.


# Build

docker build --tag my-image .
