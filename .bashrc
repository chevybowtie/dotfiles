######################################
# TIP: SEE TABLE in ~/.bash_profile
######################################
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

export PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/usr/share/games:/usr/local/sbin:/usr/sbin:/sbin
VERSION=v18.12.1
DISTRO=linux-x64
PATH="/usr/local/lib/nodejs/node-$VERSION-$DISTRO/bin:$PATH"

# git autocompletions for Ubuntu
source /usr/share/bash-completion/completions/git

# VS Code path
export PATH="$PATH:/mnt/c/Program Files/Microsoft VS Code/bin"

# Get External IP / Internet Speed
alias myip="curl https://ipinfo.io/json" # or /ip for plain-text ip
alias speedtest="curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python -"

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

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
    PS1="\[\033[0;31m\]\342\224\214\342\224\200\$([[ \$? != 0 ]] && echo \"[\[\033[0;31m\]\342\234\227\[\033[0;37m\]]\342\224\200\")[$(if [[ ${EUID} == 0 ]]; then echo '\[\033[01;31m\]root\[\033[01;33m\]@\[\033[01;96m\]\h'; else echo '\[\033[0;39m\]\u\[\033[01;33m\]@\[\033[01;96m\]\h'; fi)\[\033[0;31m\]]\342\224\200[\[\033[0;32m\]\w\[\033[0;31m\]]\n\[\033[0;31m\]\342\224\224\342\224\200\342\224\200\342\225\274 \[\033[0m\]\[\e[01;33m\]\\$\[\e[0m\]"
else
    PS1='┌──[\u@\h]─[\w]\n└──╼ \$ '
fi

# Set 'man' colors
if [ "$color_prompt" = yes ]; then
	man() {
	env \
	LESS_TERMCAP_mb=$'\e[01;31m' \
	LESS_TERMCAP_md=$'\e[01;31m' \
	LESS_TERMCAP_me=$'\e[0m' \
	LESS_TERMCAP_se=$'\e[0m' \
	LESS_TERMCAP_so=$'\e[01;44;33m' \
	LESS_TERMCAP_ue=$'\e[0m' \
	LESS_TERMCAP_us=$'\e[01;32m' \
	man "$@"
	}
fi

unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir - in WSL, this is the prompt
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]\[\033[0;31m\]\342\224\214\342\224\200\$([[ \$? != 0 ]] && echo \"[\[\033[0;31m\]\342\234\227\[\033[0;37m\]]\342\224\200\")[$(if [[ ${EUID} == 0 ]]; then echo '\[\033[01;31m\]root\[\033[01;33m\]@\[\033[01;96m\]\h'; else echo '\[\033[0;39m\]\u\[\033[01;33m\]@\[\033[01;96m\]\h'; fi)\[\033[0;31m\]]\342\224\200[\[\033[0;32m\]\w\[\033[0;31m\]]\n\[\033[0;31m\]\342\224\224\342\224\200\342\224\200\342\225\274 \!:\[\e[0;38;5;105m\]\t\[\e[0m\] \[\e[0;2;3;38;5;252m\]\$(parse_git_branch)\[\e[0m\] \[\033[0m\]\[\e[01;33m\]\\$\[\e[0m\]"
    ;;
*)
    ;;
esac


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





# nice dashboard
# $ sudo apt install toilet
# ...
# $ sudo apt install figlet
# ...
#!/bin/bash
# NAME: now
# PATH: $HOME/bin
# DESC: Display current weather, calendar and time
# CALL: Called from terminal or ~/.bashrc
# DATE: Apr 6, 2017. Modified: May 24, 2019.
# UPDT: 2019-05-24 If Weather unavailable nicely formatted error message.
# NOTE: To display all available toilet fonts use this one-liner:
#       for i in ${TOILET_FONT_PATH:=/usr/share/figlet}/*.{t,f}lf; do j=${i##*/}; toilet -d "${i%/*}" -f "$j" "${j%.*}"; done
# Setup for 92 character wide terminal
DateColumn=34 # Default is 27 for 80 character line, 34 for 92 character line
TimeColumn=61 # Default is 49 for   "   "   "   "    61 "   "   "   "
# Replace 76001 with your city name, zip code, GPS, etc. See: curl wttr.in/:help
curl wttr.in/76001?0Fu --silent --max-time 3 > /tmp/now-weather
# Timeout #. Increase for slow connection---^
readarray aWeather < /tmp/now-weather
rm -f /tmp/now-weather
# Was valid weather report found or an error message?
if [[ "${aWeather[0]}" == "Weather report:"* ]] ; then
    WeatherSuccess=true
    echo "${aWeather[@]}"
else
    WeatherSuccess=false
    echo "+============================+"
    echo "| Weather unavailable now    |"
    echo "| Check reason with command: |"
    echo "|                            |"
    echo "| curl wttr.in/76001?0Fu     |" # set your zip code here
    echo "|   --silent --max-time 3    |"
    echo "+============================+"
    echo " "
fi
echo " "                # Pad blank lines for calendar & time to fit
#--------- DATE -------------------------------------------------------------
# calendar current month with today highlighted.
# colors 00=bright white, 31=red, 32=green, 33=yellow, 34=blue, 35=purple,
#        36=cyan, 37=white
tput sc                 # Save cursor position.
# Move up 9 lines
i=0
while [ $((++i)) -lt 10 ]; do tput cuu1; done
if [[ "$WeatherSuccess" == true ]] ; then
    # Depending on length of your city name and country name you will:
    #   1. Comment out next three lines of code. Uncomment fourth code line.
    #   2. Change subtraction value and set number of print spaces to match
    #      subtraction value. Then place comment on fourth code line.
    Column=$((DateColumn - 10))
    tput cuf $Column        # Move x column number
    # Blank out ", country" with x spaces
    printf "          "
else
    tput cuf $DateColumn    # Position to column 27 for date display
fi
# -h needed to turn off formating: https://askubuntu.com/questions/1013954/bash-substring-stringoffsetlength-error/1013960#1013960
cal > /tmp/terminal1
# -h not supported in Ubuntu 18.04. Use second answer: https://askubuntu.com/a/1028566/307523
tr -cd '\11\12\15\40\60-\136\140-\176' < /tmp/terminal1  > /tmp/terminal
CalLineCnt=1
Today=$(date +"%e")
printf "\033[32m"   # color green -- see list above.
while IFS= read -r Cal; do
    printf "%s" "$Cal"
    if [[ $CalLineCnt -gt 2 ]] ; then
        # See if today is on current line & invert background
        tput cub 22
        for (( j=0 ; j <= 18 ; j += 3 )) ; do
            Test=${Cal:$j:2}            # Current day on calendar line
            if [[ "$Test" == "$Today" ]] ; then
                printf "\033[7m"        # Reverse: [ 7 m
                printf "%s" "$Today"
                printf "\033[0m"        # Normal: [ 0 m
                printf "\033[32m"       # color green -- see list above.
                tput cuf 1
            else
                tput cuf 3
            fi
        done
    fi
    tput cud1               # Down one line
    tput cuf $DateColumn    # Move 27 columns right
    CalLineCnt=$((++CalLineCnt))
done < /tmp/terminal
printf "\033[00m"           # color -- bright white (default)
echo ""
tput rc                     # Restore saved cursor position.
#-------- TIME --------------------------------------------------------------
tput sc                 # Save cursor position.
# Move up 8 lines
i=0
while [ $((++i)) -lt 9 ]; do tput cuu1; done
tput cuf $TimeColumn    # Move 49 columns right
# Do we have the toilet package?
if hash toilet 2>/dev/null; then
    echo " $(date +"%I:%M %P") " | \
        toilet -f future --filter border > /tmp/terminal
# Do we have the figlet package?
elif hash figlet 2>/dev/null; then
#    echo $(date +"%I:%M %P") | figlet > /tmp/terminal
    date +"%I:%M %P" | figlet > /tmp/terminal
# else use standard font
else
#    echo $(date +"%I:%M %P") > /tmp/terminal
    date +"%I:%M %P" > /tmp/terminal
fi
while IFS= read -r Time; do
    printf "\033[01;36m"    # color cyan
    printf "%s" "$Time"
    tput cud1               # Up one line
    tput cuf $TimeColumn    # Move 49 columns right
done < /tmp/terminal
tput rc                     # Restore saved cursor position.
# exit 0

git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

# get current branch in git repo
function parse_git_branch() {
        BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
        if [ ! "${BRANCH}" == "" ]
        then
                STAT=`parse_git_dirty`
                echo "[${BRANCH}${STAT}]"
        else
                echo ""
        fi
}

# get current status of git repo
function parse_git_dirty {
        status=`git status 2>&1 | tee`
        dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
        untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
        ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
        newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
        renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
        deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
        bits=''
        if [ "${renamed}" == "0" ]; then
                bits=">${bits}"
        fi
        if [ "${ahead}" == "0" ]; then
                bits="*${bits}"
        fi
        if [ "${newfile}" == "0" ]; then
                bits="+${bits}"
        fi
        if [ "${untracked}" == "0" ]; then
                bits="?${bits}"
        fi
        if [ "${deleted}" == "0" ]; then
                bits="x${bits}"
        fi
        if [ "${dirty}" == "0" ]; then
                bits="!${bits}"
        fi
        if [ ! "${bits}" == "" ]; then
                echo " ${bits}"
        else
                echo ""
        fi
}



# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
  for dir in "$HOME/bin"/*; do
    if [ -d "$dir" ]; then
      export PATH="$PATH:$dir"
    fi
  done
fi

VERSION=v18.12.1
DISTRO=linux-x64
PATH="/usr/local/lib/nodejs/node-$VERSION-$DISTRO/bin:$PATH"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('$HOME/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]; then
        . "$HOME/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="$HOME/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
