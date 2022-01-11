set -x EDITOR nvim
if [ -n "$DISPLAY" ]
  set -x TERMINAL alacritty
  set -x TERM xterm-256color
end
set -x PAGER less

set -x GOPATH /home/fiatjaf/comp/go
set -x GOROOT /usr/local/go
set -x PATH $PATH $GOROOT/bin
set -x PATH $PATH $GOPATH/bin
set -x PATH $PATH $HOME/.pub-cache/bin

set -x GOPRIVATE git.zebedee.team

set -x DENO_INSTALL /home/fiatjaf/.deno
set -x PATH $DENO_INSTALL/bin $PATH
set -x PATH (yarn global bin) $PATH

set -x PATH $PATH $HOME/.cargo/bin

set -x NPM_PACKAGES $HOME/npm_modules
set -x PATH $PATH $HOME/npm_modules/bin $HOME/node_modules/bin
set -e MANPATH
set -x MANPATH (manpath) $NPM_PACKAGES/share/man

set -x MAIL /home/fiatjaf/Maildir/
set -x PYTHONSTARTUP ~/dotfiles/pythonrc

mkdir -p $HOME/.local/bin
set -x PATH $PATH $HOME/.local/bin

alias 'tmux' 'tmux -2'

touch ~/.config/fish/local.fish
source ~/.config/fish/local.fish

function nvim
  if [ "$IN_NEOVIM" = 'yes' ]
    echo 'cannot nest nvim sessions'
  else
    /usr/bin/nvim $argv
  end
end

function settitle
  printf "\033k$argv[1]\033\\"
end

function vipsql
  if [ (echo $argv | wc -w) = 1 ]
    nvim -c 'setlocal buftype=nofile | setlocal ft=sql | VipsqlOpenSession '"$argv"
  else
    nvim -c 'VipsqlOpenSession '"$argv[2]" "$argv[1]"
  end
end

function fish_right_prompt
  date +'%R'
end
