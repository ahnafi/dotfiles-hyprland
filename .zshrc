########################################
# CORE OH MY ZSH
########################################

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="daveverwer"

DISABLE_AUTO_UPDATE=true
ZSH_DISABLE_COMPFIX=true


########################################
# COMPLETION OPTIMIZATION
########################################

autoload -Uz compinit
compinit -C -d ~/.zcompdump


########################################
# PLUGINS MINIMAL DAN CEPAT
########################################

plugins=(
  git
  zsh-autosuggestions
  fast-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh


########################################
# ENVIRONMENT
########################################

export LANG=en_US.UTF-8
export PATH="$HOME/.local/bin:$PATH"
export EDITOR="nvim"

export PATH=~/.npm-global/bin:$PATH

########################################
# ALIASES
########################################

alias cls="clear"
alias neofetch="fastfetch"

alias gor="go run"
alias vim="nvim"

alias crd="composer run dev"
alias sens="sensors"

alias lgrep="ls -laps | grep"
alias p="pwd"

alias zshconfig="nvim ~/.zshrc"
alias nvimhypr="nvim ~/.config/hypr/hyprland.conf"

alias dstart="sudo systemctl start docker"
alias dstop="sudo systemctl stop docker.socket docker.service"

alias armbian='ssh stb'

alias sail='sh $([ -f sail ] && echo sail || echo vendor/bin/sail)'

alias pingg='ping 8.8.8.8'

