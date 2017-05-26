set here (pwd)
cd /tmp

# we need this before
sudo apt-get install aptitude -y
sudo aptitude install build-essential make software-properties-common -y

# vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# vim themes
if [ ! -e ~/.vim/colors/jellybeans.vim ]
  mkdir -p ~/.vim/colors
  wget https://raw.githubusercontent.com/nanotech/jellybeans.vim/master/colors/jellybeans.vim -O ~/.vim/colors/jellybeans.vim
end

# update fish and chromium
sudo add-apt-repository ppa:canonical-chromium-builds/stage -y
sudo apt-add-repository ppa:fish-shell/release-2 -y
sudo apt-get update
sudo apt-get install chromium-browser -y
sudo apt-get install fish -y

# kakoune
if [ ! (which kak) ]
  sudo aptitude install libboost-dev libboost-regex-dev libncursesw5-dev asciidoc -y
  wget https://github.com/mawww/kakoune/archive/master.zip
  unzip master.zip
  cd kakoune-master/src
    make
    sudo make install
  cd -
  rm -rf kakoune-master
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
if [ ! (which eslint_d) ]
  npm install --global eslint_d
end
if [ ! (which instant) ]
  npm install --global instant-server
end
if [ ! (which seedshot) ]
  npm install --global seedshot
end
if [ ! (which js-yaml) ]
  npm install --global js-yaml
end

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
sudo aptitude install w3m numlockx ttf-ubuntu-font-family rxvt-unicode-256color curl tmux atool autossh mosh silversearcher-ag python-dev vim git moreutils ncdu scrot -y
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
if [ ! (which ranger) ]
  pipsi install --python (which python3) git+git://git.savannah.nongnu.org/ranger.git#egg=ranger
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
if [ ! (which youtube-dl) ]
  pipsi install youtube-dl
end
pipsi upgrade youtube-dl
