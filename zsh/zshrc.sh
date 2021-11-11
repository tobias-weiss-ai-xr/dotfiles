# Vars
HISTFILE=~/.zsh_history
SAVEHIST=1000 
setopt inc_append_history # To save every command before it is executed 
setopt share_history # setopt inc_append_history
export KEYTIMEOUT=1 # set timeout for esc key to 0.1
git config --global push.default current

if [[ $HOST = "tobi-yoga"  || $HOST = "tobi-legion" ]]; then
    setxkbmap -option caps:escape # map esc to capslock
    # Aliases
	alias vi="nvim"
	alias vim="nvim"
	alias lab="tmuxinator lab"
	alias ba="tmuxinator ba"
    alias gp="git checkout develop && git merge tobias && git push && git checkout master && git merge develop && git push && git checkout tobias"
	#alias labor="ssh-add ~/.ssh/id_uni && ssh labor"
	alias speakers="rfkill unblock bluetooth && bluetoothctl power on && a2dp.py CC:98:8B:D1:BD:D2 -t 4 -w 1 -p hsp"

    # >>> conda initialize >>>
    __conda_setup="${/usr/bin/conda shell.zsh hook 2> /dev/null)}"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "/usr/etc/profile.d/conda.sh" ]; then
            . "/usr/etc/profile.d/conda.sh"
        else
            export PATH="/usr/bin:$PATH"
        fi
    fi
    unset __conda_setup

fi

if [[ $HOST = "tobi-legion" ]]; then
	export PATH=${PATH}:${HOME}/dotfiles/utils:/home/weiss/bin:/home/weiss/.local/bin
	export VISUAL=/usr/bin/nvim
	export EDITOR=/usr/bin/nvim
    export PLANTUML_JAR=/home/weiss/bin/plantuml.jar
    export GRAPHVIZ_DOT=/usr/bin
    export CONDA_PKGS_DIRS=~/.conda/pkgs
    export WORKON_HOME=~/.virtualenvs
    export SPARK_HOME="/home/weiss/bin/spark-3.0.1-bin-hadoop2.7"
    export PYTHONPATH="${SPARK_HOME}/python:${SPARK_HOME}/python/lib/py4j-0.10.4-src.zip:${PYTHONPATH}"
    export PATH="${SPARK_HOME}/python:${PATH}"
    source /usr/bin/virtualenvwrapper.sh
	source ~/dotfiles/zsh/diablo2.sh # source diablo2 functions
    export JAVA_HOME=/usr/lib/jvm/java-15-jdk
fi

if [[ $HOST = "tobi-yoga" ]]; then
    xrandr --output HDMI-2 --auto --right-of eDP-1 # enable second display
	export PATH=$PATH:$HOME/dotfiles/utils:/home/weiss/.gem/ruby/2.7.0/bin:/home/weiss/.local/bin:/home/weiss/.dotnet/tools:/opt/ti/ccs1040
    export PATH="/usr/local/src/spark-3.0.1-bin-hadoop2.7/bin:${PATH}"
    export PATH="${SPARK_HOME}/python:${PATH}"
    export PATH="/opt/zoom:${PATH}"
    export PATH="${GUROBI_HOME}/bin:${PATH}"
    export PATH="/opt/cuda:${PATH}"
    export LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:${GUROBI_HOME}/lib"
	export VISUAL=/usr/bin/nvim
	export EDITOR=/usr/bin/nvim
    export NVIM_LISTEN_ADDRESS=/tmp/nvimsocket
    export SPARK_HOME="/usr/local/src/spark-3.0.1-bin-hadoop2.7"
    export PYTHONPATH="${SPARK_HOME}/python:${SPARK_HOME}/python/lib/py4j-0.10.4-src.zip:${PYTHONPATH}"
    export JAVA_HOME=/usr/lib/jvm/java-17-jdk
    export GUROBI_HOME="/opt/gurobi901/linux64"
	source ~/dotfiles/zsh/cpufreq.sh # source cpufreq functions
	source ~/dotfiles/zsh/diablo2.sh # source diablo2 functions
	source ~/dotfiles/zsh/openvpn.sh # source openvpn functions
    # check for miniconda and load if present
    [ -f /opt/miniconda3/etc/profile.d/conda.sh ] && source /opt/miniconda3/etc/profile.d/conda.sh
fi

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

mkdir -p /tmp/log

# This is currently causing problems (fails when you run it anywhere that isn't a git project's root directory)
# alias vs="v `git status --porcelain | sed -ne 's/^ M //p'`"


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

# load plugins
source ~/dotfiles/zsh/plugins/fixls.zsh
plugins=(
  git
  bundler
  dotenv
  vi-mode
  tmuxinator
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

##ssh-agent settings
#if [[ $HOST = "ThinkPad.local.tobias-weiss.org" ]]; then
##	zstyle :omz:plugins:ssh-agent agent-forwarding on
##	zstyle :omz:plugins:ssh-agent identities id_github id_uni id_rsa
##	zstyle :omz:plugins:ssh-agent lifetime 4h
#
## SSH Agent should be running, once
#runcount=$(ps -ef | grep "ssh-agent" | grep -v "grep" | wc -l)
#    if [ $runcount -eq 0 ]; then
#            echo Starting SSH Agent
#                eval $(ssh-agent -s)
#    fi
#
#fi

source ~/dotfiles/zsh/prompt.sh

## key chain config
#if [[ $HOST = "ThinkPad.local.tobias-weiss.org" ]]; then
#	eval `keychain --quiet --eval id_uni id_rsa id_github`
#else
#    eval `keychain --quiet --noask`
#fi

