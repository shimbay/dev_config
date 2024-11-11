#! /bin/bash
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
source /etc/profile

export LC_ALL=C.UTF-8
export LANG=C.UTF-8

# sudo apt install zsh
# sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
# git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting 
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="amuse"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )
# Uncomment the following line to use case-sensitive completion.  # CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# If command execution time above min. time, plugins will not output time.
ZSH_COMMAND_TIME_MIN_SECONDS=0

# # Message color.
# ZSH_COMMAND_TIME_COLOR="cyan"

# # Exclude some commands
ZSH_COMMAND_TIME_EXCLUDE=(vim mcedit tmux)

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	git
	command-time 			# git clone https://github.com/popstas/zsh-command-time.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/command-time
	zsh-autosuggestions		# git clone https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
	zsh-syntax-highlighting # git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

os=$(uname -s)
case $os in
	Linux)
		IP_INDEX=7
		;;
	Darwin)
		IP_INDEX=8
		;;
	*)
		echo "unknown os: $os"
		exit 1
		;;
esac

export MYIP="$(ip route get 8.8.8.8 | head -n 1 | cut -d " " -f ${IP_INDEX})"

export WORKSPACE="$HOME/workspace"
export DATA="$HOME/data"
export ICLOUD="$HOME/iCloud"

export PKG_CONFIG_PATH="$WORKSPACE/pkg-config/config:$PKG_CONFIG_PATH"

export CPPSRC="$WORKSPACE/src/cpp"

export GOPATH="$WORKSPACE/src/go"
export GOSRC="$GOPATH/src"
export GOPROXY="https://goproxy.cn/"
export GOPRIVATE="*.megvii-inc.com"

export PATH="$WORKSPACE/bin":$PATH
export PATH="$WORKSPACE/bin/go/bin":$PATH
export PATH="$WORKSPACE/bin/llvm/bin":$PATH
export PATH="$WORKSPACE/script":$PATH
export PATH="$ICLOUD/sync/script":$PATH
export PATH="$GOPATH/bin":$PATH
export PATH="$HOME/.local/bin":$PATH
export PATH="$HOME/.cargo/bin":$PATH
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
# export PATH="$HOME/miniconda3/bin:$PATH"  # commented out by conda initialize

export PYTHONPATH="$WORKSPACE/script"

export RUSTUP_UPDATE_ROOT="https://mirrors.ustc.edu.cn/rust-static/rustup"
export RUSTUP_DIST_SERVER="https://mirrors.ustc.edu.cn/rust-static"

alias ll='LC_COLLATE=C ls -alhF --group-directories-first'
alias la='ls -A'
alias l='ls -CF'

alias ws="cd $WORKSPACE"
alias dev="cd $WORKSPACE/dev"
alias src="cd $WORKSPACE/src"

alias public="cd $DATA/share"
alias icloud="cd $ICLOUD"

alias glog="git log --decorate --graph --pretty='format:%C(bold yellow)%h%C(bold red)%d %C(bold cyan)%an%Creset %C(magenta)(%ad)%n%C(247)Message: %s' --date=human"

alias v="fzf --print0 | xargs -0 -o vim"
alias st="git status"
alias co="git checkout"
alias br="git branch"
alias stash="git stash"
alias rbs="git merge-base HEAD master | xargs -I {} git rebase -i {} --reset-author-date"
alias cnt="git rebase --continue"
alias abr="git rebase --abort"
alias pull="git pull --rebase"
alias push="git push"
alias pushf="git push --force-with-lease"
alias fetch="git fetch"
alias ggc="git branch --merged | egrep -v \"(^\*|master|main|dev)\" | xargs git branch -d && git gc --aggressive --prune=now"

alias merge="git mergetool"
alias diff="git difftool"

customrc=$HOME/.customrc
if test -f "$customrc"; then
  source $customrc
fi

export PATH=$($HOME/.dedup.sh PATH)
export PYTHONPATH=$($HOME/.dedup.sh PYTHONPATH)
export PKG_CONFIG_PATH=$($HOME/.dedup.sh PKG_CONFIG_PATH)

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

cd $HOME

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/sunyunbo/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/sunyunbo/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/sunyunbo/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/sunyunbo/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

source <(fzf --zsh)

fzf_find_and_vim_open() {
  local file
  file=$(find . -type f | fzf --height 50% --reverse --exact --preview 'cat {}' || return)
  [[ -f $file ]] && vim "$file"
  zle reset-prompt
}
zle     -N   fzf_find_and_vim_open
bindkey '^n' fzf_find_and_vim_open

fzf_history() {
  local command
  command=$(history | fzf --height 50% --query="$BUFFER" +s --reverse --exact --tac || return)
  LBUFFER=$(echo $command | awk '{print substr($0, index($0, $2))}') # 去掉历史记录中的序号部分
  zle reset-prompt
}
zle     -N   fzf_history
bindkey '^r' fzf_history
