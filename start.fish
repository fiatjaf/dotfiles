set here (pwd)

ln -sfT "$here/vim" $HOME/.vim
ln -sfT "$here/nvim" "$HOME/.config/nvim"
ln -sfT "$here/rofi.rasi" "$HOME/.config/rofi/config.rasi"
ln -sfT "$here/fish_functions" $HOME/.config/fish/functions
ln -sf "$here/config.fish" $HOME/.config/fish/config.fish
ln -sf "$here/bashrc" $HOME/.bashrc
ln -sf "$here/mailcap" $HOME/.mailcap
ln -sf "$here/muttrc" $HOME/.muttrc
ln -sf "$here/eslintrc.json" $HOME/.eslintrc.json
ln -sf "$here/tmux.conf" $HOME/.tmux.conf
ln -sf "$here/prettierrc.yaml" $HOME/.prettierrc.yaml
ln -sf "$here/jq" $HOME/.jq

mkdir -p $HOME/.i3
ln -sf "$here/i3" $HOME/.i3/config
ln -sf "$here/i3blocks" $HOME/.i3blocks.conf
ln -sf "$here/xdefault " $HOME/.Xdefaults
ln -sfT "$here/icons" $HOME/.icons

nvim +PlugInstall +qall
