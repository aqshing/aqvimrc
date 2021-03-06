#!/bin/bash
###################################################
# Filename: mbk.sh
# Author: shing
# Email: www.asm.best
# Created: Thu Oct 29 12:09:18 2020
###################################################

##set -xeuo pipefail

if [ -f $1 ]; then
	echo "move the file of [$1] to [$1.bkp]"
	mv $1{,.bkp}
elif [ -d $1 ]; then
	echo "move the dir of [$1] to [$1.bkp]"
	mv $1{,.bkp}
elif [ $1 == "-r" ]; then
	echo "restore [$2.bkp] to [$2]"
	mv $2{.bkp,}
elif [ $1 == "-h" -o $1 == "--help" ]; then
	printf "mbk(move backup): move file to file.backup\n"
	printf "usage: mbk [FILE]: move FILE to FILE.bkp\n"
	printf "       mbk -r [FILE]: move FILE.bkp to FILE\n"
	printf "       mbk --help: ask for help\n"
	printf "eg: if you have a file, the file name is test.txt\n"
	printf "    you can use the command: mbk test.txt\n"
	printf "    move test.txt to test.txt.bkp\n"
	printf "    you also use the command: mbk -r test.txt\n"
	printf "    move test.txt.bkp to test.txt\n"
else
	echo "move [$1] to [$1.bkp]"
	mv $1{,.bkp}
fi
