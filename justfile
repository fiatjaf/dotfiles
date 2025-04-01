global:
    echo 'this command hit the global justfile'

hotel:
    tmux new -s hotel -c ~/hotel-data -d
    tmux send-keys -t hotel 'just watch' ENTER
    tmux split-window -t hotel -c ~/hotel-data  -v
    tmux send-keys -t hotel 'just server' ENTER

casa:
    tmux new -s casa -c ~/casa -d
    tmux send-keys -t casa 'caddy file-server --browse --listen :4444' ENTER
    sudo ip addr add 192.168.1.77/24 dev enp7s0

servers:
    #!/usr/bin/env fish
    i3-msg 'workspace "5"; split h; exec "alacritty -e fish --login --init-command \'ssh njump journalctl -f --output cat\'"; exec "alacritty -e fish --login --init-command \'ssh erhard journalctl -f --output cat\'"; exec "alacritty -e fish --login --init-command \'ssh cantillon journalctl -f --output cat\'"'

dbus:
    #!/usr/bin/bash
    if command -v dbus-update-activation-environment >/dev/null 2>&1; then
        dbus-update-activation-environment DISPLAY XAUTHORITY;
    fi
