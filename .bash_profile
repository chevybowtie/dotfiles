# `.bashrc` is the place to put stuff that applies only to bash
# itself, such as alias and function definitions, shell options,
# and prompt settings. (You could also put key bindings there, but
# for bash they normally go into `~/.inputrc`.)

# `.bash_aliases` is my extraction of all aliases (sourced in .bashrc)

# `.bash_exports` is my extraction of all exports (sourced in this file)

# `.profile` is the place to put stuff that applies to your whole
# session, such as programs that you want to start when you log in
# (but not graphical programs, they go into a different file), and
# environment variable definitions. This was the UNIX Bourne shell
# default start-up.

# `.bash_profile` can be used instead of `~/.profile`, but it is read
# by bash only, not by any other shell. (This is mostly a concern
# if you want your initialization files to work on multiple machines
# and your login shell isn't bash on all of them.) This is a logical
# place to include ~/.bashrc. If `.bash_profile` doesn't exist,
# bash also tries `.bash_login` before falling back to `.profile`

# According to the bash man page, `.bash_profile` is executed for login
# shells, while `.bashrc` is executed for interactive non-login shells.
# When you login (eg: type username and password) via console, either
# physically sitting at the machine when booting, or remotely via ssh:
# `.bash_profile` is executed to configure things before the initial
# command prompt. If you've already logged into your machine and open
# a new terminal window (xterm) inside Gnome or KDE, then .bashrc is
# executed before the window command prompt. .bashrc is also run when
# you start a new bash instance by typing /bin/bash in a terminal.

# https://shreevatsa.wordpress.com/2008/03/30/zshbash-startup-files-loading-order-bashrc-zshrc-etc/
# For Bash, read down the appropriate column. Executes A, then B, then
# C, etc. The B1, B2, B3 means it executes only the first of those files
# found.
#
#  +----------------+-----------+-----------+------+
#  |                |Interactive|Interactive|Script|
#  |                |login      |non-login  |      |
#  +----------------+-----------+-----------+------+
#  |/etc/profile    |   A       |           |      |
#  +----------------+-----------+-----------+------+
#  |/etc/bash.bashrc|           |    A      |      |
#  +----------------+-----------+-----------+------+
#  |~/.bashrc       |           |    B      |      |
#  +----------------+-----------+-----------+------+
#  |~/.bash_profile |   B1      |           |      |
#  +----------------+-----------+-----------+------+
#  |~/.bash_login   |   B2      |           |      |
#  +----------------+-----------+-----------+------+
#  |~/.profile      |   B3      |           |      |
#  +----------------+-----------+-----------+------+
#  |BASH_ENV        |           |           |  A   |
#  +----------------+-----------+-----------+------+
#  |~/.bash_logout  |    C      |           |      |
#  +----------------+-----------+-----------+------+
#

if [ -n "$TMUX" ]; then
    # called inside tmux session, do tmux things
    . ~/.profile
fi

# Trigger ~/.bashrc commands
. ~/.bashrc

# Trigger exports
if [ -f ~/.bash_exports ]; then
    . ~/.bash_exports
fi

# Ruby environment manager
# eval "$(rbenv init -)"

# untested - but looks useful
# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
# [ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;
cd ~
