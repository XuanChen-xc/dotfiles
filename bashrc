# ~/.bashrc
# Personal interactive Bash configuration.
# Designed to be portable across typical Linux development servers.

# Stop here for non-interactive shells.
case $- in
    *i*) ;;
      *) return ;;
esac

# -----------------------------------------------------------------------------
# History
# -----------------------------------------------------------------------------

# Ignore duplicate commands and commands beginning with a space.
HISTCONTROL=ignoreboth

# Append history rather than overwriting it when the shell exits.
shopt -s histappend

# Keep a generous amount of searchable command history.
HISTSIZE=100000
HISTFILESIZE=200000

# Write history after every command and reload commands written by other shells.
# This makes history much more useful when several terminals/tmux panes are open.
PROMPT_COMMAND="history -a; history -n${PROMPT_COMMAND:+; $PROMPT_COMMAND}"

# -----------------------------------------------------------------------------
# Shell behavior
# -----------------------------------------------------------------------------

# Update LINES and COLUMNS after terminal resize.
shopt -s checkwinsize

# Include dotfiles when expanding globs such as *.
# Leave disabled by default because it changes normal glob behavior.
# shopt -s dotglob

# Enable recursive ** globbing, e.g. **/*.py.
shopt -s globstar

# Make `less` friendlier for supported non-text files.
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# -----------------------------------------------------------------------------
# Prompt
# -----------------------------------------------------------------------------

# Identify Debian/Ubuntu chroot environments when applicable.
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

case "$TERM" in
    xterm-color|*-256color) color_prompt=yes ;;
esac

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt

# Set terminal title to user@host:working-directory when supported.
case "$TERM" in
    xterm*|rxvt*)
        PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
        ;;
esac

# -----------------------------------------------------------------------------
# Colors and aliases
# -----------------------------------------------------------------------------

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
fi

# File listing.
alias ll='ls -alhF'
alias la='ls -A'
alias l='ls -CF'

# Navigation.
alias ..='cd ..'
alias ...='cd ../..'

# Common Git shortcuts.
alias gs='git status'
alias gd='git diff'
alias gl='git log --oneline --graph --decorate -20'

# Safer defaults for interactive file operations.
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

# -----------------------------------------------------------------------------
# Personal aliases
# -----------------------------------------------------------------------------

# Put machine- or workflow-specific aliases here rather than modifying this file.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# -----------------------------------------------------------------------------
# Bash completion
# -----------------------------------------------------------------------------

if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

# -----------------------------------------------------------------------------
# Editor
# -----------------------------------------------------------------------------

# Use a simple terminal editor for commands such as `git commit` and `crontab -e`.
# Change this if you prefer another editor.
export EDITOR="${EDITOR:-nano}"
export VISUAL="${VISUAL:-$EDITOR}"

# -----------------------------------------------------------------------------
# Optional tools
# -----------------------------------------------------------------------------

# fzf shell integration, if installed via a setup that provides this file.
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
