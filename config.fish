set -x GOPATH /home/fiatjaf/comp/go
set -x GOROOT /usr/local/go
set -x PATH $PATH $GOROOT/bin
set -x PATH $PATH $GOPATH/bin

set -x MAIL /home/fiatjaf/Maildir/

set -x PATH $PATH /usr/local/git-annex.linux
alias 'ga-here' 'git annex find --in here'
alias 'ga-not-here' 'git annex find --not --in here'
alias 'ga-public' 'git annex find --in internet-archive-texts --or --in internet-archive-audios --or --in s3'
alias 'ga-not-public' 'git annex find --not --in internet-archive-texts --and --not --in internet-archive-audios --and --not --in s3'
alias 'ga-low-copies' 'git annex find --not --copies 3'
alias 'ga-only-here' 'git annex find --in here --and --not --copies 2'
alias 'ga-m' 'git annex metadata'
alias 'ga-f' 'git annex find'

alias 'transfer-jpg' 'curl https://transfer.sh/image.jpg --upload-file '

alias 'git-icdiff' 'git difftool --no-prompt --extcmd icdiff ($@)'

alias 'nock' 'ssh -t dokku@nock.alhur.es'

set -x CABAL_HOME /home/fiatjaf/.cabal
set -x PATH $CABAL_HOME/bin $PATH
set -x ELM_HOME /home/fiatjaf/Elm-Platform/0.15.1
set -x PATH $ELM_HOME/.cabal-sandbox/bin $PATH

source ~/.config/fish/keys.fish
