set here (pwd)

ln -sfT "$here/vim" $HOME/.vim
ln -sfT "$here/nvim" "$HOME/.config/nvim"
mkdir -p "$HOME/.config/rofi/"
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
ln -sf "$here/justfile" $HOME/.justfile
mkdir -p $HOME/.config/mpv
ln -sf "$here/mpv.conf" $HOME/.config/mpv/mpv.conf
mkdir -p $HOME/.config/btop
ln -sf "$here/btop.conf" $HOME/.config/btop/btop.conf
mkdir -p "$HOME/npm_modules"
ln -sf "$here/npmrc" $HOME/.npmrc

mkdir -p $HOME/.i3
ln -sf "$here/i3" $HOME/.i3/config
ln -sf "$here/i3blocks" $HOME/.i3blocks.conf
ln -sf "$here/xdefault " $HOME/.Xdefaults
ln -sfT "$here/icons" $HOME/.icons

nvim +PlugInstall +qall
