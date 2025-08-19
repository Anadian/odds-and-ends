#!/bin/bash
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
alias ls-plus='ls -GAFosh'
alias ls-bins='ls ${PATH//:/ }';
#alias date-iso-utc='date -ju +%Y-%m-%dT%H:%M:%S%z'
#alias date-iso='date -j +%Y-%m-%dT%H:%M:%S%z'
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
#alias gtb='git branch'
#alias gtc='git checkout'
#alias gtm='git merge'
#alias gaa='git add --all'
git config --global user.name $GITHUB_USERNAME;
git config --global user.email 'willanad@yandex.com';
git config --global init.defaultBranch 'main';
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
#alias ssh-mbp='ssh -v cameron@192.168.0.105'
#alias ftp-mbp='sftp -v cameron@192.168.0.105'
#alias ssh-phone='ssh -v nemo@192.168.2.25'
#alias ftp-phone='sftp -v nemo@192.168.2.25'
#alias ssh-ubuntu='ssh -v cameron@192.168.0.177'
#alias ftp-ubuntu='sftp -v cameron@192.168.0.177'
alias ssh-galaxys8='ssh -p 8022 u0_a394@galaxys8'
alias ftp-galaxys8='sftp -P 8022 u0_a394@galaxys8'
# Domains for SSH URLs
export SSH_D7k='cameron@192.168.0.101:22';
export SSH_SGS8='u0_a394@192.168.0.46:8022';
export SSH_A15='willa@192.168.0.41:22';
#alias ssh-cn-d7k='ssh willa@cn-d7k';
#alias ftp-cn-d7k='sftp willa@cn-d7k';
if [[ $(uname -o) == 'GNU/Linux' ]]; then
	set meta-flag on;
	set input-meta on;
	set convert-meta on;
	set output-meta on;
fi
#if [[ $HOSTNAME == Anad-MBP* ]]; then
#	sudo cron -x ext,load,pars,misc,proc
#fi
source ~/.local/bin/bashmarks.sh
