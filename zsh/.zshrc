# zmodload zsh/zprof

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Set package manager directory
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there
[ ! -d $ZINIT_HOME ] \
  && mkdir -p "$(dirname $ZINIT_HOME)" \
  && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"

source "${ZINIT_HOME}/zinit.zsh"

# Plugins
zinit ice depth=1; zinit light romkatv/powerlevel10k
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Load completions
autoload -U compinit && compinit
autoload bashcompinit && bashcompinit
complete -C '/usr/local/bin/aws_completer' aws

# Cheat sheet
fpath=(~/.zsh.d/ $fpath)

# Replay cached completions
zinit cdreplay -q

# Bindings
set -o emacs 
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
# Edit current command in $EDITOR
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^E' edit-command-line

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTUP=erase # Erases duplicates
setopt appendhistory # Append rather than overwrite
setopt sharehistory # Share between sessions
# Ignore duplicate commands
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' # Ignore case
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}" # Enable colors
zstyle ':completion:*' menu no # Disable default menu
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath' # Display directory preview

# Environment
export EDITOR='nvim'
export LSCOLORS='gxfxcxdxbxegedabagacad' # `man ls` for details
export AWS_PAGER=''

# Aliases
alias v='nvim'
alias ls='ls --color'
alias ll='ls -l --color'
alias la='ls -la --color'
alias c='clear'

g() {
  if [[ $# > 0 ]]; then
      git $@
  else
      git status
  fi
}

# Shell intergrations
eval "$(fzf --zsh)" # Enable fzf ^r
eval "$(fnm env --use-on-cd)" # Auto run fmn when a directory contains .node-version or .nvmrc
eval "$(thefuck --alias)"

# Open in intellij
intell() {
	open -a "intellij idea ce" $1
}

# to customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# zprof
