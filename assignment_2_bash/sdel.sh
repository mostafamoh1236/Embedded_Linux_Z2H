#!/bin/bash

if [[ ! -d ~/TRASH ]]
then
	echo "You don't have a TRASH folder, let's create one for you"
	mkdir ~/TRASH
else
	echo "You have your own TRASH folder"
fi

for filee in "$@"
do
  if [ $(file $filee | cut -d":" -f2 | cut -d" " -f2) != 'gzip' ]
  then
	gzip -f $filee
	mv $filee.gz ~/TRASH	
  else
        mv $filee ~/TRASH
  fi
done

cd ~/TRASH

for filee in $(ls)
do
  if [ $(($(($(date +%s)/3600 - $(date -r $filee +%s)/3600)) > 48)) == 1 ]
  then
	rm $filee
  else
  echo "less than the time period"
  fi
done
