######################################
# TIP: SEE TABLE in ~/.bash_profile
######################################

#alias tmux='tmux -2'
alias less='less -R'
alias diff='colordiff'
alias _='sudo'
alias fixmykey='sudo chmod 600 ~/.ssh/id_rsa'
alias pls='sudo !!'

alias yarn='yarnpkg'

# IP addresses
alias homeip="dig +short home.paulsturm.net"
alias localip="ip -4 addr show | grep -oP '(?<=inet\s)\d+(\.\d+){3}' | grep -v '127.0.0.1'"

# Easier updates
update() {
	echo "Starting full system update..."
	sudo apt update -qq
	sudo dist-upgrade -yy
	sudo apt-get autoremove -yy
	echo "Update complete"
	return
}
alias alu='apt list --upgradeable'

# replace man for most cases
cheatsh(){
	curl cheat.sh/"$1"
}

# SUDO that for me
alias please="sudo $(history -p !!)"

# create a self-cleaning temp folder
alias tmp="cd $(mktemp -d )"


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

# logins
alias session_opened='sudo grep "session opened for user" /var/log/auth.log'
alias publickey_accepted='sudo grep "Accepted publickey" /var/log/auth.log'
alias password_accepted='sudo grep "Accepted password" /var/log/auth.log'
alias password_failed='sudo grep "Failed password" /var/log/auth.log'

# easy lists
alias ls='ls -lha --color=auto --group-directories-first'
alias grep='grep --color=auto'

# storage
# remaining storage
alias storage="df -h / --output=avail | tail -1 | xargs echo | sed 's/G/ GB/g'"
alias df='df -H'
alias du='du -ch'

# nano
alias nano='nano -l'

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

# Get External IP / Internet Speed
alias myip="curl https://ipinfo.io/json" # or /ip for plain-text ip
alias speedtest="curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python -"


# ------------------------------------
# Git alias and function
# ------------------------------------

# Go to the root of a project (git root)
alias root='cd $(git rev-parse --show-cdup)'
alias gitundo='git reset --hard && git clean -fd'
alias gs='git status'
alias glog='git log --oneline --graph --color --all --decorate'

# To avoid .git index corruption and preserve UTF-8 BOM
# Touches only those files (-ic0 option), that contain windows line breaks, all other files are skipped
alias fixlineendings='find . -type f -print0 | xargs -0 dos2unix -ic0 | xargs -0 dos2unix -b'

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

alias grepcontent='grep -rni'

# >$ recent_mods . 10
# finds the 10 most recently modified files in the current directory
function recent_mods () { find "${1:-.}" -type f -printf '%TY-%Tm-%Td %TH:%TM %P\n' 2>/dev/null | sort | tail -n "${2:-10}"; }

# remove the need to sudo for WordOps operations
alias wo='sudo -E wo'

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi





