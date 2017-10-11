#!/bin/bash
chmod 777 getrom searchrom remove.pl empty-dir git-lazy git-current git-update clang-search-paths clang-linker-info clang-predefined-macros gcc-predefined-macros gcc-search-paths crontab full-path;
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
ln -f profilerc ~/.profilerc;
ln -f vimrc ~/.vimrc;
ln -f expansions ~/.expansions;
