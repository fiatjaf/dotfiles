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
bindsym $mod+Return exec alacritty

# kill focused window
bindsym $mod+Shift+Q kill

# start rofi (a program launcher)
bindsym $mod+d exec "rofi -show combi"

# alternatively, you can use the cursor keys:
bindsym $mod+Left focus left
bindsym $mod+Down focus down
bindsym $mod+Up focus up
bindsym $mod+Right focus right

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
# bindsym $mod+s layout stacking
# bindsym $mod+w layout tabbed
# bindsym $mod+e layout default

# printscreen
bindsym Print exec scrot
bindsym $mod+Print exec scrot -u

# toggle tiling / floating
bindsym $mod+Shift+space floating toggle

# change focus between tiling / floating windows
# bindsym $mod+space focus mode_toggle

# focus the parent container
# bindsym $mod+a focus parent

# start at br layout
exec setxkbmap -layout br

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
        # back to normal: Enter or Escape
bindsym Return mode "default"
bindsym Escape mode "default"
}

bindsym $mod+r mode "resize"

for_window [window_role="pop-up"] floating enable

# Start i3bar to display a workspace bar (plus the system information i3status
# finds out, if available)
bar {
  status_command i3blocks
  tray_output none
}

exec --no-startup-id numlockx
exec --no-startup-id redshift -l -19:-43 -r
