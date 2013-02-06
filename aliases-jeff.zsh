
#!/bin/bash

# aliases JJG 2/2013

##################################################
##### bash shortcuts, universal
##################################################

# simple shell stuff
# new: ls hides emacs backups, but la shows them (4/6/1)
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
alias cd='old=$PWD;cd '
alias bk='back=$old; cd $back; pwd; unset back'
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

HOST=$(uname -n | sed 's/\.[[:print:]]*//')
alias realias='source ~/.aliases;source ~/.rosettarc;
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
tacc=jgray@lonestar.tacc.utexas.edu
alias tacc="ssh jgray@lonestar.tacc.utexas.edu"

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

alias Rbatch='time nice R BATCH --no-restore --no-save'

# ChBE 409 aliases
alias 409='newgrp ChBE409; umask g+rwx'
alias no409='newgrp lab_users; umask g-w'
alias edit409='cd ~/public_html/courses/540.409/; emacs -geometry 120x80+1010+10 index.html &'

# Ab aliases
alias testAb='./antibody.py --heavy-chain ~/VH5.fasta --light-chain ~/VL5.fasta --antibody-assemble=/Users/jeff/Rosetta/rosetta/rosetta_source/bin/antibody_assemble_CDRs.macosgccrelease'
alias cdA='cd ~/Rosetta/scripts.v2'