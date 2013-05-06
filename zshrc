#killdevil specific module loading
if [[ `hostname -s` = killdevil* ]]; then
	#: -----------------------------------------
	#: Start of section that is NOT customizable.
	#: Do not remove or modify
	if [ -f /etc/profile.modules ]
	then
	       . /etc/profile.modules
		module load null mvapich_gcc python/2.7.1 git/1.7.1
	fi
	
	case "$0" in
	          -sh|sh|*/sh)  modules_shell=sh ;;
	       -ksh|ksh|*/ksh)  modules_shell=ksh ;;
	       -zsh|zsh|*/zsh)  modules_shell=zsh ;;
	    -bash|bash|*/bash)  modules_shell=bash ;;
	esac
	module() { eval `/nas02/apps/Modules/$MODULE_VERSION/bin/modulecmd $modules_shell $*`; }
	
	# Source global definitions
	if [ -f /etc/bashrc ]; then
	        . /etc/bashrc
	fi
	#: Do not remove or modify
	#: End of section that is NOT customizable.
	#: ----------------------------------------
fi

#tmux set -g status-fg black
#if [[ `hostname -s` = killdevil* ]]; then
#	tmux set -g status-bg white
#fi
#
#if [[ `hostname -s` = garin* ]]; then
#	tmux set -g status-bg cyan
#fi
#
#if [[ `hostname -s` = contador* ]]; then
#	tmux set -g status-bg green
#fi

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="timjacobs"
ZSH_THEME="jjgray"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

#Disable auto title renaming (for tmux)
# DISABLE_AUTO_TITLE=true

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git osx svn macports)

source $ZSH/oh-my-zsh.sh

bindkey -e
#bindkey "^R" history-incremental-search-backward

# only space for word delimiter
export WORDCHARS="*?_-.[]~=/&;!#$%^(){}<>"

#disable autocorrection
unsetopt correct_all

#each shell has own history
unsetopt sharehistory

#better dealing with ambiguous auto-completion
setopt list_ambiguous

__git_files () { 
    _wanted files expl 'local files' _files 
}

function git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

# Customize to your needs...
export PATH=$PATH:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/X11/bin
export PATH=$PATH:$HOME/bin
#:~/bin:~/local/bin
# next line for olungu MPI compile paths
export PATH=$HOME/bin:$HOME/local/bin:/usr/local/ncbi/blast/bin:/usr/bin:$PATH
export PATH=$PATH:/opt/local/bin:/opt/local/sbin

export PYTHONPATH=/Applications/MacPyMOL.app/pymol/

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export EDITOR=nano

HOST=$(uname -n | sed 's/\.[[:print:]]*//')
if [[ `hostname` = *tacc* ]]; then
	echo detected TACC environment
	module load git
#	module swap intel gcc
	module load python
	export PATH=$PATH:$WORK/svn/docking
	export PATH=$PATH:$WORK/svn/docking/pdb_scripts
	SSH_CLIENT_IP=$(echo $SSH_CLIENT | cut -f 1 -d" ")
    if [[ `hostname` = *ls* ]]; then
	    echo detected lonestar environment
    	module load blast
#	 	module load subversion
    	export HOST=lonestar
    elif [[ `hostname` = *stampede* ]]; then
    	echo detected stampede environment
    	HOST=stampede
    	export SQUEUE_FORMAT="%.7i %.9P %.14j %.8u %.2t %.10M %.6D %R" 
    fi
fi

source ~/dotfiles/aliases-jeff.zsh
source ~/local/pyrosetta/SetPyRosettaEnvironment.sh
export PATH=$PATH:$PYROSETTA

