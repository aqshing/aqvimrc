##/bin/bash
###################################################
# Filename: configure.sh
# Author: shing
# E-mail: www.asm.best
# Created Time: Fri 09 Oct 2020 07:18:13 PM CST
###################################################

set -xeuo pipefail

##cd ~
##echo -n "your home: "
##pwd
##cd -

if [ -d "~/.vim" ]; then
	mkdir ~/.vim
fi
cp -r -a ./vim/* ~/.vim

if [ -d "~/.config" ]; then
	mkdir ~/.config
fi
cp -r -a ./config/* ~/.config
cp ./vimrc ~/.config/nvim/init.vim

##if [ -d "~/optappneovim/bin" ]; then
##	echo "路径不存在"
##	mkdir -p ~/optapp/neovim/bin
##else
##	echo "路径存在"
##fi
##cp ./nvim.appimage ~/optapp/neovim/bin
##cd ~/optapp/neovim/bin
##chmod u+x nvim.appimage
##ln -s nvim.appimage nvim
##ln -s nvim.appimage vi
##cd -

if [ -e "~/.local/share/nvim/site/autoload/plug.vim" ]; then
	cp ./plug.vim ~/.local/share/nvim/site/autoload/plug.vim
fi


##source ~/.bashrc
##vi +PlugInstall
