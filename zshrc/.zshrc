# Alias
alias cls='clear'
alias speedtest='speedtest-go'
alias nv='nvim'
alias du='du -h'
alias df='df -h'
alias ls='ls --color=auto'
alias lsh='ls -A'
alias wakepc='wol f0:2f:74:af:89:b7'

# Environmental variables
export EDITOR="nv"
export VISUAL="nv"

# Setup zoxide and starship
eval "$(zoxide init bash)" 
eval "$(starship init zsh)" 

# Initialize ZSH completion system
autoload -Uz compinit 
compinit -d "${ZSH_COMPDUMP}"  # Explicitly use our custom XDG-compliant path