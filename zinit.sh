#!/bin/bash
###################################################
# Filename: zinit.sh
# Author: shing
# Email: www.asm.best
# Created: Thu Nov  5 20:53:24 2020
###################################################

set -xeuo pipefail

if [ -d "~/.zinit" ]; then
	mkdir ~/.zinit
	git clone https://github.com/zdharma/zinit.git ~/.zinit/bin
fi

if [ ! -f "~/.zshrc" ]; then
	cp ./zshrc ~/.zshrc
else
	echo "please add to your [~/.zshrc]"
	cat ./zshrc
fi
