#alias tmux='tmux -2'
alias less='less -R'
alias diff='colordiff'
alias glog='git log --oneline --graph --color --all --decorate'
alias _='sudo'
alias fixmykey='sudo chmod 600 ~/.ssh/id_rsa'

# IP addresses
alias homeip="dig +short home.paulsturm.net"
alias localip="sudo ifconfig | grep -Eo 'inet (addr:)?([0-9]*\\.){3}[0-9]*' | grep -Eo '([0-9]*\\.){3}[0-9]*' | grep -v '127.0.0.1'"
alias ips="sudo ifconfig -a | grep -o 'inet6\\? \\(addr:\\)\\?\\s\\?\\(\\(\\([0-9]\\+\\.\\)\\{3\\}[0-9]\\+\\)\\|[a-fA-F0-9:]\\+\\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"

# Easier updates
update() {
	echo "Starting full system update..."
	sudo apt update -qq
	sudo dist-upgrade -yy
	sudo apt-get autoremove -yy
	echo "Update complete"
	return
}

# easier than man pages...
cheatsh() {
    curl cheat.sh/"$1"
}

alias randompass='cat /dev/urandom | tr -dc '\41-\176' | fold -w 12 | head'

# Easier navigation: .., ..., ...., ....., ~ and -
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'
alias ~='cd ~'
alias -- -='cd -'
alias 1='cd -'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'

# easy lists
alias ls='ls -lha --color=auto --group-directories-first'
alias grep='grep --color=auto'

# storage
# remaining storage
alias storage="df -h / --output=avail | tail -1 | xargs echo | sed 's/G/ GB/g'"
alias df='df -H'
alias du='du -ch'

# nano
alias nano='nano -w'

alias reboot='sudo reboot'

# One of @janmoesen’s ProTip™s
for method in GET HEAD POST PUT DELETE TRACE OPTIONS; do
	# shellcheck disable=SC2139,SC2140
	alias "$method"="lwp-request -m \"$method\""
done

# vhosts
alias hosts='sudo nano /etc/hosts'

# copy working directory
alias cwd='pwd | tr -d "\r\n" | xclip -selection clipboard'

# Basically, lets me know what just happened
# --interactive     prompt before overwrite
# --verbose         explain what is being done
alias cp="cp --interactive --verbose"
alias mv="mv --interactive --verbose"
alias rm="rm --verbose"

# make dir path
alias mkdir='mkdir -pv'

# Pretty print the path
alias path="echo $PATH | tr -s ':' '\n'"

# untar
alias untar='tar xvf'

# Pipe my public key to my clipboard.
alias pubkey="more ~/.ssh/id_rsa.pub | xclip -selection clipboard | echo '=> Public key copied to pasteboard.'"

# Pipe my private key to my clipboard.
alias prikey="more ~/.ssh/id_rsa | xclip -selection clipboard | echo '=> Private key copied to pasteboard.'"

alias timer='echo "Timer started. Stop with Ctrl-D." && date "+%a, %d %b %H:%M:%S" && time cat && date "+%a, %d %b %H:%M:%S"'

alias fdir='find . -type d -name'
alias ff='find . -type f -name'


# ------------------------------------
# Git alias and function
# ------------------------------------

# Go to the root of a project (git root)
alias root='cd $(git rev-parse --show-cdup)'
alias gitundo='git reset --hard && git clean -fd'
alias gs='git status'

# ------------------------------------
# Docker alias and function
# ------------------------------------

# Get latest container ID
alias dl="docker ps -l -q"

# Get container process
alias dps="docker ps"

# Get process included stop container
alias dpa="docker ps -a"

# Get images
alias di="docker images"

# Get container IP
alias dip="docker inspect --format '{{ .NetworkSettings.IPAddress }}'"

# Run deamonized container, e.g., $dkd base /bin/echo hello
alias dkd="docker run -d -P"

# Run interactive container, e.g., $dki base /bin/bash
alias dki="docker run -i -t -P"

# Execute interactive container, e.g., $dex base /bin/bash
alias dex="docker exec -i -t"

# Stop all containers
dstop() { docker stop $(docker ps -a -q); }

# Remove all containers
drm() { docker rm $(docker ps -a -q); }

# Stop and Remove all containers
alias drmf='docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q)'

# Remove all images
dri() { docker rmi $(docker images -q); }

# Dockerfile build, e.g., $dbu tcnksm/test 
dbu() { docker build -t=$1 .; }

# Show all alias related docker
dalias() { alias | grep 'docker' | sed "s/^\([^=]*\)=\(.*\)/\1 => \2/"| sed "s/['|\']//g" | sort; }

# Bash into running container
dbash() { docker exec -it $(docker ps -aqf "name=$1") bash; }

alias pgdb="cd ~/projects/trunk"
alias lucee="cd ~/projects/pgdb-lucee"


# >$ recent_mods . 10
# finds the 10 most recently modified files in the current directory
function recent_mods () { find "${1:-.}" -type f -printf '%TY-%Tm-%Td %TH:%TM %P\n' 2>/dev/null | sort | tail -n "${2:-10}"; }
