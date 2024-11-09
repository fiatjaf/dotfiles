global:
    echo 'this command hit the global justfile'

hotel:
    tmux new -s hotel -c ~/hotel-data -d
    tmux send-keys -t hotel 'just watch' ENTER
    tmux split-window -t hotel -c ~/hotel-data  -v
    tmux send-keys -t hotel 'just server' ENTER

servers:
    #!/usr/bin/env fish
    i3-msg 'workspace "5"; split h; exec "alacritty -e fish --login --init-command \'ssh njump journalctl -f --output cat\'"; exec "alacritty -e fish --login --init-command \'ssh erhard journalctl -f --output cat\'"; exec "alacritty -e fish --login --init-command \'ssh cantillon journalctl -f --output cat\'"'
