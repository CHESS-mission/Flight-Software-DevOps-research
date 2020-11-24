#!/bin/bash

#check if an app name is specified
if [[ -z "$1" ]]
then
	echo "Please specify your app name, exiting..."
	exit 1
fi

#activate the python environnement
. ./fprime-venv/bin/activate

#exit on error
set -e

#build the unit test
cd $1
for dir in ./*
do
	if [[ -d "$dir/test" ]]
	then
		echo "Detected component with unit test !"
		echo "Building unit test : $dir"
		cd $dir
		fprime-util build --ut
		echo "Testing $dir"
		fprime-util check
		cd ..
	fi
done