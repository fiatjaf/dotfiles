set here (pwd)

ln -sf "$here/config.fish" $HOME/.config/fish/config.fish
ln -sf "$here/vim" $HOME/.vim
ln -sf "$here/vimrc" $HOME/.vimrc
ln -sf "$here/bashrc" $HOME/.bashrc
ln -sf "$here/mailcap" $HOME/.mailcap
ln -sf "$here/muttrc" $HOME/.muttrc
ln -sf "$here/ranger-rc.conf" $HOME/.config/ranger/rc.conf
ln -sf "$here/ranger-scope.sh" $HOME/.config/ranger/scope.sh

if not test -d ~/.vim/bundle/Vundle.vim
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    vim +PluginInstall +qall
end
