set here (pwd)
cd /tmp

# we need this before
sudo apt-get install aptitude -y
sudo aptitude install build-essential make software-properties-common -y
sudo aptitude install ubuntu-restricted-extras -y

# vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# vim themes
if [ ! -e ~/.vim/colors/jellybeans.vim ]
  mkdir -p ~/.vim/colors
  sudo chown -R fiatjaf.fiatjaf ~/.vim
  wget https://raw.githubusercontent.com/nanotech/jellybeans.vim/master/colors/jellybeans.vim -O ~/.vim/colors/jellybeans.vim
end

# update fish and chromium
sudo add-apt-repository ppa:canonical-chromium-builds/stage -y
sudo apt-add-repository ppa:fish-shell/release-2 -y
sudo add-apt-repository ppa:nilarimogard/webupd8
sudo apt-get update
sudo apt-get install albert -y
sudo apt-get install chromium-browser -y
sudo apt-get install fish -y
sudo apt-get install pandoc -y # why not?

# nodejs
if [ ! (which node) ]
  curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
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
npm install --global eslint-plugin-react
npm install --global instant-server
npm install --global seedshot
npm install --global js-yaml
npm install --global gtop

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
sudo aptitude install xinit i3 rxvt-unicode -y
if [ ! (which i3blocks) ]
  git clone git://github.com/vivien/i3blocks
  cd i3blocks
  make clean debug
  sudo make install
  cd -
end

# basic things from apt
sudo aptitude install w3m numlockx ttf-ubuntu-font-family rxvt-unicode-256color curl tmux atool autossh mosh silversearcher-ag python-dev vim git moreutils ncdu scrot -y
sudo aptitude install jq tree xsel -y
sudo aptitude install w3m-img redshift -y
sudo aptitude install mediainfo poppler-utils -y
sudo aptitude install python-pygments python-requests sysstat -y

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
