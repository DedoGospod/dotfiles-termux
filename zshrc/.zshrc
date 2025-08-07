# Environmental variables
export EDITOR="nv"
export VISUAL="nv"

# Setup zoxide and starship
eval "$(zoxide init zsh)" 
eval "$(starship init zsh)" 

# Initialize ZSH completion system
autoload -Uz compinit 
compinit -d "${ZSH_COMPDUMP}"  # Explicitly use custom XDG-compliant path

# History settings configured to be XDG-compliant
HISTSIZE=10000                                   # Number of commands kept in memory
SAVEHIST=5000                                    # Number of commands saved to HISTFILE
setopt inc_append_history                        # Save commands to history immediately
setopt share_history                             # Sync history across sessions
setopt extended_history                          # Save timestamps
setopt hist_ignore_all_dups                      # Avoid saving any duplicate commands entirely

# Invalid commands dont get stored in history
zshaddhistory() {
  whence ${${(z)1}[1]} >| /dev/null || return 1
}

# Alias
alias cls='clear'
alias speedtest='speedtest-go'
alias nv='nvim'
alias du='du -h'
alias df='df -h'
alias ls='ls --color=auto'
alias lsh='ls -A'
alias wakepc='wol f0:2f:74:af:89:b7'