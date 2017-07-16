#!/bin/bash
chmod 777 getrom searchrom remove.pl empty-dir git-lazy git-current clang-search-paths clang-linker-info clang-predefined-macros gcc-predefined-macros gcc-search-paths;
ln remove.pl /usr/local/bin/remove.pl;
ln getrom /usr/local/bin/getrom;
ln searchrom /usr/local/bin/searchrom;
ln empty-dir /usr/local/bin/empty-dir;
ln git-lazy /usr/local/bin/git-lazy;
ln git-current /usr/local/bin/git-current;
ln clang-search-paths /usr/local/bin/clang-search-paths;
ln clang-linker-info /usr/local/bin/clang-linker-info;
ln clang-predefined-macros /usr/local/bin/clang-predefined-macros;
ln gcc-predefined-macros /usr/local/bin/gcc-predefined-macros;
ln gcc-search-paths /usr/local/bin/gcc-search-paths;
ln profilerc ~/.profilerc
ln vimrc ~/.vimrc
ln expansions ~/.expansions
