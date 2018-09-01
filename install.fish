set here (pwd)
cd /tmp

# we need this before
sudo apt install aptitude -y

# basic things from apt
sudo aptitude install w3m numlockx ttf-ubuntu-font-family rxvt-unicode-256color curl tmux mosh silversearcher-ag vim git moreutils ncdu scrot jq tree xsel w3m-img redshift mediainfo poppler-utils hexchat build-essential make software-properties-common ubuntu-restricted-extras -y

# vim-plug
curl -s -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

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
sudo apt-get install rofi -y
sudo apt-get install chromium-browser -y
sudo apt-get install fish -y

# nodejs
if [ ! (which node) ]
  curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
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
npm install --global pnpm
pnpm install --global eslint_d

# entr
if [ ! (which entr) ]
  cd /tmp
  mkdir entr
  cd entr
  wget http://entrproject.org/code/entr-4.0.tar.gz
  tar -xvf entr-4.0.tar.gz
  rm entr-4.0.tar.gz
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

# python useful modules
if [ ! (which pipsi) ]
  curl https://raw.githubusercontent.com/mitsuhiko/pipsi/master/get-pipsi.py | python
end
if [ ! (which ranger) ]
  pipsi install --python (which python3) git+git://git.savannah.nongnu.org/ranger.git#egg=ranger
end
if [ ! (which icdiff) ]
  pipsi install icdiff
end
if [ ! (which buku) ]
  pipsi install buku
end
if [ ! (which black) ]
  pipsi install black
end
if [ ! (which pythonpy) ]
  pipsi install pythonpy
end

# standalone programs

# buku_run
if [ ! (which buku_run) ]
  wget https://github.com/carnager/buku_run/archive/master.zip -O buku_run.zip
  unzip buku_run.zip
  rm buku_run.zip
  cd buku_run-master
  sudo make install
  cd ..
  rm -r buku_run-master
end

# youtube-dl
if [ ! (which youtube-dl) ]
  sudo curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl
  sudo chmod a+rx /usr/local/bin/youtube-dl
else
  sudo youtube-dl -U
end

# pup
if [ ! (which pup) ]
  wget https://github.com/ericchiang/pup/releases/download/v0.4.0/pup_v0.4.0_linux_arm64.zip
  unzip pup_v0.4.0_linux_arm64.zip
  sudo mv pup /usr/local/bin/pup
  rm pup_v0.4.0_linux_arm64.zip
end

# latest golang
if [ ! (which go) ]
  wget (curl -s https://golang.org/dl/ | pup 'a[href*="linux"] attr{href}' | head -n 1)
  set t (ls go1.*)
  tar -xvf $t
  sudo mv go /usr/local/go
  rm $t
end

# latest ipfs
if [ ! (which ipfs) ]
  set u (curl -s dist.ipfs.io/ | pup 'a[href*="go-ipfs"] json{}' | jq -r 'map(select((.href | contains("64")) and (.href | contains("linux")))) | .[0].href')
  set u "https://dist.ipfs.io/$u"
  wget $u
  set t (ls go-ipfs*)
  tar -xvf $t
end

# fzf
if [ ! (which fzf) ]
  cd /usr/local
  sudo rm -r fzf
  sudo wget https://github.com/junegunn/fzf/archive/master.zip -O fzf.zip
  sudo unzip fzf.zip
  sudo rm fzf.zip
  sudo mv fzf-master fzf
  sudo ./fzf/install --all --no-zsh --no-bash
  cd -
end
