#!/bin/bash
#install.sh
if [[ $1 == 'uninstall' ]]; then
	mode=1;
else
	mode=0;
fi
if [[ $EUID == 0 ]]; then
	#printf 'We are root.\n';
	install_directory='/usr/local/bin';
	#npm global dependencies.
	npm i -g shelljs inquirer;
else
	install_directory=$HOME/.local/bin;
	mkdir -p $install_directory;
fi

if [[ $mode != 1 ]]; then
	#scripts/bash
	chmod 777 'scripts/bash/clang-linker-info.sh';
	ln -f 'scripts/bash/clang-linker-info.sh' $install_directory/clang-linker-info;
	chmod 777 'scripts/bash/clang-predefined-macros.sh';
	ln -f 'scripts/bash/clang-predefined-macros.sh' $install_directory/clang-predefined-macros;
	chmod 777 'scripts/bash/clang-search-paths.sh';
	ln -f 'scripts/bash/clang-search-paths.sh' $install_directory/clang-search-paths;
	#chmod 777 'scripts/bash/clense-bad-roms.sh';
	#ln -f 'scripts/bash/clense-bad-roms.sh' $install_directory/clense-bad-roms;
	chmod 777 'scripts/bash/create-c-project-directories.sh';
	ln -f 'scripts/bash/create-c-project-directories.sh' $install_directory/create-c-project-directories;
	#chmod 777 'scripts/bash/create-node-project-directories.sh';
	#ln -f 'scripts/bash/create-node-project-directories.sh' $install_directory/create-node-project-directories;
	#chmod 777 'scripts/bash/create-node-project-directory.sh';
	#ln -f 'scripts/bash/create-node-project-directory.sh' $install_directory/create-node-project-directory;
	chmod 777 'scripts/bash/empty-dir.sh';
	ln -f 'scripts/bash/empty-dir.sh' $install_directory/empty-dir;
	#chmod 777 'scripts/bash/exp_files.sh';
	#ln -f 'scripts/bash/exp_files.sh' $install_directory/exp_files;
	chmod 777 'scripts/bash/full-path.sh';
	ln -f 'scripts/bash/full-path.sh' $install_directory/full-path;
	chmod 777 'scripts/bash/gcc-predefined-macros.sh';
	ln -f 'scripts/bash/gcc-predefined-macros.sh' $install_directory/gcc-predefined-macros;
	chmod 777 'scripts/bash/gcc-search-paths.sh';
	ln -f 'scripts/bash/gcc-search-paths.sh' $install_directory/gcc-search-paths;
	#chmod 777 'scripts/bash/getrom.sh';
	#ln -f 'scripts/bash/getrom.sh' $install_directory/getrom;
	chmod 777 'scripts/bash/git-current.sh';
	ln -f 'scripts/bash/git-current.sh' $install_directory/git-current;
	chmod 777 'scripts/bash/git-lazy.sh';
	ln -f 'scripts/bash/git-lazy.sh' $install_directory/git-lazy;
	chmod 777 'scripts/bash/git-update.sh';
	ln -f 'scripts/bash/git-update.sh' $install_directory/git-update;
	chmod 777 'scripts/bash/gnome-screen-idle-delay.sh';
	ln -f 'scripts/bash/gnome-screen-idle-delay.sh' $install_directory/gnome-screen-idle-delay;
	chmod 777 'scripts/bash/gnome-screen-idle-delay-10.sh';
	ln -f 'scripts/bash/gnome-screen-idle-delay-10.sh' $install_directory/gnome-screen-idle-delay-10;
	chmod 777 'scripts/bash/gnome-screen-idle-delay-600.sh';
	ln -f 'scripts/bash/gnome-screen-idle-delay-600.sh' $install_directory/gnome-screen-idle-delay-600;
	chmod 777 'scripts/bash/init-go-project.sh';
	ln -f 'scripts/bash/init-go-project.sh' $install_directory/init-go-project;
	chmod 777 'scripts/bash/mac-idle-time.sh';
	ln -f 'scripts/bash/mac-idle-time.sh' $install_directory/mac-idle-time;
	chmod 777 'scripts/bash/profilerc.sh';
	ln -f 'scripts/bash/profilerc.sh' ~/.profilerc;
	#chmod 777 'scripts/bash/searchrom.sh';
	#ln -f 'scripts/bash/searchrom.sh' $install_directory/searchrom;
	chmod 777 'scripts/bash/git-fatfiles.sh';
	ln -f 'scripts/bash/git-fatfiles.sh' $install_directory/git-fatfiles;
	chmod 777 'scripts/bash/git-listobjectsbysize.sh';
	ln -f 'scripts/bash/git-listobjectsbysize.sh' $install_directory/git-listobjectsbysize;
	#scripts/vim
	chmod 777 'scripts/vim/expansions.vim';
	ln -f 'scripts/vim/expansions.vim' ~/.expansions;
	chmod 777 'scripts/vim/external_expand.vim';
	ln -f 'scripts/vim/external_expand.vim' ~/.external_expand;
	#scripts/node
	chmod 777 'scripts/node/create-github-project.js';
	ln -f 'scripts/node/create-github-project.js' $install_directory/create-github-project;
	chmod 777 'scripts/node/init-node-project.js';
	ln -f 'scripts/node/init-node-project.js' $install_directory/init-node-project;
else
	#scripts/bash
	rm -f $install_directory/clang-linker-info;
	rm -f $install_directory/clang-predefined-macros;
	rm -f $install_directory/clang-search-paths;
	rm -f $install_directory/clense-bad-roms;
	rm -f $install_directory/create-c-project-directories;
	rm -f $install_directory/create-node-project-directories;
	rm -f $install_directory/create-node-project-directory;
	rm -f $install_directory/empty-dir;
	rm -f $install_directory/exp_files;
	rm -f $install_directory/full-path;
	rm -f $install_directory/gcc-predefined-macros;
	rm -f $install_directory/gcc-search-paths;
	rm -f $install_directory/getrom;
	rm -f $install_directory/git-current;
	rm -f $install_directory/git-lazy;
	rm -f $install_directory/git-update;
	rm -f $install_directory/gnome-screen-idle-delay;
	rm -f $install_directory/gnome-screen-idle-delay-10;
	rm -f $install_directory/gnome-screen-idle-delay-600;
	rm -f $install_directory/init-go-project;
	rm -f $install_directory/mac-idle-time;
	rm -f $install_directory/searchrom;
	rm -f $install_directory/git-fatfiles;
	rm -f $install_directory/git-listobjectsbysize;
	rm -f $install_directory/create-github-project;
	rm -f $install_directory/init-node-project;
fi
#config
chmod 777 'config/vimrc';
ln -f config/vimrc ~/.vimrc;
chmod 777 'config/nvim_init.vim';
mkdir -p ~/.config/nvim;
ln -f config/nvim_init.vim ~/.config/nvim/init.vim;
