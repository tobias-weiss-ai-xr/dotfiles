time_out () { perl -e 'alarm shift; exec @ARGV' "$@"; }

# Run tmux if exists
if command -v tmux>/dev/null; then
	# check tmux version and load alternative config for 2.9
	tmux_version=$(tmux -V)
	if [[ $tmux_version == "tmux 2.8" ]]; then
		[ -z $TMUX ] && exec tmux -f ~/dotfiles/tmux/tmux.conf
	else
		[ -z $TMUX ] && exec tmux -f ~/dotfiles/tmux/tmux29.conf
	fi
else 
	echo "tmux not installed. Run ./deploy to configure dependencies"
fi

#echo "Updating configuration"
#(cd ~/dotfiles && time_out 3 git pull && time_out 3 git submodule update --init --recursive)
#(cd ~/dotfiles && git pull && git submodule update --init --recursive)

if [ ! -s /tmp/zsh_updated ]
then
	echo "Checking for updates."
	({cd ~/dotfiles && git fetch -q} &> /dev/null)
	(echo `date` > /tmp/zsh_updated)

	if [ $({cd ~/dotfiles} &> /dev/null && git rev-list HEAD...origin/master | wc -l) = 0 ]
	then
		echo "Already up to date."
	else
		echo "Updates Detected:"
		({cd ~/dotfiles} &> /dev/null && git log ..@{u} --pretty=format:%Cred%aN:%Creset\ %s\ %Cgreen%cd)
		echo "Setting up..."
		({cd ~/dotfiles} &> /dev/null && git pull -q && git submodule update --init --recursive)
	fi
fi

source ~/dotfiles/zsh/zshrc.sh
