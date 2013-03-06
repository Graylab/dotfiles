#!/bin/zsh
# aliases JJG 2/2013

##################################################
##### bash shortcuts, universal
##################################################

# simple shell stuff
UNAME=`uname`
alias rm='rm -i'
#setenv CLICOLOR true # mac setting
alias ls='ls -FG'
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
if [ -f /usr/bin/nano ]; then alias pico='nano'; else alias nano='pico';fi
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

# make with more processors if SMP kernel
if uname -a | grep -iq smp
then
    alias make='nice -5 make -j6'
fi

#in du, measure in kilobytes, human readable
alias df='df -h'
alias du='du -kh'
# disk usage -- list only directories, and sort
function dubrief
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

############################################
##### bash shortcuts for local use (Graylab)
############################################

alias cdt='cd ~/tmp'
alias cdmac='cd ~/PyRosetta'
alias cdbindings='cd ~/svn/mini/src/python/bindings'
alias cddotfiles='cd ~/dotfiles'

setopt autocd
cdpath=($HOME $WORK $ROSETTA $HOME/Research)

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
satchmo=$graylab
satchmoIP=$graylabIP
alias satchmo='graylab'
alias xsatchmo='xgraylab'

# cluster
alias jazz="ssh jeff@jazz"
alias xjazz="xsh jeff@jazz"

alias psme='ps -ef|grep jeff'

# Texas
lonestar=jgray@lonestar.tacc.utexas.edu
alias lonestar="ssh jgray@lonestar.tacc.utexas.edu"
stampede=jgray@stampede.tacc.utexas.edu
alias stampede="ssh jgray@stampede.tacc.utexas.edu"
tacc=$lonestar
alias tacc='lonestar'

# enscript aliases: for pretty printing of code
# en2 = print code in 2-up pages
# this function calls en2 or en2f depending on whether we are in
# the rosetta directory (because in that directory, '.h' files
# should be printed in fortran format)
alias enscript2='enscript -fCourier7 --pretty-print --color -2r -DDuplex:true -DTumble:false --margins=30:30:30:30'
alias en2f='enscript2 --pretty-print=fortran'
function en2 () {
    if ( echo $PWD | grep -c rosetta > /dev/null )
#    if [ /users/jeff/rosetta* = $PWD ]
    then en2f $@
    else enscript2 $@
    fi
}

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


##################################################
##### research-related shortcuts
##################################################

# moved to .rosettarc

# condor
alias cs='condor_submit'
alias cq='condor_q'
alias cqr='condor_q -run'
alias css='condor_status -submitters'
alias cst='condor_status'
alias cup='condor_userprio'

#sbatch
alias sqme='squeue -u jgray -S N'

alias Rbatch='time nice R BATCH --no-restore --no-save'

# ChBE 409 aliases
alias 409='newgrp ChBE409; umask g+rwx'
alias no409='newgrp lab_users; umask g-w'
alias edit409='cd ~/public_html/courses/540.409/; emacs -geometry 120x80+1010+10 index.html &'

# Ab aliases
alias cdA='cd ~/Rosetta/scripts.v2'
alias cdrep='cd ~/Research/repertoires'

#TACC aliases
ROSETTA=~/Rosetta/rosetta
if [[ `hostname` = *lonestar* ]]; then
  ROSETTA=$WORK/svn/rosetta
elif [[ `hostname` = *stampede* ]]; then
  ROSETTA=$WORK/git/rosetta
fi
ROSETTA3_DB=$ROSETTA/rosetta_database

# Rosetta paths
alias cdr='cd $ROSETTA/rosetta_source'
alias cdbuild='cd $ROSETTA/rosetta_source/tools/build'
alias jsconsicc='time nohup ./scons.py -j 20 mode=release bin cxx=icc --nover | tee scons.out.icc 2>&1 &'
alias jsconsiccmpi='time nohup ./scons.py -j 20 mode=release extras=mpi cxx=icc bin | tee scons.out.iccmpi 2>&1 &'
alias jsconsolungu='time  nohup ./scons.py -j 20 mode=release extras=mpi bin --nover | tee scons.out.olungu 2>&1 &'

# Antibody shortcuts
#alias calcdecoytime='grep attempted out | awk "{j+=\$10;n+=\$6;print n,\$10, j, j/n;}"'
function calcdecoytime(){
	grep attempted $@ | awk "{j+=\$10;n+=\$6;print n,\$10, j, j/n;}"
}

# note: ${1+$1/} expands to $1/ if $1 exists, otherwise empty.  allows a directory prefix or not
function lastpdb() {
	for d in ${1+$1/}*/pdbs; do echo -n $d/; ls $d | tail -1; done	
}

function H3lengths() {
	for f in ${1+$1/}*/grafting/details/H3.fasta; do echo -n $f\ ;tail -1 $f | wc | awk {'print $3'} ; done
}

function H3list() {
	for f in ${1+$1/}*/grafting/details/H3.fasta; do echo -n $f\ ;tail -1 $f; done 
}

function H3lengthshist() {
	for f in ${1+$1/}*/grafting/details/H3.fasta; do tail -1 $f | wc | awk {'print $3'} ; done | sort -n | uniq -c
}
