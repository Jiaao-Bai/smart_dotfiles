#vim ~/.zshrc
#source ~/.zshrc

# 初始化 zsh 补全系统
autoload -Uz compinit
compinit

alias gs='git status'
alias gr='git remote -v'
alias gl='git log'
alias gc='git commit'

# ls aliases
alias ll='ls -al'
alias la='ls -A'
alias l='ls -CF'

# OpenClaw Completion
source "/Users/baijiaao/.openclaw/completions/openclaw.zsh"

# ls aliases
alias ll='ls -al'
alias la='ls -A'
alias l='ls -CF'

# git aliases
alias gs='git status'
alias gr='git remote -v'
alias gl='git log'
alias gc='git commit'

# editor (update path to your nvim)
alias v='nvim'
