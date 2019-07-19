#!/bin/bash
#Pseudo-command permissions
chmod 777 getrom;
chmod 777 searchrom;
chmod 777 remove.pl; 
chmod 777 empty-dir;
chmod 777 git-lazy;
chmod 777 git-current;
chmod 777 git-update;
chmod 777 clang-search-paths;
chmod 777 clang-linker-info;
chmod 777 clang-predefined-macros;
chmod 777 gcc-predefined-macros;
chmod 777 gcc-search-paths;
chmod 777 full-path;
chmod 777 create-node-project-directory.sh;
chmod 777 new-github-repository.sh;
chmod 777 create-c-project-directories.sh;
chmod 777 create-node-project-directories.sh;
#config permissions
chmod 777 crontab;
chmod 777 profilerc;
chmod 777 vimrc;
chmod 777 nvim_init.vim;
chmod 777 openSUSE_15_1_init.sh;
#/usr/local/bin stuff
ln -f remove.pl /usr/local/bin/remove.pl;
ln -f getrom /usr/local/bin/getrom;
ln -f searchrom /usr/local/bin/searchrom;
ln -f empty-dir /usr/local/bin/empty-dir;
ln -f git-lazy /usr/local/bin/git-lazy;
ln -f git-current /usr/local/bin/git-current;
ln -f git-update /usr/local/bin/git-update;
ln -f clang-search-paths /usr/local/bin/clang-search-paths;
ln -f clang-linker-info /usr/local/bin/clang-linker-info;
ln -f clang-predefined-macros /usr/local/bin/clang-predefined-macros;
ln -f gcc-predefined-macros /usr/local/bin/gcc-predefined-macros;
ln -f gcc-search-paths /usr/local/bin/gcc-search-paths;
ln -f full-path /usr/local/bin/full-path;
ln -f create-node-project-directory.sh /usr/local/bin/create-node-project-directory;
ln -f new-github-repository.sh /usr/local/bin/new-github-repository;
ln -f create-c-project-directories.sh /usr/local/bin/create-c-project-directories;
ln -f create-node-project-directories.sh /usr/local/bin/create-node-project-directories;
#home stuff
ln -f profilerc ~/.profilerc;
ln -f vimrc ~/.vimrc;
ln -f expansions.vim ~/.expansions;
ln -f external_expand.vim ~/.external_expand;
mkdir -p ~/.config/nvim
ln -f nvim_init.vim ~/.config/nvim/init.vim;
