set here (pwd)
cd /tmp

# vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# vim themes
mkdir -p ~/.vim/colors/jellybeans.vim
wget https://raw.githubusercontent.com/nanotech/jellybeans.vim/master/colors/jellybeans.vim -O ~/.vim/colors

# ranger
if [ ! (which ranger) ]
  git clone https://github.com/hut/ranger.git
  cd ranger
  sudo make install
  cd ..
end

# update fish
sudo apt-add-repository ppa:fish-shell/release-2 -y
apt-get update
sudo apt-get install fish -y

# i3
if [ ! (which i3) ]
  sudo aptitude install i3 dmenu rxvt-unicode -y
end

# flux
if [ ! (which xflux) ]
  sudo ln -s "$here/apps/xflux" /usr/local/bin
end

# basic things
sudo aptitude install curl jq deluge tmux -y
sudo pip install pythonpy -y
