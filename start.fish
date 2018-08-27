set here (pwd)

ln -sfT "$here/vim" $HOME/.vim
ln -sf "$here/vimrc" $HOME/.vimrc
vim +PlugInstall +qall

mkdir -p $HOME/.config/ranger
ln -sf "$here/ranger-rc.conf" $HOME/.config/ranger/rc.conf
ln -sf "$here/ranger-scope.sh" $HOME/.config/ranger/scope.sh
ln -sf "$here/ranger-commands.py" $HOME/.config/ranger/commands.py
ln -sfT "$here/ranger-plugins" $HOME/.config/ranger/plugins/

ln -sf "$here/config.fish" $HOME/.config/fish/config.fish
ln -sfT "$here/fish_functions" $HOME/.config/fish/functions
ln -sf "$here/bashrc" $HOME/.bashrc
ln -sf "$here/mailcap" $HOME/.mailcap
ln -sf "$here/muttrc" $HOME/.muttrc
ln -sf "$here/eslintrc.json" $HOME/.eslintrc.json
ln -sf "$here/tmux.conf" $HOME/.tmux.conf
ln -sf "$here/prettierrc.yaml" $HOME/.prettierrc.yaml

mkdir -p $HOME/.config/hexchat
ln -sf "$here/hexchat/servlist.conf" $HOME/.config/hexchat/servlist.conf
ln -sf "$here/hexchat/hexchat.conf" $HOME/.config/hexchat/hexchat.conf
unzip -o "$here/hexchat/Monokai.hct" -d ~/.config/hexchat/

mkdir -p $HOME/.i3
ln -sf "$here/i3" $HOME/.i3/config
ln -sf "$here/i3blocks" $HOME/.i3blocks.conf
ln -sf "$here/urxvt" $HOME/.Xdefaults
ln -sf "$here/icons" $HOME/.icons
