# Including Local Bin Tool In The Path
PATH="$HOME/.local/bin:$PATH"

# Setting Editor As NeoVim
EDITOR="nvim"

# Exporting Term Colors To Xterm 
# Note: For Better Colors Change To "st-256color" if you have st installed
export TERM="xterm-256color"

[[ $- != *i* ]] && return

# A List Of Colors 
# To Run Type: colors
colors() {
	local fgc bgc vals seq0

	printf "Color escapes are %s\n" '\e[${value};...;${value}m'
	printf "Values 30..37 are \e[33mforeground colors\e[m\n"
	printf "Values 40..47 are \e[43mbackground colors\e[m\n"
	printf "Value  1 gives a  \e[1mbold-faced look\e[m\n\n"

	# foreground colors
	for fgc in {30..37}; do
		# background colors
		for bgc in {40..47}; do
			fgc=${fgc#37} # white
			bgc=${bgc#40} # black

			vals="${fgc:+$fgc;}${bgc}"
			vals=${vals%%;}

			seq0="${vals:+\e[${vals}m}"
			printf "  %-9s" "${seq0:-(default)}"
			printf " ${seq0}TEXT\e[m"
			printf " \e[${vals:+${vals+$vals;}}1mBOLD\e[m"
		done
		echo; echo
	done
}

[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion

# Change the window title of X terminals
case ${TERM} in
	xterm*|rxvt*|Eterm*|aterm|kterm|gnome*|interix|konsole*)
		PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\007"'
		;;
	screen*)
		PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\033\\"'
		;;
esac

use_color=true

# Set colorful PS1 only on colorful terminals.
# dircolors --print-database uses its own built-in database
# instead of using /etc/DIR_COLORS.  Try to use the external file
# first to take advantage of user additions.  Use internal bash
# globbing instead of external grep binary.
safe_term=${TERM//[^[:alnum:]]/?}   # sanitize TERM
match_lhs=""
[[ -f ~/.dir_colors   ]] && match_lhs="${match_lhs}$(<~/.dir_colors)"
[[ -f /etc/DIR_COLORS ]] && match_lhs="${match_lhs}$(</etc/DIR_COLORS)"
[[ -z ${match_lhs}    ]] \
	&& type -P dircolors >/dev/null \
	&& match_lhs=$(dircolors --print-database)
[[ $'\n'${match_lhs} == *$'\n'"TERM "${safe_term}* ]] && use_color=true

if ${use_color} ; then
	# Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
	if type -P dircolors >/dev/null ; then
		if [[ -f ~/.dir_colors ]] ; then
			eval $(dircolors -b ~/.dir_colors)
		elif [[ -f /etc/DIR_COLORS ]] ; then
			eval $(dircolors -b /etc/DIR_COLORS)
		fi
	fi

	if [[ ${EUID} == 0 ]] ; then
		PS1='\[\033[01;31m\][\h\[\033[01;36m\] \W\[\033[01;31m\]]\$\[\033[00m\] '
	else
		PS1='\[\033[01;32m\][\u@\h\[\033[01;37m\] \W\[\033[01;32m\]]\$\[\033[00m\] '
	fi

		grep='grep --colour=auto' \
		egrep='egrep --colour=auto' \
		fgrep='fgrep --colour=auto'
else
	if [[ ${EUID} == 0 ]] ; then
		# show root@ when we don't have colors
		PS1='\u@\h \W \$ '
	else
		PS1='\u@\h \w \$ '
	fi
fi

unset use_color safe_term match_lhs sh

xhost +local:root > /dev/null 2>&1

complete -cf sudo

# Bash won't get SIGWINCH if another process is in the foreground.
# Enable checkwinsize so that bash will check the terminal size when
# it regains control.  #65623
# http://cnswww.cns.cwru.edu/~chet/bash/FAQ (E11)
shopt -s checkwinsize

shopt -s expand_aliases

shopt -s autocd

# export QT_SELECT=4

# Enable history appending instead of overwriting.  #139609
shopt -s histappend

#
# # ex - archive extractor
# # usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# Get Ip Addresses
function ipc () {
  curl ipinfo.io/$1
}


### ALIASES ###

# root privileges
#alias doas="doas --"

# navigation
alias ..='cd ..' 
alias ...='cd ../..'
# vim
alias vim=nvim

# broot
alias br='br -dhp'
alias bs='br --sizes'

#Source .bashrc
alias sr='source ~/.bashrc'

# Add Grep Colors
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# Changing "ls" to "exa"
alias ll='lsd -al' # my preferred listing
alias la='lsd -a'  # all files and dirs
alias ls='lsd -l'  # long format
alias lt='lsd -a --tree' # tree listing
alias l="ls"

# yay shortcuts
alias src='yay -Ss'
alias ins='yay -S'
alias up='yay -Sy'
alias upd='yay -Syu'
alias rms='yay -R'
alias pcsrc='pacman -Ss'
alias pcin='sudo pacman -S'
alias pcr='sudo pacman -R'
alias sy='sudo pacman -Sy'
alias syu='sudo pacman -Syu'
alias syy='sudo pacman -Syy'
# Saving Time Typing 
alias gic='git clone' 
alias pg='ping'   # Extra

# Overwrite .Xresources To take effect of the new settings
alias xd='xrdb ~/.Xresources'


# Doom Emacs

alias emax='
export DISPLAY=:0.0
export LIBGL_ALWAYS_INDIRECT=1
setxkbmap -layout us
setsid emacs
exit
'

# Add A Special Env For My Laptop
alias scv='LIBGL_ALWAYS_SOFTWARE=1'
# adding flags
alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias du='du -h'
alias free='free -m'                      # show sizes in MB
alias lynx='lynx -cfg=~/.lynx/lynx.cfg -lss=~/.lynx/lynx.lss -vikeys'
alias vifm='./.config/vifm/scripts/vifmrun'

# More Aliases 
alias doc='cd ~/Documents'
alias dow='cd ~/Downloads'
alias ips="curl -s ifconfig.co | grep 'IP</span>:'| cut -d '<' -f 4 | sed 's/\/span>://'"

# Awesome Screen Locker
#alias bls="betterlockscreen -w /usr/share/backgrounds/archlinux/gritty.png -l -t 'Victory is Mine!'"

#check vulnerabilities microcode
alias microcode='grep . /sys/devices/system/cpu/vulnerabilities/*'

#get fastest mirrors in your neighborhood
alias mirror="sudo reflector --threads 10 -f 30 -l 30 --sort rate --number 10 --verbose --save /etc/pacman.d/mirrorlist"

#get the error messages from journalctl
alias jctl="journalctl -p 3 -xb"

# the terminal rickroll
alias rr='curl -s -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash'

# bare git repo alias for dotfiles
#alias config="/usr/bin/git --git-dir=$HOME/dotfiles --work-tree=$HOME"

# termbin
alias tb="nc termbin.com 9999"

### SET VI MODE IN BASH SHELL
set -o vi

### SET VIM AS MANPAGER ###
export MANPAGER="/bin/sh -c \"col -b | vim --not-a-term -c 'set ft=man ts=8 nomod nolist noma' -\""

#Recent Installed Packages
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"
alias riplong="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -3000 | nl"

### BASH INSULTER ###
if [ -f /etc/bash.command-not-found ]; then
    . /etc/bash.command-not-found
fi

### RANDOM COLOR SCRIPT ###
$HOME/.bin/shuffle.py

# PS1 Customization "~$ "
export PS1="\[\e[1;49;32m\]\W \[\e[m\]\[\e[1;49;96m\]\\$\[\e[1;49;39m\] "
#export PS1='\[\e[0m\]\[\e[48;5;236m\]\[\e[38;5;105m\]\u\[\e[38;5;105m\]@\[\e[38;5;105m\]\h\[\e[38;5;105m\] \[\e[38;5;221m\]\w\[\e[38;5;221m\]\[\e[38;5;105m\]\[\e[0m\]\[\e[38;5;236m\]\342\226\214\342\226\214\342\226\214\[\e[0m\]'
#export PS1='\[\e[31;1;48;234m\]\u \[\e[38;5;240m\]on \[\e[1;38;5;28;48;234m\]\h \[\e[38;5;54m\]\d \@\[\e[0m\]\n\[\e[38;5;105m\][\W] \[\e[1m\]\$\e[0m\] '
