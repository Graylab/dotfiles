ROSETTA3_DB=$HOME/rosetta/rosetta_database
export ROSETTA3_DB

MATLAB_USE_USERPATH=1
export MATLAB_USE_USERPATH

EDITOR=/usr/bin/vim
export EDITOR

TODOTXT_DEFAULT_ACTION=ls
export TODOTXT_DEFAULT_ACTION

alias t='~/Dropbox/TODO/todo.sh -d ~/Dropbox/TODO/todo.cfg'
alias pepo='psql -h killdevil-epo1.its.unc.edu -U postgres'

# User specific aliases and functions
alias myip="ifconfig | grep 'inet ' | grep -v 127.0.0.1 | cut -d\   -f2"
alias lambot="ssh -l tjacobs2 lambot.med.unc.edu"
#alias contador="mosh tjacobs2@contador.med.unc.edu"
alias contador="mosh tjacobs2@rosettadesign.med.unc.edu"
alias garin="mosh tim@garin.med.unc.edu"
alias killdevil="ssh -l tjacobs2 killdevil.unc.edu"
alias bakerlab="ssh -l tjacobs2 fw.bakerlab.org"
alias kure="ssh -l tjacobs2 kure.unc.edu"
alias vi="vim"
alias rm="rm -i"
alias df="df -h"
alias du="du -h"

PS1="%{$fg[red]%}###MAC:%{$reset_color%}%{$fg[yellow]%}%~%{$reset_color%}%{$fg[red]%}###
>%{$reset_color%}"

#zmv move command on steroids
autoload -U zmv
autoload -U zcp
#autoload -U zln

#extended globbing features
#setopt extended_glob

#options shell completion
#autoload -U compinit
#compinit

#vi mode
#bindkey -e
