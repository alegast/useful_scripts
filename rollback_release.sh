#!/bin/bash

# I use this script to make fast rollback, if last build was with critical error, etc ...
# it will work in typical web sites deploy structure:  current, releases. current - symlink to releases/2014-03-25_16-24-45.  symlink relocated after each build 
# there is regexp to check release dir. valid format is 2014-03-25_16-24-45 or 20140325162445
#

CURRENT=$(readlink current)
if [ -n "$CURRENT" ]
then
    printf "current build path $CURRENT \n"
else
    printf "current simlink is empty"
    CURRENT='some_not_matching_pattern'
fi
echo $CURRENT


while IFS='/' read -ra ADDR; do
      for i in "${ADDR[@]}"; do
          SEGMENT=$i
      done
done <<< "$CURRENT"

CURRENT=$SEGMENT
echo $CURRENT


releases=$(ls -t "releases" | grep -v $CURRENT | grep -e '[0-9]\{14\}' -e '[0-9]\{4\}-[0-9]\{2\}-[0-9]\{2\}_')
echo $releases


OLD_RELESES_CNT=$(ls -t "releases" | grep -v $CURRENT | grep -c -e '[0-9]\{14\}' -e '[0-9]\{4\}-[0-9]\{2\}-[0-9]\{2\}_' )

if [ $OLD_RELESES_CNT -gt 0 ]
then
        echo "releases in directory $OLD_RELESES_CNT";

        for i in $releases
        do
		unlink current
		printf "set current release $i ...\n";
		ln -s releases/$i current
		break

        done  
	printf "removing broken release $CURRENT \n"
	rm -rf releases/$CURRENT
else
        echo "not enough releases to make rollback"
fi


