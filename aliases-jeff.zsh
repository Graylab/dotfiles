#!/bin/zsh
# aliases JJG 2/2013

##################################################
##### zsh shortcuts, universal
##################################################

# simple shell stuff
UNAME=`uname`
alias rm='rm -i'
#setenv CLICOLOR true # mac setting
alias ls='ls -FG'
#alias ls='ls -FG --color'
alias la='"ls" -FGa'
alias ll='ls -l'
alias lla='la -l'
alias lx='ll --sort=extension'
alias lt='ll --sort=time'
function ltop() { ll --sort=time    |head; }
function lst () { ll --sort=time $@ |head; }
alias lsd='ltop'
alias lsize='lla --sort=size'
alias lss='lla --sort=size|head -30'
alias dir='ls'
alias bk='cd -'
alias cd-='cd -'
alias cd..='cd ..'
alias up='cd..'
alias ..='cd..'
alias sl='ls'
alias l='less'
function lld
{
    ls -lFG "$@" | egrep '^d|total'
    ls -lFG "$@" | egrep -v '^d|total';
}

# program shortcuts
alias emacs='emacs -fg white -bg black'
alias gv='ghostview'
alias gvbw='ghostview -fg black -bg white'
alias llocate='find ~/* | grep '
alias rmcores='rm $(eval find ~/* | grep /core)'
alias f='finger'
alias tarz='tar -cvzf '
alias untarz='tar -xvzf '
alias untar='tar -xvf '
alias why='echo because'
alias rtfm='man -M /usr/local/gnu/man'
alias e='pico'
#if [ -e /usr/bin/nano ]; then alias pico='nano';fi
#if [ -e /usr/bin/pico ]; then alias nano='pico';fi
alias m='pine'
alias c='clear'
alias g='gnuplot'
alias t='ssh'
alias h='history'
alias bye='exit'
alias adios='exit'
alias adieu='exit'
alias ciao='exit'
alias quit='exit'
alias top='top -o cpu'

# make with more processors if SMP kernel
if uname -a | grep -iq smp
then
    alias make='nice -5 make -j6'
fi

#in du, measure in kilobytes, human readable
alias df='df -h'
alias du='du -kh'
# disk usage -- list only directories, and sort
function dubrief  ### try du -s ?
{
    'du' -kh $@ |  grep -vE '/.+/'
}

function dusort
{
    'du' -k $@ | grep -vE '/.+/' | sort -n -r
}

function countfiles
{
	find -maxdepth 1 -type d | while read -r dir; do printf "%s:\t" "$dir"; find "$dir" | wc -l; done
}

alias realias='source ~/dotfiles/aliases-jeff.zsh;
  if [ -f ~/.$HOST\rc ]; then source ~/.$HOST\rc; fi;'

#from jed@dotfiles.com
alias gif='IMG="<img src=" ; IMG2="border=0 align=center>"; echo " ">00gif.html; for x in *.gif ; do echo "<BR><P>$x $IMG$x $IMG2<BR>" >> 00gif.html  ; done';
alias jpg='IMG="<img src=" ; IMG2="border=0 align=center>"; echo " ">00jpg.html; for x in *.jpg ; do echo "<BR><P>$x $IMG$x $IMG2<BR>" >> 00jpg.html  ; done';
alias rgb='cat /usr/openwin/lib/X11/rgb.txt | more'
alias y='echo Yeah, sure...'

alias scp='scp -p'

# move multiple files
autoload -U zmv
alias mmv='noglob zmv -W'

###########################################
##### zsh shortcuts for local use (Graylab)
###########################################

alias cdt='cd ~/tmp'
alias cdbindings='cd ~/svn/mini/src/python/bindings'
alias cddotfiles='cd ~/dotfiles'

# terminal shortcuts

function xsh
{
  xterm -title $1 -e ssh $@ &
}

# terminals

graylabIP=graylab.jhu.edu
graylab=jeff@graylab.jhu.edu
alias graylab='ssh -Y $graylab'
alias xgraylab='xsh $graylab'
louis=$graylab
louisIP=$graylabIP
alias louis='graylab'
alias xlouis='xgraylab'

# cluster
alias jazz="ssh jeff@jazz"
alias xjazz="xsh jeff@jazz"

alias psme='ps -ef|grep jeff'

# Texas
lonestar=jgray@lonestar.tacc.utexas.edu
alias lonestar="ssh jgray@lonestar.tacc.utexas.edu"
stampede=jgray@stampede.tacc.utexas.edu
alias stampede="ssh jgray@stampede.tacc.utexas.edu"
tacc=$stampede
alias tacc='stampede'
willie=jeff@willie.icmb.utexas.edu
alias willie='ssh jeff@willie.icmb.utexas.edu'

