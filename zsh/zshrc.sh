# vars
export KEYTIMEOUT=1 # set timeout for esc key to 0.1
HISTFILE=~/.zsh_history
SAVEHIST=1000 
setopt inc_append_history # To save every command before it is executed 
setopt share_history
git config --global push.default current

if [[ $HOST = "tobi-yoga"  || $HOST = "tobi-legion" ]]; then
    setxkbmap -option caps:escape # map esc to capslock
    # to reset
    # setxkbmap -layout de -option
    # Aliases
	alias vi="nvim"
	alias vim="nvim"
	alias lab="tmuxinator lab"
	#alias ba="tmuxinator ba"
    #alias gp="git checkout develop && git merge tobias && git push && git checkout master && git merge develop && git push && git checkout tobias"
	#alias labor="ssh-add ~/.ssh/id_uni && ssh labor"

    source ~/dotfiles/zsh/toggle_sony.sh
    alias sony="toggle_sony_state"
    alias sink="toggle_sony_profile"

    #wacom
    alias wacom="mapwacom -d 'Wacom Intuos PT M Pen stylus' -d 'Wacom Intuos PT M Pen eraser'  -s 'HDMI-0'"

    # pyenv
    export PYENV_ROOT="$HOME/.pyenv"
    [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"

    # >>> conda initialize >>>
    # !! Contents within this block are managed by 'conda init' !!
    __conda_setup="$('/home/weiss/.pyenv/versions/mambaforge/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "/home/weiss/.pyenv/versions/mambaforge/etc/profile.d/conda.sh" ]; then
            . "/home/weiss/.pyenv/versions/mambaforge/etc/profile.d/conda.sh"
        else
            export PATH="/home/weiss/.pyenv/versions/mambaforge/bin:$PATH"
        fi
    fi
    unset __conda_setup

fi


if [[ $HOST = "tobi-legion" ]]; then
	export PATH=${PATH}:${HOME}/dotfiles/utils:/home/weiss/.local/bin:${HOME}/.cargo/bin
    #export PATH="/usr/local/src/pycharm-2021.3.2/bin:${PATH}"
    export PATH="/opt/asdf-vm/bin:${PATH}"
    export PATH="/home/weiss/JLUBox-bin:${PATH}"
	export VISUAL=/usr/bin/nvim
	export EDITOR=/usr/bin/nvim
    export GRAPHVIZ_DOT=/usr/bin
    source /usr/bin/virtualenvwrapper.sh
	source ~/dotfiles/zsh/diablo2.sh # source diablo2 functions
    #export JAVA_HOME=/usr/lib/jvm/java-15-jdk
    #export WORKON_HOME=~/.virtualenvs
    export ASDF_DIR="/opt/asdf-vm"

    # >>> mamba initialize >>>
    # !! Contents within this block are managed by 'mamba init' !!
    export MAMBA_EXE="/home/weiss/.local/bin/micromamba";
    export MAMBA_ROOT_PREFIX="/home/weiss/micromamba";
    __mamba_setup="$("$MAMBA_EXE" shell hook --shell zsh --prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__mamba_setup"
    else
        if [ -f "/home/weiss/micromamba/etc/profile.d/micromamba.sh" ]; then
            . "/home/weiss/micromamba/etc/profile.d/micromamba.sh"
        else
            export  PATH="/home/weiss/micromamba/bin:$PATH"  # extra space after export prevents interference from conda init
        fi
    fi
    unset __mamba_setup
    # <<< mamba initialize <<<
fi

if [[ $HOST = "tobi-yoga" ]]; then
	export PATH=$PATH:$HOME/dotfiles/utils:/home/weiss/.gem/ruby/2.7.0/bin:/home/weiss/.local/bin:/home/weiss/.cargo/bin
    export PATH="/opt/zoom:${PATH}"
    export PATH="/usr/local/bin:${PATH}"
    #export PATH="/opt/cuda:${PATH}"
    #export PATH="/usr/local/src/pycharm-2021.3.2/bin:${PATH}"
	export VISUAL=/usr/bin/nvim
	export EDITOR=/usr/bin/nvim
    export NVIM_LISTEN_ADDRESS=/tmp/nvimsocket
    export JAVA_HOME=/usr/lib/jvm/java-18-jdk
	source ~/dotfiles/zsh/cpufreq.sh # source cpufreq functions
	source ~/dotfiles/zsh/diablo2.sh # source diablo2 functions
	source ~/dotfiles/zsh/openvpn.sh # source openvpn functions
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
source ~/dotfiles/zsh/prompt.sh

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


## key chain config
#if [[ $HOST = "ThinkPad.local.tobias-weiss.org" ]]; then
#	eval `keychain --quiet --eval id_uni id_rsa id_github`
#else
#    eval `keychain --quiet --noask`
#fi

