set -x EDITOR vim
set -x TERMINAL urxvt

set -x GOPATH /home/fiatjaf/comp/go
set -x GOROOT /usr/local/go
set -x PATH $PATH $GOROOT/bin
set -x PATH $PATH $GOPATH/bin

set -x NPM_PACKAGES $HOME/node_modules
set -x PATH $PATH $NPM_PACKAGES/bin
set -e MANPATH
set -x MANPATH (manpath) $NPM_PACKAGES/share/man

set -x MAIL /home/fiatjaf/Maildir/

set -x PATH $PATH /usr/local/git-annex.linux

alias 'git-icdiff' 'git difftool --no-prompt --extcmd icdiff ($@)'
alias 'garret' 'ssh -t dokku@garret.alhur.es'
alias 'tmux' 'tmux -2'

if test -f /home/fiatjaf/.autojump/share/autojump/autojump.fish; . /home/fiatjaf/.autojump/share/autojump/autojump.fish; end

touch ~/.config/fish/local.fish
source ~/.config/fish/local.fish
