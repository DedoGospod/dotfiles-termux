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
HISTFILE=.zsh_history
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
alias wakepc='wol f0:2f:74:af:89:b7'
alias ls='ls -1 --color=always --group-directories-first'  # Colorized ls output
alias lsh='ls -A'           # Show all files including hidden
alias h='history 0 | grep'  # Search history for a specific terminal command
alias hist="history 0"      # Always show history with readable dates
alias interactivefzf='selected=$(fzf --preview="bat --color=always {}") && [ -n "$selected" ] && nv "$selected"' # interactive fzf
alias du='du -h'
alias df='df -h'
s() { if [ -z "$@" ]; then interactivefzf; else z "$@" && interactivefzf; fi; }    # Jumps to directory and then opens interactive fzf tool
zl() { if [ -z "$@" ]; then ls; else z "$@" && ls; fi; } # Automatically do an ls after each zl command

# Configs
alias zshrc='nvim ~/.zshrc'                            # Edit zsh config

# Plugins
source ~/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
