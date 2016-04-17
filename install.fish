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

# npm complicated global stuff
mkdir -p $HOME/npm_modules/bin
touch $HOME/.npmrc
if [ ! (cat ~/.npmrc | grep prefix) ]
  echo 'prefix=${HOME}/npm_modules' >> $HOME/.npmrc
end
sudo chown -R fiatjaf.fiatjaf /usr/local/lib/

# i3
if [ ! (which i3) ]
  sudo aptitude install i3 dmenu rxvt-unicode -y
end

# flux
if [ ! (which xflux) ]
  sudo ln -s "$here/apps/xflux" /usr/local/bin
end

# basic things
sudo aptitude install w3m rxvt-unicode-256color curl tmux atool mosh -y
sudo aptitude install jq -y
sudo aptitude install w3m-img -y
sudo aptitude install mediainfo poppler-utils -y
sudo aptitude install python-pygments -y
sudo pip install pythonpy
