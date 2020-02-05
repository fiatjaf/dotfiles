set here (pwd)

ln -sfT "$here/vim" $HOME/.vim
ln -sf "$here/vimrc" $HOME/.vimrc
nvim +PlugInstall +qall

ln -sf "$here/config.fish" $HOME/.config/fish/config.fish
ln -sfT "$here/fish_functions" $HOME/.config/fish/functions
ln -sf "$here/bashrc" $HOME/.bashrc
ln -sf "$here/mailcap" $HOME/.mailcap
ln -sf "$here/muttrc" $HOME/.muttrc
ln -sf "$here/eslintrc.json" $HOME/.eslintrc.json
ln -sf "$here/tmux.conf" $HOME/.tmux.conf
ln -sf "$here/prettierrc.yaml" $HOME/.prettierrc.yaml

mkdir -p $HOME/.config/nvim
ln -sf "$here/nvim-init.vim" "$HOME/.config/nvim/init.vim"

mkdir -p $HOME/.i3
ln -sf "$here/i3" $HOME/.i3/config
ln -sf "$here/i3blocks" $HOME/.i3blocks.conf
ln -sf "$here/urxvt" $HOME/.Xdefaults
ln -sfT "$here/icons" $HOME/.icons
