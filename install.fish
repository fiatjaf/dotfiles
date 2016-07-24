set here (pwd)
cd /tmp

# we need this before
sudo apt-get install aptitude -y
sudo aptitude install make -y

# vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# vim themes
if [ ! -e ~/.vim/colors/jellybeans.vim ]
  mkdir -p ~/.vim/colors
  wget https://raw.githubusercontent.com/nanotech/jellybeans.vim/master/colors/jellybeans.vim -O ~/.vim/colors/jellybeans.vim
end

# update fish
sudo apt-add-repository ppa:fish-shell/release-2 -y
sudo apt-get update
sudo apt-get install fish -y

# ranger
if [ ! (which ranger) ]
  git clone https://github.com/hut/ranger.git
  cd ranger
  sudo make install
  cd ..
end

# nodejs
if [ ! (which node) ]
  curl -sL https://deb.nodesource.com/setup_5.x | sudo -E bash -
  sudo apt-get install -y nodejs
end

# npm complicated global stuff
mkdir -p $HOME/npm_modules/bin
touch $HOME/.npmrc
if [ ! (cat ~/.npmrc | grep prefix) ]
  echo 'prefix=${HOME}/npm_modules' >> $HOME/.npmrc
end
sudo chown -R fiatjaf.fiatjaf /usr/local/lib/

# npm global packages
npm install --global eslint_d
npm install --global stylus
npm install --global instant-server

# entr
if [ ! (which entr) ]
  cd /tmp
  mkdir entr
  cd entr
  wget http://entrproject.org/code/entr-3.5.tar.gz
  tar -xvf entr-3.5.tar.gz
  rm entr-3.5.tar.gz
  cd *
  ./configure
  make
  sudo make install
  cd /tmp
end

# i3
if [ ! (which i3) ]
  sudo aptitude install i3 dmenu rxvt-unicode -y
end

# flux
if [ ! (which xflux) ]
  sudo ln -s "$here/apps/xflux" /usr/local/bin
end

# basic things from apt
sudo aptitude install w3m ttf-ubuntu-font-family rxvt-unicode-256color curl tmux atool mosh silversearcher-ag python-dev vim git moreutils -y
sudo aptitude install jq -y
sudo aptitude install w3m-img -y
sudo aptitude install mediainfo poppler-utils -y
sudo aptitude install python-pygments python-requests -y

# python useful modules
if [ ! (which pip) ]
  wget https://bootstrap.pypa.io/get-pip.py
  sudo python2 get-pip.py
end
if [ ! (which virtualenv) ]
  sudo pip install virtualenv
end
if [ ! (which pipsi) ]
  curl https://raw.githubusercontent.com/mitsuhiko/pipsi/master/get-pipsi.py | python2
end
if [ ! (which cheat) ]
  pipsi install cheat
end
if [ ! (which s3cmd) ]
  pipsi install s3cmd
end
if [ ! (which flake8) ]
  pipsi install flake8
end
if [ ! (which icdiff) ]
  pipsi install icdiff
end
pipsi install youtube-dl # let it run always, because updates are needed.
