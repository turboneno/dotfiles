# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color) color_prompt=yes;;
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
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
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

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

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
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
. /etc/bash_completion
fi
alias ins='sudo apt-get install'
alias add='sudo apt-get install'
alias rem='sudo apt-get autoremove --purge'
alias del='sudo apt-get autoremove --purge'
alias up='sudo apt-get update && sudo apt-get upgrade'
alias search='apt-cache search'
alias repo='sudo add-apt-repository'
alias musica='mocp -o s -v 80 && mocp -T moca_theme'
math(){ awk "BEGIN{ print $* }" ;}
rinomina(){
rename 'y/A-Z/a-z/' *
x=0; for i in *.avi; do let x++; mv -v $i $(printf "video_%03d.avi" $x); done
x=0; for i in *.jpg; do let x++; mv -v $i $(printf "%03d.jpg" $x); done
}
backup(){
wget -mk http://turboneno.posterous.com/ -P /home/moreno/.bup2.0/posterous
wget -mk http://cinepolentaecomputer.posterous.com/ -P /home/moreno/.bup2.0/cineposterous
if [ -e /media/disk ]
then
rsync -avr --delete /media/disk-2/ /media/disk/backup/disco
rsync -avr --delete /home/Musica/aaa/ /media/disk/backup/Musica/aaa
rsync -avr --delete /home/moreno/ /media/disk/backup/moreno
rsync -avr --delete /home/magazzino/ /media/disk/backup/magazzino
cp /home/moreno/.config/openbox/autostart.sh /media/disk/backup/conf/
cp /home/moreno/.config/openbox/menu.xml /media/disk/backup/conf/
cp /home/moreno/.config/openbox/rc.xml /media/disk/backup/conf/
cp /home/moreno/.conkyrc /media/disk/backup/conf/
cp /home/moreno/.conkyrc2 /media/disk/backup/conf/
cp /home/moreno/.vimrc /media/disk/backup/conf/
cp /home/moreno/.bashrc /media/disk/backup/conf/
tar -cf /media/disk/backup/note/note$(date +%Y%m%d).tar /home/moreno/Dropbox/note
else
echo “Connetti il disco esterno″
fi
}
function cdl { cd $1; ls;}
extract () {
  if [ -f $1 ] ; then
      case $1 in
          *.tar.bz2)   tar xvjf $1    ;;
          *.tar.gz)    tar xvzf $1    ;;
          *.tar.xz)    tar xvJf $1    ;;
          *.bz2)       bunzip2 $1     ;;
          *.rar)       unrar x $1     ;;
          *.gz)        gunzip $1      ;;
          *.tar)       tar xvf $1     ;;
          *.tbz2)      tar xvjf $1    ;;
          *.tgz)       tar xvzf $1    ;;
          *.zip)       unzip $1       ;;
          *.Z)         uncompress $1  ;;
          *.7z)        7z x $1        ;;
          *.xz)        unxz $1        ;;
          *.exe)       cabextract $1  ;;
          *)           echo "\`$1': unrecognized file compression" ;;
      esac
  else
      echo "\`$1' is not a valid file"
  fi
}
nota() {
  if [ -n "$*" ]; then
	nano "~/Dropbox/note/appunti mentali/$(date +%Y%m%d%H%M)_$*"
  else
	nano ~/Dropbox/note/appunti\ mentali/$(date +%Y%m%d%H%M)
  fi
}

cerca() {
  if [ -n "$*" ]; then
	ls -R ~/Dropbox/note/ | grep -i $*
  else
	echo "Dopo il comando devi dirmi cosa cercare"
  fi
}

trova() {
  if [ -n "$*" ]; then
	grep -irH $* ~/Dropbox/note/ | cut -d: -f1
  else
	echo "Dopo il comando devi dirmi cosa cercare"
  fi
}
alias notes="vim ~/Dropbox/note"
journal() {
	vim ~/Dropbox/note/journal/$(date +%Y%m%d%H%M)
}

wiki() {
dig +short txt $1.wp.dg.cx
}
