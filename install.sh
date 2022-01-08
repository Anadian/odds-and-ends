#!/bin/bash
#install.sh
mode=0;
if [[ $1 == 'uninstall' ]]; then
	mode=1;
	install_command='rm -f';
elif [[ $1 == 'symbolic' ]]; then
	mode=2;
	install_command='ln -fs';
elif [[ $1 == 'copy' ]]; then
	mode=3;
	install_command='cp -f';
else
	mode=0;
	install_command='ln -f';
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
declare -A Map=(
	#scripts/bash
	['scripts/bash/clang-linker-info.sh']="$install_directory/clang-linker-info"
	['scripts/bash/clang-predefined-macros.sh']="$install_directory/clang-predefined-macros"
	['scripts/bash/clang-search-paths.sh']="$install_directory/clang-search-paths"
	#['scripts/bash/clense-bad-roms.sh']="$install_directory/clense-bad-roms"
	['scripts/bash/create-c-project-directories.sh']="$install_directory/create-c-project-directories"
	#['scripts/bash/create-node-project-directories.sh']="$install_directory/create-node-project-directories"
	#['scripts/bash/create-node-project-directory.sh']="$install_directory/create-node-project-directory"
	['scripts/bash/empty-dir.sh']="$install_directory/empty-dir"
	#['scripts/bash/exp_files.sh']="$install_directory/exp_files"
	['scripts/bash/full-path.sh']="$install_directory/full-path"
	['scripts/bash/gcc-predefined-macros.sh']="$install_directory/gcc-predefined-macros"
	['scripts/bash/gcc-search-paths.sh']="$install_directory/gcc-search-paths"
	#['scripts/bash/getrom.sh']="$install_directory/getrom"
	['scripts/bash/git-current.sh']="$install_directory/git-current"
	['scripts/bash/git-lazy.sh']="$install_directory/git-lazy"
	['scripts/bash/git-update.sh']="$install_directory/git-update"
	['scripts/bash/gnome-screen-idle-delay.sh']="$install_directory/gnome-screen-idle-delay"
	['scripts/bash/gnome-screen-idle-delay-10.sh']="$install_directory/gnome-screen-idle-delay-10"
	['scripts/bash/gnome-screen-idle-delay-600.sh']="$install_directory/gnome-screen-idle-delay-600"
	['scripts/bash/init-go-project.sh']="$install_directory/init-go-project"
	['scripts/bash/mac-idle-time.sh']="$install_directory/mac-idle-time"
	['scripts/bash/profilerc.sh']="~/.profilerc"
	#['scripts/bash/searchrom.sh']="$install_directory/searchrom"
	['scripts/bash/git-fatfiles.sh']="$install_directory/git-fatfiles"
	['scripts/bash/git-listobjectsbysize.sh']="$install_directory/git-listobjectsbysize"
	#scripts/vim
	['scripts/vim/expansions.vim']="~/.expansions"
	['scripts/vim/external_expand.vim']="~/.external_expand"
	#scripts/node
	['scripts/node/create-github-project.js']="$install_directory/create-github-project"
	['scripts/node/init-node-project.js']="$install_directory/init-node-project"
	#config/vim
	['config/vimrc']="~/.vimrc"
	['config/nvim_init.vim']="~/.config/nvim/init.vim"
);
#install_command='echo';
chmod_command='chmod 777';
if [[ $mode != 1 ]]; then
	map_keys_string=${!Map[@]};
	echo $map_keys_string;
	#declare -a map_keys_array=( $map_keys_string ); #working
	#echo ${map_keys_array[0]};
	for key_string in "${!Map[@]}"; do
		#echo $key_string;
		$chmod_command $key_string;
		$install_command "$key_string" "${Map[$key_string]}";
	done
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
