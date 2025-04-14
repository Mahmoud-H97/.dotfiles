# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

alias reit='echo "Hi, from the Research Engineering and Infrastructure Team!!!"'
alias reit-update='wget https://gitlab.ewi.tudelft.nl/reit/shell-config/-/raw/main/.bashrc-reit?ref_type=heads -O ~/.bashrc-reit'
alias reit-create-new-python-package='uvx copier copy git+https://gitlab.ewi.tudelft.nl/reit/python-package-template'

# Alias
alias ll='ls -alF'
alias la='ls -A'
alias ls='ls --color=auto'
alias l='ls -rtlh --full-time --color=auto'
alias md='mkdir'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias src='source ~/.bashrc'
alias vim='nvim .'
alias cls='clear'

#kitty && kitten
alias icat='kitten icat'

## Conda
alias ca='conda activate'
alias cel='conda env list'
alias cl='conda list'

### Alias to install Miniconda via wget and bash script execution with conda as package manager
alias install-miniconda='wget \
    https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && bash Miniconda3-latest-Linux-x86_64.sh -b \
    && rm -f Miniconda3-latest-Linux-x86_64.sh \
    && eval "$($HOME/miniconda3/bin/conda shell.bash  hook)"\
    && conda init'

### Alias to install Miniforge via wget and bash script execution with mamba as package manager
alias install-miniforge='
    wget https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-x86_64.sh \
    && bash Miniforge3-Linux-x86_64.sh -b \
    && rm -f Miniforge3-Linux-x86_64.sh \
    && eval "$($HOME/miniforge3/bin/conda shell.bash hook)" \
    && conda init \
    && conda install -n base -c conda-forge mamba'

### Alias to install Mircomamba dependency manager
alias install-micromamba='"${SHELL}" <(curl -L micro.mamba.pm/install.sh)'

### Alias to install Pixi dependency manager
alias install-pixi='curl -fsSL https://pixi.sh/install.sh | bash'

### Alias to install UV Python package manager
alias install-uv='curl -LsSf https://astral.sh/uv/install.sh | sh'

## Docker
alias docker-stop-all='sudo docker stop $(sudo docker ps -a -q)'
alias docker-rm-all='sudo docker rm $(sudo docker ps -a -q)'
alias docker-ls='sudo docker container ls'
alias docker-prune='sudo docker rm $(sudo docker images -q) -f && sudo docker system prune -f'


# History
## Append to the history file, don't overwrite it
shopt -s histappend
HISTSIZE=100000                                # Maximum number of lines kept in memory for the history list
HISTFILESIZE=100000                            # Maximum number of lines saved in the history file
export HISTIGNORE="ll:ls:la:cd*:[bf]g*:exit"   # List of patterns to ignore in history
export HISTCONTROL=erasedups                   # Ignore duplicates and leading/trailing whitespace when adding to history


# Functions
## Extract archives
extract () {
   if [ -f $1 ] ; then
       case $1 in
           *.tar.bz2)   tar xvjf $1    ;;
           *.tar.gz)    tar xvzf $1    ;;
           *.bz2)       bunzip2 $1     ;;
           *.rar)       unrar x $1       ;;
           *.gz)        gunzip $1      ;;
           *.tar)       tar xvf $1     ;;
           *.tbz2)      tar xvjf $1    ;;
           *.tgz)       tar xvzf $1    ;;
           *.zip)       unzip $1       ;;
           *.Z)         uncompress $1  ;;
           *.7z)        7z x $1        ;;
           *)           echo "don't know how to extract '$1'..." ;;
       esac
   else
       echo "'$1' is not a valid file!"
   fi
 }

## ls with full path e.g. `lsd .` ->  /home/username/my/path/my-file.txt
lsd() {
  while [ $# -gt 0 ]; do
  echo "`pwd`/$1"
  shift
  done
}


##Shell style

## ls colors (readable ls colors)
export LS_COLORS='rs=0:di=1;35:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lz=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.axv=01;35:*.anx=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.axa=00;36:*.oga=00;36:*.spx=00;36:*.xspf=00;36:*.las=00;36*.laz=00;36::';

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

##prompt style

# Define color variables
RED="\033[1;31m"
GREEN="\033[1;32m"
CYAN="\033[0;96m"
BLUE="\033[1;34m"
YELLOW="\033[1;33m"
RESET="\033[0m"

# Git prompt function
git_prompt_info() {
    local git_status=$(git status 2>/dev/null)
    local branch=$(echo "$git_status" | grep 'On branch' | sed 's/On branch //')
    if [[ -n $branch ]]; then
        if [[ $git_status == *"working tree clean"* ]]; then
            echo -e "git:(${RED}${branch}${BLUE})"
        elif [[ $git_status == *"Untracked files"* ]]; then
            echo -e "git:(${RED}${branch}${BLUE}) ${YELLOW}\xe2\x9c\x98"
        else
            echo -e "git:(${RED}${branch}${BLUE}) ${GREEN}\xe2\x9c\x98"
        fi
    fi
}

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    #PS1="${debian_chroot:+($debian_chroot)}${RED}↣ ↯ ⇝ ⇢ 🛰️🚀🛸📡🪐🌍👽 ${{GREEN}u${CYAN}@${GREEN}\h ${CYAN}\w ${BLUE}\$(git_prompt_info)${RESET} ""
    PS1="${debian_chroot:+($debian_chroot)}🛰️ ${CYAN}\w ${BLUE}\$(git_prompt_info)${RESET} "
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/mahmoudahmed/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/mahmoudahmed/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/mahmoudahmed/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/mahmoudahmed/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

export PATH="/home/mahmoudahmed/unison/bin:$PATH"

. "$HOME/.cargo/env"