# MARCC
marcc=login.marcc.jhu.edu
alias marcc="ssh -X $marcc -l jgray21@jhu.edu"
# authenticate for multiple subsequent connections
alias marccauth="ssh -fNM $marcc -l jgray21@jhu.edu"

function quote () {
        echo Type the quote, ^C to end
        cat >> ~/docs/personal/quotes
        echo >> ~/docs/personal/quotes
        echo The end of the quotes file now reads:
        tail ~/docs/personal/quotes
}

##### mac shortcuts ####

alias bbedit='open -a bbedit'
alias pymol='open -a MacPyMOL'

##### pc shortcuts ####

alias charm="/mnt/c/Program\ Files/JetBrains/PyCharm\ 2019.3.3/bin/pycharm64.exe"

##################################################
##### research-related shortcuts
##################################################

# condor
alias cs='condor_submit'
alias cq='condor_q'
alias cqr='condor_q -run'
alias css='condor_status -submitters'
alias cst='condor_status'
alias cup='condor_userprio'

#sbatch
alias sqme="squeue -u jgray; squeue -u jgray | wc"

alias Rbatch='time nice R BATCH --no-restore --no-save'

#TACC aliases
export ROSETTA=~/git/Rosetta
if [[ `hostname` = *tacc* ]]; then
  export ROSETTA=$WORK/git/Rosetta
  alias isession='srun -p development -t 0:60:00 -n 1 -A 454HTPSeq --pty /bin/bash -l'
fi
export RABSCRIPTS=$ROSETTA/tools/antibody
export ROSETTA3_DB=$ROSETTA/main/database
export PATH=$PATH:$ROSETTA/main/source/bin
export PATH=$PATH:$RABSCRIPTS
export PATH=$PATH:$ROSETTA/tools/docking/pdb_scripts
export PATH=$PATH:$ROSETTA/tools/docking/scorefile_scripts
export PATH=$PATH:$ROSETTA/tools/protein_tools/scripts
#source $RABSCRIPTS/antibody_functions.zsh

# Ab aliases
alias cdA='cd $RABSCRIPTS'

# Rosetta paths
alias cdr='cd $ROSETTA/main/source'
alias cdr2='cd $ROSETTA\2/Rosetta/main/source'
alias cdx='cd $ROSETTA/main/source/xcode'
alias cdbuild='cd $ROSETTA/main/source/tools/build'
alias jsconsicc='time nohup ./scons.py -j 8 mode=release bin cxx=icc | tee scons.out.icc 2>&1 &'
alias jsconsiccmpi='      time nohup ./scons.py -j 8 mode=release bin extras=mpi cxx=icc | tee scons.out.iccmpi 2>&1 &'
alias jsconsiccmpimkl='time nohup ./scons.py -j 8 mode=release bin extras=mpi,mkl cxx=icc | tee scons.out.iccmpimkl 2>&1 &'
alias jsconsolungu='time  nohup ./scons.py -j 8 mode=release bin extras=mpi | tee scons.out.olungu 2>&1 &'
alias jsconslonestar='jsconsiccmpi'
alias jsconsstampede='jsconsiccmpimkl'
alias jsconsmac='./scons.py -j 4 mode=release bin'
alias jsconsdebug='./scons.py -j 4 mode=debug bin'

# git
alias status='git status'
alias mpa='cd $ROSETTA/main/source/xcode; python make_project.py all; bk'

set -o shwordsplit
export abtests='antibody_legacy antibody_graft antibody_H3 antibody_H3_legacy'
#export abtests='antibody_legacy antibody_CDR_grafting antibody_loop_modeling_protocol antibody_protocol_using_CCD_loop_mover antibody_protocol_using_KIC_loop_mover'
alias abintegrationtests='./integration.py -j4 $abtests'

setopt autocd
cdpath=($HOME $WORK $ROSETTA $HOME/Research $ROSETTA/main/tests $ROSETTA/main)

function cpadm() {
	for f in */*Combined.pdf
	do
	  dest=$(echo $f | sed -e 's/.*\///' -e 's/ - Combined//' -e 's/ /_/g')
	  echo cp "$f" "/Users/jeff/tmp/adm/$dest"
	  cp -p "$f" "/Users/jeff/tmp/adm/$dest"
	done
	#${1+$1/}*/grafting/details/${2:-H3}.fasta; do echo -n $f\ ;tail -1 $f | wc | awk {'print $3-1'} ; done
}

