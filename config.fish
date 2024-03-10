set -x EDITOR nvim
if [ -n "$DISPLAY" ]
  set -x TERMINAL alacritty
  set -x TERM xterm-256color
end
set -x PAGER less

set -x GOPATH /home/fiatjaf/comp/go
set -x PATH $PATH $GOPATH/bin

set -x PATH $PATH $HOME/.pub-cache/bin

set -x GOPRIVATE git.zebedee.team

set -x DENO_INSTALL /home/fiatjaf/.deno
set -x PATH $DENO_INSTALL/bin $PATH

set -x PATH $PATH $HOME/.cargo/bin

set -x NPM_PACKAGES $HOME/npm_modules
set -x PATH $PATH $HOME/npm_modules/bin $HOME/node_modules/bin
set -e MANPATH
set -x MANPATH (manpath) $NPM_PACKAGES/share/man

set -x MAIL /home/fiatjaf/Maildir/
set -x PYTHONSTARTUP ~/dotfiles/pythonrc

set -x PATH $PATH $HOME/.local/share/coursier/bin

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

# kanagawa theme
set -l foreground DCD7BA
set -l selection 2D4F67
set -l comment 727169
set -l red C34043
set -l orange FF9E64
set -l yellow C0A36E
set -l green 76946A
set -l purple 957FB8
set -l cyan 7AA89F
set -l pink D27E99

# Syntax Highlighting Colors
set -g fish_color_normal $foreground
set -g fish_color_command $cyan
set -g fish_color_keyword $pink
set -g fish_color_quote $yellow
set -g fish_color_redirection $foreground
set -g fish_color_end $orange
set -g fish_color_error $red
set -g fish_color_param $purple
set -g fish_color_comment $comment
set -g fish_color_selection --background=$selection
set -g fish_color_search_match --background=$selection
set -g fish_color_operator $green
set -g fish_color_escape $pink
set -g fish_color_autosuggestion $comment

# Completion Pager Colors
set -g fish_pager_color_progress $comment
set -g fish_pager_color_prefix $cyan
set -g fish_pager_color_completion $foreground
set -g fish_pager_color_description $comment

# opam configuration
source /home/fiatjaf/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
