# This file has been auto-generated by i3-config-wizard(1).
# It will not be overwritten, so edit it as you like.
#
# Should you change your keyboard layout somewhen, delete
# this file and re-run i3-config-wizard(1).
#

# i3 config file (v4)
#
# Please see http://i3wm.org/docs/userguide.html for a complete reference!

set $mod Mod4

# font for window titles. ISO 10646 = Unicode
font -misc-fixed-medium-r-normal--13-120-75-75-C-70-iso10646-1

# Use Mouse+$mod to drag floating windows to their wanted position
floating_modifier $mod

# start a terminal
bindsym $mod+Return exec i3-sensible-terminal

# kill focused window
bindsym $mod+Shift+Q kill

# start dmenu (a program launcher)
bindsym $mod+d exec rofi -show run

# change focus
bindsym $mod+j focus left
bindsym $mod+k focus down
bindsym $mod+l focus up
bindsym $mod+ccedilla focus right

# alternatively, you can use the cursor keys:
bindsym $mod+Left focus left
bindsym $mod+Down focus down
bindsym $mod+Up focus up
bindsym $mod+Right focus right

# move focused window
bindsym $mod+Shift+J move left
bindsym $mod+Shift+K move down
bindsym $mod+Shift+L move up
bindsym $mod+Shift+Ccedilla move right

# alternatively, you can use the cursor keys:
bindsym $mod+Shift+Left move left
bindsym $mod+Shift+Down move down
bindsym $mod+Shift+Up move up
bindsym $mod+Shift+Right move right

# split in horizontal orientation
bindsym $mod+h split h

# split in vertical orientation
bindsym $mod+v split v

# enter fullscreen mode for the focused container
bindsym $mod+f fullscreen

# change container layout (stacked, tabbed, default)
bindsym $mod+s layout stacking
bindsym $mod+w layout tabbed
bindsym $mod+e layout default

# toggle tiling / floating
bindsym $mod+Shift+space floating toggle

# change focus between tiling / floating windows
bindsym $mod+space focus mode_toggle

# focus the parent container
bindsym $mod+a focus parent

# window colors
client.focused          #222323 #444444 #888888
client.focused_inactive #222323 #222323 #888888
client.unfocused        #222323 #222323 #888888
client.urgent           #2f343a #8c644c #888888

# focus the child container
#bindcode $mod+d focus child

# switch to workspace
bindsym $mod+1 workspace 1
bindsym $mod+2 workspace 2
bindsym $mod+3 workspace 3
bindsym $mod+4 workspace 4
bindsym $mod+5 workspace 5
bindsym $mod+6 workspace 6
bindsym $mod+7 workspace 7
bindsym $mod+8 workspace 8
bindsym $mod+9 workspace 9
bindsym $mod+0 workspace 10

# move focused container to workspace
bindsym $mod+Shift+exclam move workspace 1
bindsym $mod+Shift+at move workspace 2
bindsym $mod+Shift+numbersign move workspace 3
bindsym $mod+Shift+dollar move workspace 4
bindsym $mod+Shift+percent move workspace 5
bindsym $mod+Shift+dead_diaeresis move workspace 6
bindsym $mod+Shift+ampersand move workspace 7
bindsym $mod+Shift+asterisk move workspace 8
bindsym $mod+Shift+parenleft move workspace 9
bindsym $mod+Shift+parenright move workspace 10

# reload the configuration file
bindsym $mod+Shift+C reload
# restart i3 inplace (preserves your layout/session, can be used to upgrade i3)
bindsym $mod+Shift+R restart
# exit i3 (logs you out of your X session)
bindsym $mod+Shift+E exit

# resize window (you can also use the mouse for that)
mode "resize" {
        # These bindings trigger as soon as you enter the resize mode

        # They resize the border in the direction you pressed, e.g.
        # when pressing left, the window is resized so that it has
        # more space on its left

bindsym j resize shrink left 10 px or 10 ppt
bindsym Shift+J resize grow   left 10 px or 10 ppt

bindsym k resize shrink down 10 px or 10 ppt
bindsym Shift+K resize grow   down 10 px or 10 ppt

bindsym l resize shrink up 10 px or 10 ppt
bindsym Shift+L resize grow   up 10 px or 10 ppt

bindsym ccedilla resize shrink right 10 px or 10 ppt
bindsym Shift+Ccedilla resize grow   right 10 px or 10 ppt

        # same bindings, but for the arrow keys
bindsym Left resize shrink left 10 px or 10 ppt
bindsym Shift+Left resize grow   left 10 px or 10 ppt

bindsym Down resize shrink down 10 px or 10 ppt
bindsym Shift+Down resize grow   down 10 px or 10 ppt

bindsym Up resize shrink up 10 px or 10 ppt
bindsym Shift+Up resize grow   up 10 px or 10 ppt

bindsym Right resize shrink right 10 px or 10 ppt
bindsym Shift+Right resize grow   right 10 px or 10 ppt

        # back to normal: Enter or Escape
bindsym Return mode "default"
bindsym Escape mode "default"
}

bindsym $mod+r mode "resize"
bindsym $mod+Shift+v exec ~/.vim-anywhere/bin/run

# Start i3bar to display a workspace bar (plus the system information i3status
# finds out, if available)
bar {
  status_command i3blocks
}

exec --no-startup-id pavucontrol
exec --no-startup-id syncthing
exec --no-startup-id numlockx
exec --no-startup-id rofi
exec --no-startup-id redshift -l -19:-43
exec --no-startup-id x-www-browser
