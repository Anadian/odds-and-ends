#!/bin/bash
# Variables
export PROFILE_DEBUG=0;
export PS1="[\[\033[1;31m\]\u\[\033[0;00m\]\[\033[0;00m\]@\[\033[0;00m\]\[\033[0;34m\]\h\[\033[0;00m\]:\[\033[0;36m\]\W\[\033[0;00m\]]\s\$ "
export PAGER=less
export VISUAL=nvim
export EDITOR=nvim
export GOPATH=$HOME/dev/go
export GITHUB_USERNAME='Anadian';
#printf 'PATH: %s\n' $PATH;
export HOMEBIN=$HOME/.local/bin;
export COREPACK_ENABLE_AUTO_PIN=0;
export COREPACK_ENABLE_PROJECT_SPEC=0;
export PNPM_HOME="$HOME/.local/share/pnpm";
export NODE_PATH="$PNPM_HOME/global/5/node_modules:$NODE_PATH:/usr/local/lib/node_modules:$HOME/.local/lib/node_modules";
export PATH=$HOMEBIN:$HOME/bin:$PNPM_HOME:/snap/bin:$PATH:$GOPATH/bin;
export RIPGREP_CONFIG_PATH="$HOME/dev/odds-and-ends/config/ripgreprc";
if [[ $(uname -o) == 'Android' ]]; then
	export NODE_PATH=/data/data/com.termux/files/usr/lib/node_modules:$NODE_PATH;
else
	eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)";
	export HOMEBREW_NO_EMOJI=1;
fi
# Aliases
alias ls-plus='ls -GAFosh';
alias ls-bins='ls ${PATH//:/ }';
alias date-iso='date +%Y-%m-%dT%H:%M:%S%z';
alias date-iso-utc='date -u +%Y-%m-%dT%H:%M:%S%z';
alias wget-plus='wget -nH -np -nd -k';
alias wget-plus-recursive='wget -nH -np -k -r';
alias diff-plus='diff -ays';
alias vi='nvim';
alias vim='nvim';
alias terminal-emulator='ps -o "command=" -p $(ps -o "ppid=" -p $$)';
if [[ -n $WAYLAND_DISPLAY ]]; then
	alias get-clipboard='wl-paste';
	alias set-clipboard='wl-copy';
else
	alias set-clipboard='xclip -selection clipboard'; 
	alias get-clipboard='xclip -selection clipboard -o';
fi
alias yt-dlp="yt-dlp --config-locations $HOME/dev/odds-and-ends/config/yt-dlp.conf";
alias grep='pcre2grep';
alias godot="MANGOHUD=0 $HOME/app/Godot_v4.4.1-stable_mono_linux_x86_64/Godot_v4.4.1-stable_mono_linux.x86_64";
alias retroarch="/usr/bin/flatpak run --branch=stable --arch=x86_64 --command=antimicrox --file-forwarding io.github.antimicrox.antimicrox --show @@ %f @@ & gamemoderun retroarch;";
alias melonds="/usr/bin/flatpak run --branch=stable --arch=x86_64 --command=antimicrox --file-forwarding io.github.antimicrox.antimicrox --show @@ %f @@ & gamemoderun melonds-emulator;";
alias doc="sudo docker";
alias ollama="sudo docker exec -it ollama ollama";
# Functions
empty-dir(){
	for ((i=1; i <= $#; i++))
	do
		if (( ${PROFILE_DEBUG:-0} == 1 )); then
			echo "$0 $FUNCNAME $# $i ${!i}";
		fi
		if [[ -d ${!i} ]]; then
			mv ${!i}/* . && rm -df ${!i};
		else
			echo "'${!i}' is not a directory.";
		fi
	done
	return 0;
}
full-path(){
	if (( ${PROFILE_DEBUG:-0} == 1 )); then
		echo "$0 $FUNCNAME $# $*";
	fi
	ls ${PWD}/$1
	return 0;
}
if [[ "$XDG_SESSION_DESKTOP" == 'Gnome' ]]; then
	gnome-screen-idle-delay(){
		_return=0;
		if (( $# == 1 )); then
			if (( ${PROFILE_DEBUG:-0} == 1 )); then
				log_string="$(date --utc --iso-8601='seconds') Setting the screen to turn off after $1 seconds of no input.";
				echo "$log_string";
				echo "$log_string" >> ~/gnome-screen.log;
			fi
			gsettings set org.gnome.desktop.session idle-delay $1;
			_return=0;
		else
			echo 'Error: must be exactly one argument given.';
			_return=1;
		fi
		return $_return;
	}
fi
# git config
git config --global user.name $GITHUB_USERNAME;
git config --global user.email 'willanad@yandex.com';
git config --global init.defaultBranch 'main';
git config --global pull.rebase false;
git config --global alias.b branch
git config --global alias.ck checkout
git config --global alias.m merge
git config --global alias.aa 'add --all'
git config --global alias.a add
git config --global alias.co commit
git config --global alias.cl clone
git config --global alias.pom 'pull origin main'
git config --global alias.pow 'pull origin wip'
git config --global alias.unstage 'reset HEAD ---'
git config --global alias.last 'log -l HEAD'
git config --global alias.cg 'config --global'
git config --global alias.change '!git add --all . && git commit -m '
git config --global alias.current-commit '!git --no-pager show | head -n 1';
# Remote
# Domains for SSH URLs
export A15_HOST='192.168.0.41';
export A15_USER='willa';
export D7k_HOST='192.168.0.101';
export D7k_USER='cameron';
export SGS8_HOST='192.168.0.46';
export SGS8_USER='u0_a394';
export SGS8_PORT_SSH='8022';
export SSH_D7k="$D7k_USER@$D7k_HOST:22";
export SSH_SGS8="$SGS8_USER@$SGS8_HOST:$SGS8_PORT_SSH";
export SSH_A15="$A15_USER@$A15_HOST:22";
# Shell options
if [[ $(uname -o) == 'GNU/Linux' ]]; then
	set meta-flag on;
	set input-meta on;
	set convert-meta on;
	set output-meta on;
fi
#if [[ $HOSTNAME == Anad-MBP* ]]; then
#	sudo cron -x ext,load,pars,misc,proc
#fi
# Sources
source ~/.local/bin/bashmarks.sh
