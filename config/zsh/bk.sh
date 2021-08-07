#!/bin/bash
###################################################
# Filename: bk.sh
# Author: shing
# Email: www.asm.best
# Created: Thu Oct 29 12:09:18 2020
###################################################
if [ -f $1 ]; then
	echo "copy the file of [$1] to [$1.bkp]"
	cp $1{,.bkp}
elif [ -d $1 ]; then
	echo "copy the dir of [$1] to [$1.bkp]"
	cp -r $1{,.bkp}
else
	echo "copy [$1] to [$1.bkp]"
	cp $1{,.bkp}
fi
