set -x EDITOR vim
if [ -n "$DISPLAY" ]
  set -x TERMINAL urxvt
  set -x TERM rxvt-unicode-256color
end

set -x GOPATH /home/fiatjaf/comp/go
set -x GOROOT /usr/local/go
set -x PATH $PATH $GOROOT/bin
set -x PATH $PATH $GOPATH/bin

set -x NPM_PACKAGES $HOME/npm_modules
set -x PATH $PATH $HOME/npm_modules/bin $HOME/node_modules/bin
set -e MANPATH
set -x MANPATH (manpath) $NPM_PACKAGES/share/man

set -x MAIL /home/fiatjaf/Maildir/
set -x PYTHONSTARTUP ~/dotfiles/pythonrc

mkdir -p $HOME/.local/bin
set -x PATH $PATH $HOME/.local/bin

alias 'git-icdiff' 'git difftool --no-prompt --extcmd icdiff ($@)'
alias 'tmux' 'tmux -2'

if test -f /home/fiatjaf/.autojump/share/autojump/autojump.fish; . /home/fiatjaf/.autojump/share/autojump/autojump.fish; end

touch ~/.config/fish/local.fish
source ~/.config/fish/local.fish

function settitle
  printf "\033k$argv[1]\033\\"
end

function vipsql
  if [ (echo $argv | wc -w) = 1 ]  
    vim -c 'setlocal buftype=nofile | setlocal ft=sql | VipsqlOpenSession '"$argv"
  else
    vim -c 'VipsqlOpenSession '"$argv[2]" "$argv[1]"
  end
end
