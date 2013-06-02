
# Histrory control
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.history

setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
#setopt SHARE_HISTORY

setopt EXTENDED_HISTORY

setopt HIST_IGNORE_DUPS HIST_IGNORE_ALL_DUPS HIST_SAVE_NO_DUPS HIST_FIND_NO_DUPS

setopt HIST_REDUCE_BLANKS

setopt HIST_IGNORE_SPACE

# To consider:
# EXTENDED_GLOB

setopt MULTIOS


# setopt CORRECT
# ^ work only on commands, kind of useless...

setopt AUTO_CD
# Maybe: setopt CD_ABLE_VARS

setopt AUTO_PUSHD
setopt PUSHD_MINUS
setopt PUSHD_IGNORE_DUPS
DIRSTACKSIZE=16



# setopt EXTENDED_GLOB
# set by default, non needed


# key binding for history search, not good because cursor pos is 0
#bindkey "^[[A" history-beginning-search-backward
#bindkey "^[[B" history-beginning-search-forward
bindkey "^[[A" up-line-or-history
bindkey "^[[B" down-line-or-history



# bindkey "^f" history-incremental-search-backward
# ^ already in place for ^r

# Making sure that forward delete and home/end works...
bindkey "^[[3~" delete-char
bindkey "^[[H"  beginning-of-line
bindkey "^[[F"  end-of-line

# Undo! Originally bound to ^_ (no need for shift!)


# Completion ---------------------------------------------
# do we need compinit?

autoload -U compinit && compinit
zmodload -i zsh/complist

setopt NO_LIST_BEEP
setopt COMPLETE_ALIASES
setopt COMPLETE_IN_WORD

unsetopt MENU_COMPLETE  # do not autoselect the first completion entry
setopt   AUTO_MENU      # show completion menu on succesive tab press

# setopt LIST_PACKED
# setopt LIST_ROWS_FIRST

## case-insensitive (all),partial-word and then substring completion
if [ "x$CASE_SENSITIVE" = "xtrue" ]; then
    zstyle ':completion:*' matcher-list 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
    unset CASE_SENSITIVE
else
    zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
fi


zstyle ':completion:*' list-colors ''
zstyle ':completion:*' menu select

# paint comand names in green for kill command
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;32=0=01'


bindkey -M menuselect '+' accept-and-menu-complete
bindkey -M menuselect '\' accept-and-infer-next-history
bindkey -M menuselect '^o' accept-and-infer-next-history

#autoload colors && colors

# PROMPT
# Colors: to make sure size work right surround any escape sequence with ‘%{’ at the start and ‘%}' at the end
# %(numX.true.false)
# %? - status of last command

# %2~ - keep only last two element of path
# %32<...<%~ - keep only 32 chars

# we need to make sure that PROMPT re-evaluated each time!
setopt PROMPT_SUBST

print_bang_if_error="%(?..%{%K{red}%F{black}!%k%f%G%})"

# aa="$(fooo)"

#screen_info="`[ -n "$STY" ] && echo " %{%b%K{white}%F{black}%}$STY%{%k%f%}"` "

# making sure our terminal setting is xterm-256
#export TERM=xterm-256color

screen_info_color=$'\e[0;38;5;117m'
function screen_info_raw() {
    if [ "${STY}" != "" ] ; then
	spl=("${(s/./)STY}")
	if [ "${#spl[@]}" -ge "2" ] ; then
	    name=$(printf ".%s" "${spl[@]:1}")
	    name=${name:1}
	else
	    name=$STY
	fi
	echo -n "$name"
    fi
}

function screen_info() {
    [ "${STY}" != "" ] && echo -n "%{%b%K{black}$screen_info_color%}⋆$(screen_info_raw)⋆%{%k%f%} "
}

function git_info() {
    rev=$(git symbolic-ref HEAD 2> /dev/null) || rev=$(git rev-parse --short HEAD 2> /dev/null) || return
    echo -n "%{%b%F{red}%}${rev#refs/heads/}"
    [[ -n $(git status --ignore-submodules=dirty -s -uno 2> /dev/null) ]] && echo -n '%{%B%}⚑'
    echo -n " %{%f%b%}"
}


# %(?..(%?%))  ← print error code
# Various line starters: ⋆⋅→←↑↓˚°º˙‼⚑⚐⚔◦•○●
# %{%K{black}%F{red}⋆%k%f%G%} ← start line with red star
#  %! ← print history number
# $print_bang_if_error
PROMPT='%{%F{green}%B%}%n@%m $(screen_info)%{%B%F{blue}%}%48<...<%~ $(git_info)%#%{%k%f%} '

# Defining funtion that change Terminal window title
# precmd () { print -Pn "\e]0;%n@%m:%~\a" }
precmd () {  # removing path because we never have space for it...
    if [ "${STY}" != "" ] ; then
	print -Pn "\e]0;$(screen_info_raw)\a"
    else
	print -Pn "\e]0;$STY%n@%m\a"
    fi
}

export CLICOLOR=1
export LSCOLORS='Exgxcxdxcxegedabagacad'


#alias ls='ls --color=auto'

alias dirs='dirs -v'

export EDITOR=mcedit


cd ~/work
