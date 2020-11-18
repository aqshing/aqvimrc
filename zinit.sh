#!/bin/bash
###################################################
# Filename: zinit.sh
# Author: shing
# Email: www.asm.best
# Created: Thu Nov  5 20:53:24 2020
# Changed: 2020-11-18 13:41:01
###################################################

##set -xeuo pipefail

if [ ! -d ~/.zinit ]; then
	mkdir ~/.zinit
	git clone https://github.com/zdharma/zinit.git ~/.zinit/bin
fi

if [ ! -e ~/.zshrc ]; then
	cp ./zshrc ~/.zshrc
else
	echo "If your ZSHRC does not include the following,"
	echo "Please add them to [~/.zshrc]."
	cat ./zshrc
fi
