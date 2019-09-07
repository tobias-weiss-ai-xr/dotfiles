# Vars
	HISTFILE=~/.zsh_history
	SAVEHIST=1000 
	setopt inc_append_history # To save every command before it is executed 
	setopt share_history # setopt inc_append_history
	export KEYTIMEOUT=1 # set timeout for esc key to 0.1


#gurobi optimizer
if [[ $HOST = "ThinkPad.local.tobias-weiss.org" ]]; then
	source ~/dotfiles/zsh/gurobi.sh
fi

#ssh-agent settings
if [[ $HOST = "ThinkPad.local.tobias-weiss.org" ]]; then
	zstyle :omz:plugins:ssh-agent agent-forwarding on
	zstyle :omz:plugins:ssh-agent identities id_github id_uni id_rsa
	zstyle :omz:plugins:ssh-agent lifetime 4h
fi

	git config --global push.default current

# Aliases
	if [[ $HOST = "ThinkPad.local.tobias-weiss.org" ]]; then
		alias vi="nvim"
		alias vim="nvim"
		alias labor="ssh-add ~/.ssh/id_uni && ssh labor"
		alias speakers="rfkill unblock bluetooth && bluetoothctl power on && a2dp.py CC:98:8B:D1:BD:D2 -t 4 -w 1 -p hsp"
	fi

	mkdir -p /tmp/log
	
	# This is currently causing problems (fails when you run it anywhere that isn't a git project's root directory)
	# alias vs="v `git status --porcelain | sed -ne 's/^ M //p'`"

# Settings
	export VISUAL=vim

source ~/dotfiles/zsh/plugins/fixls.zsh

#Functions
	# Loop a command and show the output in vim
	loop() {
		echo ":cq to quit\n" > /tmp/log/output 
		fc -ln -1 > /tmp/log/program
		while true; do
			cat /tmp/log/program >> /tmp/log/output ;
			$(cat /tmp/log/program) |& tee -a /tmp/log/output ;
			echo '\n' >> /tmp/log/output
			vim + /tmp/log/output || break;
			rm -rf /tmp/log/output
		done;
	}

# Custom cd
chpwd() ls

# For vim mappings: 
	stty -ixon

# Completions
# These are all the plugin options available: https://github.com/robbyrussell/oh-my-zsh/tree/291e96dcd034750fbe7473482508c08833b168e3/plugins
#
# Edit the array below, or relocate it to ~/.zshrc before anything is sourced
# For help create an issue at github.com/parth/dotfiles

autoload -U compinit

plugins=(
	docker
)

for plugin ($plugins); do
    fpath=(~/dotfiles/zsh/plugins/oh-my-zsh/plugins/$plugin $fpath)
done

compinit

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
  vi-mode
  tmuxinator
)

## key chain config
#if [[ $HOST = "ThinkPad.local.tobias-weiss.org" ]]; then
#	eval `keychain --quiet --eval id_uni id_rsa id_github`
#else
#    eval `keychain --quiet --noask`
#fi

export PATH=$PATH:$HOME/dotfiles/utils
