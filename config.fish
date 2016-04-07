set fisher_home ~/comp/fisherman
set fisher_config ~/.config/fisherman
source $fisher_home/config.fish

set -x EDITOR vim
set -x TERMINAL rxvt-unicode

set -x GOPATH /home/fiatjaf/comp/go
set -x GOROOT /usr/local/go
set -x PATH $PATH $GOROOT/bin
set -x PATH $PATH $GOPATH/bin

set -x MAIL /home/fiatjaf/Maildir/

set -x PATH $PATH /usr/local/git-annex.linux

alias 'git-icdiff' 'git difftool --no-prompt --extcmd icdiff ($@)'
alias 'garret' 'ssh -t dokku@garret.alhur.es'
alias 'tmux' 'tmux -2'

if test -f /home/fiatjaf/.autojump/share/autojump/autojump.fish; . /home/fiatjaf/.autojump/share/autojump/autojump.fish; end

source ~/.config/fish/keys.fish
