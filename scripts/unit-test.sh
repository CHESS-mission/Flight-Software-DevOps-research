#!/bin/bash


#check if an app name is specified
if [[ -z "$1" ]]
then
	echo "Please specify your app name, exiting..."
	exit 1
fi

#activate the python environnement
. ./fprime-venv/bin/activate

#purge an old app if it exists
cd $1
echo "PWD"
pwd
echo "purging..."; yes | fprime-util purge

#now exit on error
set -e

#build the app
echo "generating..."; fprime-util generate
fprime-util build

for dir in ./*
do
	if [[ -d "$dir/test" ]]
	then
		echo "\Detected component with unit test !"
	echo "Building unit test : $dir"
		cd $dir
		fprime-util build --ut
		echo "Testing $dir"
		fprime-util check
		cd ..
fi
done