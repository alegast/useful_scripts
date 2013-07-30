#!/bin/bash

# our release dirs looks like 20130707145203 or 2013_07-07_***
files=$(ls -tr | grep -e '[0-9]\{14\}' -e '[0-9]\{4\}-[0-9]\{2\}-[0-9]\{2\}_')

OLD_RELESES_CNT=$(ls -t | grep -c -e '[0-9]\{14\}' -e '[0-9]\{4\}-[0-9]\{2\}-[0-9]\{2\}_')
KEEP_RELEASES_CNT=5

if [ $OLD_RELESES_CNT -gt $KEEP_RELEASES_CNT ]
then
        echo "releases in directory $OLD_RELESES_CNT";
        REMOVE_RELEASES_CNT=$(( OLD_RELESES_CNT - KEEP_RELEASES_CNT ))
	REMOVED=0
        for i in $files
        do
		if [ $REMOVED -gt $REMOVE_RELEASES_CNT ] || [ $REMOVED -eq $REMOVE_RELEASES_CNT ]
		then 
			break
		else
			echo "removing $i ...";
			rm -rf $i
			REMOVED=$(( REMOVED +1 ))
		fi
        done  
else
        echo "not enought releases"
fi