ollama() {
  # -----------------------------
  # Config (override via env vars)
  # -----------------------------
  local default_model="${OLLAMA_DEFAULT_MODEL:-gpt-oss}"
  local max_lines="${OLLAMA_MAX_LINES:-400}"        # stdin lines
  local max_chars="${OLLAMA_MAX_CHARS:-60000}"      # stdin chars (approx, after line trim)
  local stream_default="${OLLAMA_STREAM:-1}"        # 1=stream, 0=non-stream
  local host

  # -----------------------------
  # Host selection
  # -----------------------------
  if [ -n "$OLLAMA_REMOTE_HOST" ]; then
    host="$OLLAMA_REMOTE_HOST"
  elif curl -s --max-time 2 http://100.99.233.24:11434 > /dev/null; then
    host="100.99.233.24"
  elif curl -s --max-time 2 http://10.5.20.157:11434 > /dev/null; then
    host="10.5.20.157"
  elif curl -s --max-time 1 http://localhost:11434 > /dev/null; then
    host="localhost"
  else
    echo "❌ Could not reach an Ollama server (local or remote)" >&2
    return 1
  fi

  # -----------------------------
  # Help
  # -----------------------------
  if [ $# -eq 0 ] || [[ "$1" == "-h" || "$1" == "--help" ]]; then
    cat <<EOF
Usage:
  ollama [MODEL] "PROMPT"              # send prompt
  ollama [MODEL] "PROMPT" < logfile    # include stdin as log content

Options:
  --no-stream         Disable streaming; print once at end
  --stream            Force streaming (default)
  --max-lines N       Max stdin lines to include (default: $max_lines)
  --max-chars N       Max stdin chars to include (default: $max_chars)

Env:
  OLLAMA_REMOTE_HOST      Force host (instead of probing)
  OLLAMA_DEFAULT_MODEL    Default model (default: $default_model)
  OLLAMA_MAX_LINES        Default max stdin lines
  OLLAMA_MAX_CHARS        Default max stdin chars
  OLLAMA_STREAM           1=stream default, 0=non-stream

Examples:
  tail -n 500 /var/log/syslog | ollama gpt-oss "What is the root cause? Cite evidence lines."
  ollama llama3 "Summarize errors and propose fixes" < /var/log/myapp.log
  ollama --no-stream gpt-oss "Give me a 5-bullet summary" < /var/log/nginx/error.log
EOF
    return 0
  fi

  # -----------------------------
  # Parse options (simple)
  # -----------------------------
  local stream="$stream_default"
  while [[ "$1" == --* ]]; do
    case "$1" in
      --no-stream) stream=0; shift ;;
      --stream)    stream=1; shift ;;
      --max-lines) max_lines="$2"; shift 2 ;;
      --max-chars) max_chars="$2"; shift 2 ;;
      *)
        echo "❌ Unknown option: $1" >&2
        return 2
        ;;
    esac
  done

  # -----------------------------
  # Args: MODEL + PROMPT
  # -----------------------------
  local model prompt
  if [ $# -eq 1 ]; then
    model="$default_model"
    prompt="$1"
  else
    model="$1"
    prompt="$2"
  fi

  # -----------------------------
  # Read stdin (if any) with truncation
  # -----------------------------
  if [ ! -t 0 ]; then
    # 1) limit lines first (keeps "recent context" if you feed with tail)
    # 2) limit chars second (approximate safety)
    local stdin_content
    stdin_content="$(cat | tail -n "$max_lines" | head -c "$max_chars")"

    prompt="$prompt"$'\n\n'"--- BEGIN STDIN (truncated: max_lines=$max_lines, max_chars=$max_chars) ---"$'\n'"$stdin_content"$'\n'"--- END STDIN ---"
  fi

  # -----------------------------
  # Build safe JSON payload via jq
  # -----------------------------
  local payload
  payload="$(jq -n \
    --arg model "$model" \
    --arg prompt "$prompt" \
    --argjson stream "$([[ "$stream" == "1" ]] && echo true || echo false)" \
    '{model:$model, prompt:$prompt, stream:$stream}')"

  # -----------------------------
  # Call API
  # -----------------------------
  if [ "$stream" -eq 1 ]; then
    # Streaming: each line is a JSON object; print .response chunks as they arrive.
    # If there is an error, it may appear in one of the JSON objects.
    curl -s "http://$host:11434/api/generate" \
      -H "Content-Type: application/json" \
      -d "$payload" \
    | while IFS= read -r line; do
        # Skip blank lines
        [ -z "$line" ] && continue

        # Print any error and stop
        if echo "$line" | jq -e '.error' >/dev/null 2>&1; then
          echo -e "\n❌ Error: $(echo "$line" | jq -r '.error')" >&2
          return 1
        fi

        # Print response chunk (no newline)
        echo "$line" | jq -r -c '.response // empty' | tr -d '\n'
      done
    echo
  else
    # Non-streaming: single response JSON
    local response
    response="$(curl -s "http://$host:11434/api/generate" \
      -H "Content-Type: application/json" \
      -d "$payload")"

    if echo "$response" | jq -e '.error' >/dev/null 2>&1; then
      echo "❌ Error: $(echo "$response" | jq -r '.error')" >&2
      return 1
    fi

    echo "$response" | jq -r -c '.response' | tr -d '\n'; echo
  fi
}
