# Vars
	HISTFILE=~/.zsh_history
	SAVEHIST=1000 
	setopt inc_append_history # To save every command before it is executed 
	setopt share_history # setopt inc_append_history
	export KEYTIMEOUT=1 # set timeout for esc key to 0.1

# Aliases
	#alias vi="vim -p"
	alias vi="nvim"
	alias vim="nvim"
	alias labor="ssh-add ~/.ssh/id_uni && ssh labor"
	
	# This is currently causing problems (fails when you run it anywhere that isn't a git project's root directory)
	# alias vs="v `git status --porcelain | sed -ne 's/^ M //p'`"

# Settings
	export VISUAL=vim

source ~/dotfiles/zsh/plugins/fixls.zsh

#Functions
	# Custom cd
	c() {
		cd $1;
		ls;
	}
	alias cd="c"

# For vim mappings: 
	stty -ixon

source ~/dotfiles/zsh/plugins/oh-my-zsh/lib/history.zsh
source ~/dotfiles/zsh/plugins/oh-my-zsh/lib/key-bindings.zsh
source ~/dotfiles/zsh/plugins/oh-my-zsh/lib/completion.zsh
source ~/dotfiles/zsh/plugins/vi-mode.plugin.zsh
source ~/dotfiles/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/dotfiles/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/dotfiles/zsh/keybindings.sh

# Fix for arrow-key searching
# start typing + [Up-Arrow] - fuzzy find history forward
if [[ "${terminfo[kcuu1]}" != "" ]]; then
	autoload -U up-line-or-beginning-search
	zle -N up-line-or-beginning-search
	bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search
fi
# start typing + [Down-Arrow] - fuzzy find history backward
if [[ "${terminfo[kcud1]}" != "" ]]; then
	autoload -U down-line-or-beginning-search
	zle -N down-line-or-beginning-search
	bindkey "${terminfo[kcud1]}" down-line-or-beginning-search
fi

source ~/dotfiles/zsh/prompt.sh

# source cpufreq functions
source ~/dotfiles/zsh/cpufreq.sh

# load plugins
plugins=(
  git
  bundler
  dotenv
  #ssh-agent
  vi-mode
)

#ssh-agent settings
#zstyle :omz:plugins:ssh-agent agent-forwarding on
#zstyle :omz:plugins:ssh-agent identities ~/.ssh/id_github
#zstyle :omz:plugins:ssh-agent lifetime 4h
